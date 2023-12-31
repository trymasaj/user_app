import 'package:dartz/dartz.dart' hide State;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/custom_elevated_button.dart';
import 'package:masaj/core/widgets/custom_radio_button.dart';
import 'package:masaj/features/intro/data/models/question_model.dart';
import 'package:masaj/res/style/app_colors.dart';
import 'package:masaj/res/theme/custom_button_style.dart';
import 'package:masaj/res/theme/custom_text_style.dart';
class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {super.key,
      required this.question,
      required this.onSubmitted,
      required this.onBack,
      required this.onChanged});
  final Question question;
  final void Function(Question question) onSubmitted;
  final void Function(Answer answer) onChanged;
  final VoidCallback? onBack;


  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 9.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(widget.onBack!=null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: widget.onBack ,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        // color: Color(0xff181B28B2),
                      ),
                      Text(
                        'lbl_back'.tr(),
                        style: TextStyle(
                          // color: Color(0xff181B28B2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text("msg_select_an_answer".tr(),
                  style: CustomTextStyles.bodyMediumBluegray40001_1),
              SizedBox(height: 3.v),
              Text(widget.question.content.tr(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: CustomTextStyles.titleMediumGray9000318
                      .copyWith(height: 1.56)),
              ...widget.question.answers.map((answer) => AnswerTile(
                  answer: answer,
                  value: widget.question.selectedAnswer.toNullable()?.id,
                  onChanged: (value) => widget.onChanged(answer))),
              SizedBox(height: 28.v),
              CustomElevatedButton(
                  height: 48.v,
                  text: "lbl_next".tr(),
                  buttonStyle: CustomButtonStyles.none,
                  decoration: CustomButtonStyles
                      .gradientSecondaryContainerToPrimaryTL25Decoration,
                  buttonTextStyle:
                      CustomTextStyles.titleSmallOnPrimaryContainer_1,
                  onPressed: widget.question.selectedAnswer.isNone()
                      ? null
                      : () => widget.onSubmitted(widget.question.copyWith(
                          selectedAnswer: widget.question.selectedAnswer)))
            ],
          ),
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
/*
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: RadioStyleHelper.gradientSecondaryContainerToDeepOrange,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Text(answer.content),
              Radio<String>(
                value: answer.id,
                groupValue: value,
                onChanged: (value) => onChanged(value!),
              )
            ],
          ),
        ),
      ),
    );
*/

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.v),
      child: CustomRadioButton(
        text: answer.content.tr(),
        value: answer.id,
        groupValue: value,
        padding: EdgeInsets.all(18.h),
        decoration: RadioStyleHelper.gradientSecondaryContainerToDeepOrange(
            answer.id == value),
        isRightCheck: true,
        onChange: (value) => onChanged(value!),
      ),
    );
  }
}
