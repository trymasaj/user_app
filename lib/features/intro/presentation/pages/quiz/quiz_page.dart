import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/features/intro/data/models/question_model.dart';
import 'package:masaj/features/intro/presentation/blocs/quiz_page_cubit/quiz_page_cubit.dart';
import 'package:masaj/features/intro/presentation/widgets/question_card.dart';
import 'package:masaj/shared_widgets/other/show_snack_bar.dart';
import 'package:masaj/shared_widgets/stateless/custom_app_page.dart';
import 'package:masaj/shared_widgets/stateless/dots_indicator.dart';

import '../../../../../core/utils/navigator_helper.dart';
import '../../../../../shared_widgets/stateful/default_button.dart';
import '../../../../../shared_widgets/stateless/custom_text.dart';
import '../../../../home/presentation/pages/home_page.dart';
import '../../../data/models/quiz_page_tab_model.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Question> get questions =>
      context.read<QuizPageCubit>().state.questions.questions;
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
            _pageController.animateToPage(state.questionIndex,
                duration: Duration(milliseconds: 700), curve: Curves.linear);
          },
        ),
      ],
      child: BlocBuilder<QuizPageCubit, QuizPageState>(
        builder: (context, state) {
          return CustomAppPage(
            withBackground: true,
            safeTop: true,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildTopSection(context),
                  _buildDotIndicator(context),
                  const SizedBox(height: 28),
                  Expanded(
                      child: PageView.builder(
                    physics: state.currentQuestion.isAnswered
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: state.questions.questions.length,
                    onPageChanged: cubit.updateQuestionIndex,
                    itemBuilder: (context, index) {
                      return QuestionCard(
                        onBack: index == 0
                            ? null
                            : () => cubit.onBackButtonPressed(),
                        onChanged: cubit.onAnswerSelected,
                        question: state.questions.questions[index],
                        onNextPressed: cubit.onNextPressed,
                      );
                    },
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox _buildDotIndicator(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DotsIndicator(
        indicatorCount: questions.length,
        pageNumber: context.read<QuizPageCubit>().state.questionIndex,
        isExpanded: true,
      ),
    );
  }

  Row _buildTopSection(BuildContext context) {
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
      label: 'skip',
      backgroundColor: Colors.transparent,
      color: Colors.transparent,
      onPressed: () {
        cubit.submitQuiz();
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
