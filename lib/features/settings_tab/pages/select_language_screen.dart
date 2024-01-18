import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_radio_button.dart';
import 'package:masaj/features/settings_tab/bloc/select_language_bloc/select_language_bloc.dart';
import 'package:masaj/features/settings_tab/models/select_language_model.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SelectLanguageBloc>(
      create: (context) => SelectLanguageBloc(SelectLanguageState(
        selectLanguageModelObj: SelectLanguageModel(),
      )),
      child: const SelectLanguageScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 27.h,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'msg_choose_you_preferred'.tr(),
                  style: CustomTextStyles.titleMediumGray9000318,
                ),
              ),
              SizedBox(height: 21.h),
              _buildChooseYourPreferredLanguage(context),
              SizedBox(height: 32.h),
              CustomElevatedButton(
                text: 'lbl_save'.tr(),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                buttonStyle: CustomButtonStyles.none,
                decoration: CustomButtonStyles
                    .gradientSecondaryContainerToPrimaryDecoration,
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('lbl_language'.tr()),
    );
  }

  /// Section Widget
  Widget _buildChooseYourPreferredLanguage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: BlocBuilder<SelectLanguageBloc, SelectLanguageState>(
        builder: (context, state) {
          return state.selectLanguageModelObj!.radioList.isNotEmpty
              ? Column(
                  children: [
                    CustomRadioButton(
                      width: 327.w,
                      text: 'lbl_arabic'.tr(),
                      value: state.selectLanguageModelObj?.radioList[0] ?? '',
                      groupValue: state.chooseYourPreferredLanguage,
                      padding: EdgeInsets.all(18.w),
                      textStyle: CustomTextStyles.titleSmallOnPrimary_3,
                      decoration: RadioStyleHelper.fillGray,
                      isRightCheck: true,
                      onChange: (value) {
                        context
                            .read<SelectLanguageBloc>()
                            .changeRadioButton(value);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 14.h),
                      child: CustomRadioButton(
                        width: 327.w,
                        text: 'lbl_english'.tr(),
                        value: state.selectLanguageModelObj?.radioList[1] ?? '',
                        groupValue: state.chooseYourPreferredLanguage,
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 16.h,
                        ),
                        decoration: RadioStyleHelper.outline,
                        isRightCheck: true,
                        onChange: (value) {
                          context
                              .read<SelectLanguageBloc>()
                              .changeRadioButton(value);
                        },
                      ),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
