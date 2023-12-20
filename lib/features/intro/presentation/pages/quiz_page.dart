import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/features/intro/presentation/blocs/quiz_page_cubit/quiz_page_cubit.dart';
import 'package:masaj/shared_widgets/other/show_snack_bar.dart';
import 'package:masaj/shared_widgets/stateless/custom_app_page.dart';
import 'package:masaj/shared_widgets/stateless/dots_indicator.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/custom_text.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../data/models/quiz_page_tab_model.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late final List<QuizPageTabModel> questions;
  final PageController _pageController = PageController();

  @override
  void initState() {
    final cubit = context.read<QuizPageCubit>();
    questions = cubit.state.QuizPageTabs;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizPageCubit, QuizPageState>(
      listener: (context, state) {
        if (state.isError && state.errorMessage != null) {
          showSnackBar(context, message: state.errorMessage);
        }
        if (state.isLoaded) {
          questions = state.QuizPageTabs;
        }
      },
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
                Expanded(child: _buildQuestions(context)),
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox _buildDotIndicator(BuildContext context) {
    final cubit = context.read<QuizPageCubit>();
    return SizedBox(
      width: double.infinity,
      child: DotsIndicator(
        indicatorCount: questions.length,
        pageNumber: cubit.state.tabNumber,
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
        cubit.setQuizCompletedToTrue(onDone: () {
          _goToHomePage(context);
        });
      },
    );
  }

  Widget _buildQuestions(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: questions.length,
      onPageChanged: _updateTabNumber,
      itemBuilder: (context, index) {
        return _buildQuestionCard(context);
      },
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuestionTitle(context),
              // _buildOptions(context),
              //_buildSubmitButton(context),
            ],
          ),
        ),
      ],
    );
  }

  void _updateTabNumber(int index) {
    context.read<QuizPageCubit>().updateTabNumber(index);
  }

  Widget _buildQuestionTitle(BuildContext context) {
    return Text(
      questions[context.read<QuizPageCubit>().state.tabNumber].questionTitle,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  void _goToHomePage(BuildContext context) {
    NavigatorHelper.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()),
      (_) => false,
    );
  }

  Widget _buildQuestionCounter(BuildContext context) {
    final cubit = context.read<QuizPageCubit>();
    final currentTabNumber = cubit.state.tabNumber + 1;
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
