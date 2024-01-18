import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:masaj/features/home/data/models/notification.dart';
import 'package:masaj/features/home/presentation/bloc/notificaions_cubit/notifications_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/notificaions_cubit/notifications_state.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';

import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';

class NotificationsPage extends StatelessWidget {
  static const routeName = '/NotificationsPage';
  const NotificationsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
      create: (context) => Injector().notificationsCubit..loadNotifications(),
      child: Builder(
        builder: (context) => CustomAppPage(
          safeTop: true,
          backgroundColor: Colors.white,
          child: Scaffold(
            body: Column(children: [
              _buildAppBar(context),
              Expanded(child: _buildBody(context)),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state.isError) {
          showSnackBar(context, message: state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<NotificationsCubit>();

        if (state.isLoading || state.isInitial) {
          return const CustomLoading(
            color: AppColors.ACCENT_COLOR,
            loadingStyle: LoadingStyle.ShimmerList,
          );
        }
        if (state.allNotification?.notifications?.isNotEmpty != true) {
          return EmptyPageMessage(
            message: 'no_notifications',
            textColor: Colors.black,
            onRefresh: cubit.refresh,
            heightRatio: 0.8,
          );
        }

        return LazyLoadScrollView(
          onEndOfPage: cubit.loadMoreNotifications,
          isLoading: state.isLoadingMore,
          child: RefreshIndicator(
            color: Colors.black,
            onRefresh: cubit.refresh,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: state.allNotification!.notifications!.length + 1,
              itemBuilder: (context, index) {
                if (index == state.allNotification!.notifications!.length) {
                  return _buildPaginationLoading();
                }
                final notificationItem =
                    state.allNotification!.notifications![index];
                return _NotificationCard(notificationItem: notificationItem);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: NavigatorHelper.of(context).pop,
      ),
      const Spacer(),
      const TitleText(
        text: 'my_notifications',
        color: Colors.black,
      ),
      const Spacer(),
      const SizedBox(
        width: 40,
      )
    ]);
  }

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: context.watch<NotificationsCubit>().state.isLoadingMore
            ? const CustomLoading(
                loadingStyle: LoadingStyle.Pagination,
                color: Colors.black,
              )
            : const SizedBox(),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notificationItem,
  });

  final Notification notificationItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        elevation: 1.4,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: ListTile(
          horizontalTitleGap: 0,
          leading: notificationItem.seen != true
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.redAccent,
                    )
                  ],
                )
              : null,
          title: TitleText.medium(
            text: notificationItem.title!,
            color: Colors.black,
          ),
          subtitle: SubtitleText.small(
            text: notificationItem.message!,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
