import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/di/injector.dart';
import 'package:masaj/features/intro/presentation/blocs/quiz_page_cubit/quiz_page_cubit.dart';
import 'package:masaj/features/intro/presentation/pages/quiz_page.dart';
import 'package:masaj/res/style/app_colors.dart';
import 'package:masaj/shared_widgets/stateful/default_button.dart';
import 'package:masaj/shared_widgets/stateless/custom_app_page.dart';
import 'package:masaj/shared_widgets/stateless/custom_text.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../home/presentation/pages/home_page.dart';

class QuizStartPage extends StatelessWidget {
  const QuizStartPage({super.key});
  static const routeName = '/QuizPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().quizPageCubit..loadQuizPage(),
      child: Builder(builder: (context) {
        return CustomAppPage(
          withBackground: true,
          child: Scaffold(
              backgroundColor: Colors.transparent, body: _buildBody(context)),
        );
      }),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildQuizStartPageTitle(),
        _buildGetStartButton(context),
        _buildSkipButton(context),
      ],
    );
  }

  CustomText _buildQuizStartPageTitle() {
    return const CustomText(
      text: 'quiz_start_page_title',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      textAlign: TextAlign.center,
      margin: EdgeInsets.symmetric(horizontal: 44),
    );
  }

  Widget _buildGetStartButton(BuildContext context) {
    return DefaultButton(
      label: 'get_started',
      isExpanded: true,
      color: Colors.white,
      textColor: AppColors.FONT_COLOR,
      margin: const EdgeInsets.only(
        top: 24,
        left: 80,
        right: 80,
      ),
      onPressed: () {
        _goToQuizPage(context);
      },
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    final cubit = context.read<QuizPageCubit>();

    return DefaultButton(
      label: 'skip',
      backgroundColor: Colors.transparent,
      color: Colors.transparent,
      onPressed: () {
        cubit.setQuizCompletedToTrue(onDone: () {
          _goToHomePage(context);
        });
      },
    );
  }

  void _goToHomePage(BuildContext context) {
    NavigatorHelper.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()),
      (_) => false,
    );
  }

  void _goToQuizPage(BuildContext context) {
    final cubit = context.read<QuizPageCubit>();
    NavigatorHelper.of(context).push(
      MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: cubit,
                child: const QuizPage(),
              )),
    );
  }
}
