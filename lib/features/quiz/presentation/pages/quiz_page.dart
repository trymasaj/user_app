import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/dots_indicator.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:masaj/features/intro/presentation/widgets/question_card.dart';
import 'package:masaj/features/quiz/application/quiz_page_cubit.dart';
import 'package:masaj/features/quiz/domain/entities/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> get questions =>
      context.read<QuizPageCubit>().state.questions.questions;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizPageCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<QuizPageCubit, QuizPageState>(
          listenWhen: (previous, current) =>
              previous.questionIndex != current.questionIndex ||
              previous.result != current.result,
          listener: (context, state) {
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
          },
        ),
      ],
      child: BlocBuilder<QuizPageCubit, QuizPageState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Image.asset(
                    ImageConstant.masajBackground,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 19.h),
                          _buildTopSection(context),
                          SizedBox(height: 25.h),
                          _buildDotIndicator(context),
                          SizedBox(height: 33.h),
                          IndexedStack(
                            index: state.questionIndex,
                            children: questions
                                .mapIndexed((index, e) => QuestionCard(
                                      onChangedSomethingElse: (value) =>
                                          cubit.onChangedSomethingElse(value),
                                      isSomethingElse: e.selectedAnswer.fold(
                                          () => false,
                                          (a) => a.isSomethingElse),
                                      isLastQuestion:
                                          index == questions.length - 1,
                                      onBack: state.questionIndex == 0
                                          ? null
                                          : () => cubit.onBackButtonPressed(),
                                      onChanged: cubit.onAnswerSelected,
                                      question: e,
                                      onNextPressed: (question) =>
                                          cubit.onNextPressed(
                                              context
                                                  .read<AuthCubit>()
                                                  .state
                                                  .user!
                                                  .id!,
                                              question),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDotIndicator(BuildContext context) {
    return DotsIndicator(
      indicatorCount: questions.length,
      pageNumber: context.read<QuizPageCubit>().state.questionIndex,
      isExpanded: true,
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 70,
        ),
        const Spacer(),
        _buildQuestionCounter(context),
        const Spacer(),
        SizedBox(width: 70, child: _buildSkipButton(context)),
      ],
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    final cubit = context.read<QuizPageCubit>();
    return DefaultButton(
      label: AppText.skip,
      backgroundColor: Colors.transparent,
      color: Colors.transparent,
      onPressed: () {
        final authCubit = context.read<AuthCubit>();
        final userId = authCubit.state.user?.id;
        if (userId != null) cubit.skipQuiz(userId);
      },
    );
  }

  Widget _buildQuestionCounter(BuildContext context) {
    final cubit = context.read<QuizPageCubit>();
    final currentTabNumber = cubit.state.questionIndex + 1;
    final totalTabNumber = questions.length;
    return CustomText(
      text: '$currentTabNumber/$totalTabNumber',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      textAlign: TextAlign.center,
    );
  }
}
