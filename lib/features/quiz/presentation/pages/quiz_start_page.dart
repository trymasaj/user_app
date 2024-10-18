import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/quiz/application/quiz_page_cubit.dart';
import 'package:masaj/features/quiz/presentation/pages/quiz_page.dart';

class QuizStartPage extends StatelessWidget {
  const QuizStartPage({super.key});

  static const routeName = '/QuizPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DI.find<QuizPageCubit>(),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<QuizPageCubit, QuizPageState>(

                // listenWhen: (previous, current) =>
                //     previous.result != current.result,
                listener: (context, state) {
              if (state.result == QuizSubmitResult.skip ||
                  state.result == QuizSubmitResult.success) {
                AuthCubit authCubit = context.read<AuthCubit>();
                authCubit.submitQuizAnsewerd();
                final user = authCubit.state.user;
                if (user?.verified != true) {
                  NavigatorHelper.of(context).pushNamedAndRemoveUntil(
                    OTPVerificationPage.routeName,
                    (_) => false,
                  );
                  return;
                }

                _goToHomePage(context);
              } else {
                //TODO I removed this temp cause it was causing a bug
                // showSnackBar(
                //   context,
                //   message: 'Something went wrong, please try again later',
                // );
              }
            }),
          ],
          child: Scaffold(
              backgroundColor: Colors.transparent, body: _buildBody(context)),
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ImageConstant.masajBackground,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildQuizStartPageTitle(),
            _buildGetStartButton(context),
            _buildSkipButton(context),
          ],
        ),
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
        final authCubit = context.read<AuthCubit>();
        final userId = authCubit.state.user?.id;
        if (userId != null) cubit.skipQuiz(userId);

        authCubit.submitQuizAnsewerd();
      },
    );
  }

  void _goToHomePage(BuildContext context) =>
      NavigatorHelper.of(context).pushNamedAndRemoveUntil(
        HomePage.routeName,
        (_) => false,
      );

  void _goToQuizPage(BuildContext context) {
    NavigatorHelper.of(context).push(
      MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: context.read<QuizPageCubit>(),
                child: const QuizPage(),
              )),
    );
  }
}
