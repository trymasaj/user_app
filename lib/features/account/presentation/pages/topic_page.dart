import '../../../../core/enums/topic_type.dart';
import '../../../../core/utils/navigator_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../../../res/style/app_colors.dart';
import '../blocs/topics_cubit/topics_cubit.dart';

import '../../../../di/injector.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TopicPage extends StatelessWidget {
  static const routeName = '/TopicPage';
  const TopicPage({
    super.key,
    required this.id,
  });

  final TopicType id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().topicsCubit..getTopicsData(id),
      child: CustomAppPage(
        safeTop: true,
        safeBottom: false,
        backgroundColor: Colors.white,
        child: Scaffold(
          body: Column(
            children: [
              _buildTopSection(context),
              Expanded(child: _buildTopicContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicContent(BuildContext context) {
    return BlocConsumer<TopicsCubit, TopicsState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
      },
      builder: (context, state) {
        if (state.isInitial || state.isLoading)
          return const CustomLoading(loadingStyle: LoadingStyle.Default);
        return _buildTopicDetails(
          context,
          content: state.topicContent?.content,
        );
      },
    );
  }

  Widget _buildTopicDetails(
    BuildContext context, {
    String? content,
  }) {
    final cubit = context.read<TopicsCubit>();

    return Column(
      children: [
        TitleText(
          text: _getSuitableTitle(id),
          color: Colors.black,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => cubit.refresh(id),
            color: AppColors.PRIMARY_COLOR,
            backgroundColor: AppColors.ACCENT_COLOR,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: content?.isNotEmpty != true
                  ? EmptyPageMessage(
                      message: 'no_data_found',
                      onRefresh: () => cubit.refresh(id),
                    )
                  : _buildAboutUsText(content!),
            ),
          ),
        ),
      ],
    );
  }

  String _getSuitableTitle(TopicType id) {
    switch (id) {
      case TopicType.AboutUs:
        return 'about_us'.tr();
      case TopicType.Privacy:
        return 'privacy_policy'.tr();
      case TopicType.Terms:
        return 'terms_of_use'.tr();
      default:
        throw Exception('Invalid TopicType');
    }
  }

  Widget _buildAboutUsText(String data) {
    return Html(
      data: data,
      style: {
        "body": Style(color: Colors.black),
      },
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/res/assets/app_logo.png',
                height: 80.0,
              ),
            ],
          ),
        ),
        PositionedDirectional(
          start: 16.0,
          top: 32.0,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 32.0,
            ),
            color: Colors.white,
            onPressed: NavigatorHelper.of(context).pop,
          ),
        )
      ],
    );
  }
}
