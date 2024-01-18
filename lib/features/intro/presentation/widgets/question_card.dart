import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_radio_button.dart';
import 'package:masaj/features/quiz/domain/entities/question.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {super.key,
      required this.question,
      required this.isLastQuestion,
      required this.onNextPressed,
      required this.isSomethingElse,
      required this.onBack,
      required this.onChanged});
  final Question question;
  final void Function(Question question) onNextPressed;
  final void Function(Answer answer) onChanged;
  final VoidCallback? onBack;
  final bool isSomethingElse;
  final bool isLastQuestion;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (widget.onBack != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: GestureDetector(
                  onTap: widget.onBack,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        // color: Color(0xff181B28B2),
                      ),
                      Text(
                        'lbl_back'.tr(),
                        style: const TextStyle(
                            // color: Color(0xff181B28B2),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            Text('msg_select_an_answer'.tr(),
                style: CustomTextStyles.bodyMediumBluegray40001_1),
            SizedBox(height: 2.h),
            Text(widget.question.content.tr(),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: CustomTextStyles.titleMediumGray9000318
                    .copyWith(height: 1.56)),
            SizedBox(height: 20.h),
            ...widget.question.answers.map((answer) => AnswerTile(
                answer: answer,
                value: widget.question.selectedAnswer.toNullable()?.id,
                onChanged: (value) => widget.onChanged(answer))),
            if (widget.isSomethingElse)
              Column(
                children: [
                  TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
                        hintText: 'msg_please_share_your3'.tr(),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
                height: 48.h,
                text:
                    widget.isLastQuestion ? 'lbl_finish'.tr() : 'lbl_next'.tr(),
                buttonStyle: CustomButtonStyles.none,
                decoration: CustomButtonStyles
                    .gradientSecondaryContainerToPrimaryTL25Decoration,
                buttonTextStyle:
                    CustomTextStyles.titleSmallOnPrimaryContainer_1,
                onPressed: widget.question.selectedAnswer.isNone()
                    ? null
                    : () => widget.onNextPressed(widget.question.copyWith(
                        selectedAnswer: widget.question.selectedAnswer)))
          ],
        ),
      ),
    );
  }
}
//

class AnswerTile extends StatelessWidget {
  const AnswerTile(
      {super.key,
      required this.answer,
      required this.value,
      required this.onChanged});
  final Answer answer;
  final String? value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CustomRadioButton(
        text: answer.content.tr(),
        value: answer.id,
        groupValue: value,
        padding: EdgeInsets.all(18.w),
        decoration: RadioStyleHelper.gradientSecondaryContainerToDeepOrange(
            answer.id == value),
        isRightCheck: true,
        onChange: (value) => onChanged(value),
      ),
    );
  }
}
