import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_pin_code_text_field.dart';

import 'package:masaj/features/account/bloc/verification_code_bloc/verification_code_bloc.dart';
import 'package:flutter/material.dart';

class VerificationCodeScreen extends StatefulWidget {
  static const routeName = '/verification-code';
  const VerificationCodeScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<VerificationCodeBloc>(
        create: (context) =>
            VerificationCodeBloc(VerificationCodeState.initial()),
        child: const VerificationCodeScreen());
  }

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final otpController = TextEditingController();
  @override
  void dispose() {
    otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('msg_verification_code'.tr(),
                          style: theme.textTheme.titleLarge),
                      SizedBox(height: 5.h),
                      Container(
                          width: 284.w,
                          margin: EdgeInsets.only(right: 42.w),
                          child: Text('msg_you_will_receive'.tr(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(height: 1.43))),
                      SizedBox(height: 21.h),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: BlocSelector<VerificationCodeBloc,
                                  VerificationCodeState, String>(
                              selector: (state) => state.otp,
                              builder: (context, _) {
                                return CustomPinCodeTextField(
                                    context: context,
                                    controller: otpController,
                                    onChanged: (value) {
                                      otpController.text = value;
                                    });
                              })),
                      SizedBox(height: 34.h),
                      CustomElevatedButton(
                          text: 'lbl_send'.tr(),
                          buttonStyle: CustomButtonStyles.none,
                          decoration: CustomButtonStyles
                              .gradientSecondaryContainerToPrimaryDecoration,
                          onPressed: () {
                            onTapSend(context);
                          }),
                      SizedBox(height: 16.h),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28.w),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('msg_didn_t_receive_a'.tr(),
                                        style: CustomTextStyles
                                            .bodyMediumGray90003),
                                    Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: Text('lbl_resend_in_39_00'.tr(),
                                            style: theme.textTheme.titleSmall))
                                  ]))),
                      SizedBox(height: 5.h)
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar();
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  void onTapIconButton(BuildContext context) {
/*
    NavigatorService.pushNamed(
      AppRoutes.forgotPasswordScreen,
    );
*/
  }

  /// Navigates to the createNewPasswordScreen when the action is triggered.
  void onTapSend(BuildContext context) {
/*
    NavigatorService.pushNamed(
      AppRoutes.createNewPasswordScreen,
    );
*/
  }
}
