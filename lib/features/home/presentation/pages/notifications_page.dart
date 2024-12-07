import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/decoration/app_decoration.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/styles/custom_text_style.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/bookings_tab/presentation/pages/booking_details.dart';
import 'package:masaj/features/home/data/models/message_model.dart';
import 'package:masaj/features/home/data/models/notification.dart';
import 'package:masaj/features/home/presentation/bloc/notificaions_cubit/notifications_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/notificaions_cubit/notifications_state.dart';

import '../../../../core/presentation/theme/theme_helper.dart';

class NotificationsPage extends StatelessWidget {
  static const routeName = '/NotificationsPage';

  const NotificationsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
        child: Scaffold(
      appBar: CustomAppBar(
        title: AppText.my_notifications,
        actions: [buildClearAllNotificationsButton(context)],
        centerTitle: false,
      ),
      body: BlocProvider<NotificationsCubit>(
        create: (context) => DI.find<NotificationsCubit>()..loadNotifications(),
        child: Builder(
          builder: (context) => CustomAppPage(
            safeTop: true,
            backgroundColor: Colors.white,
            child: Scaffold(
              body: Column(children: [
                //_buildAppBar(context),
                SizedBox(
                  height: 24,
                ),
                Expanded(child: _buildBody(context)),
              ]),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state.isError && state.message?.isNotEmpty == true) {
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
        if (state?.notifications?.isNotEmpty != true) {
          return EmptyPageMessage(
            message: AppText.no_notifications,
            textColor: Colors.black,
            onRefresh: () async {},
            // onRefresh: cubit.refresh,
            heightRatio: 0.8,
          );
        }

        return LazyLoadScrollView(
          // onEndOfPage: cubit.loadMoreNotifications,
          onEndOfPage: () {},
          isLoading: state.isLoadingMore,
          child: RefreshIndicator(
            color: Colors.black,
            // onRefresh: cubit.refresh,
            onRefresh: () async {
              cubit.refresh();
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemCount: state!.notifications!.length + 1,
              itemBuilder: (context, index) {
                if (index == state!.notifications!.length) {
                  return _buildPaginationLoading();
                }
                final notificationItem = state!.notifications![index];
                return _NotificationCard(notificationItem: notificationItem);
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildClearAllNotificationsButton(BuildContext context, {VoidCallback? onPop}) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
          child: Text(
            AppText.lbl_clear_all,
            style: CustomTextStyles.titleSmallBluegray40001.copyWith(
              color: AppColors.FONT_COLOR,
            ),
          ),
        ),
      );
    });
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
      TitleText(
        text: AppText.my_notifications,
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

  final MessagesModel notificationItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (notificationItem.id != null && notificationItem.seen != true)
          await context.read<NotificationsCubit>().markAsRead(notificationItem.id ?? 0);
        final int? bookingId = int.tryParse(notificationItem.additionalData?['bookingId'] ?? '');
        if (bookingId != null) Navigator.of(context).pushNamed(BookingDetialsScreen.routeName, arguments: bookingId);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Material(
            elevation: 0,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: Container(
              color: notificationItem.seen != true ? AppColors.ExtraLight : AppColors.White,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
              child: Row(
                children: [
                  notificationItem.seen != true
                      ? Container(
                          width: 10, height: 10, decoration: AppDecoration.gradientSecondaryContainerToPrimary.copyWith(shape: BoxShape.circle))
                      : SizedBox(
                          width: 5,
                        ),
                  SizedBox(
                    width: 6,
                  ),
                  SvgPicture.asset(
                    'assets/images/notification_card_icon.svg',
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*TitleText.medium(
                        text: notificationItem.title ?? '',
                        color: Colors.black,
                      ),*/
                        SubtitleText.small(
                          text: notificationItem.body ?? '',
                          color: AppColors.Font,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
            /* ListTile(
            horizontalTitleGap: 0,
            leading: notificationItem.seen != false
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
              text: notificationItem.title ?? '',
              color: Colors.black,
            ),
            subtitle: SubtitleText.small(
              text: notificationItem.body ?? '',
              color: Colors.black,
            ),
          ),*/
            ),
      ),
    );
  }
}
