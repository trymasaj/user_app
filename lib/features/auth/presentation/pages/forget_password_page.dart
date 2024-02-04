import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/back_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';

import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const routeName = '/ForgetPasswordPage';

  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final GlobalKey<FormState> _emailFormKey;
  late final GlobalKey<FormState> _phoneFormKey;
  late final TextEditingController _emailTextController;
  late final FocusNode _emailFocusNode;
  late final TextEditingController _phoneNumberController;
  late final FocusNode _phoneFocusNode;
  PhoneNumber? _phoneNumber;
  late bool _isAutoValidating = false;

  @override
  void initState() {
    super.initState();

    _emailFormKey = GlobalKey<FormState>();
    _phoneFormKey = GlobalKey<FormState>();
    _emailTextController = TextEditingController();
    _emailFocusNode = FocusNode();
    _phoneNumberController = TextEditingController();
    _phoneFocusNode = FocusNode();

    // Add listeners
    _emailTextController.addListener(_onFieldChanged);
    _phoneNumberController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _emailTextController.removeListener(_onFieldChanged);
    _emailTextController.dispose();
    _emailFocusNode.dispose();
    _phoneNumberController.removeListener(_onFieldChanged);
    _phoneNumberController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) {
          showSnackBar(context, message: state.errorMessage);
          //TODO: moatasem what the hell is this ??
        } else if (state.isInitial) _goToOtpVerificationPage(context);
      },
      child: CustomAppPage(
        safeTop: true,
        safeBottom: true,
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const CustomBackButton(
                color: Colors.black,
              ),
              const SizedBox(height: 16.0),
              _buildForgetPasswordMainText(context),
              const SizedBox(height: 8.0),
              _buildForgetPasswordSubText(context),
              const SizedBox(height: 16.0),
              _buildForm(),
              const SizedBox(height: 16.0),
              _buildResetPasswordButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgetPasswordMainText(BuildContext context) {
    return const CustomText(
      text: 'msg_forgot_password',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildForgetPasswordSubText(BuildContext context) {
    return const CustomText(
      text: 'forget_password_sub',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.FONT_LIGHT_COLOR,
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'continue',
      backgroundColor: AppColors.PRIMARY_COLOR,
      onPressed: () async {
        if (_isNotValid()) return;
        //send email or phone number to server
        final countryCode = _phoneNumber?.countryCode ?? '';
        final phoneNumberOrEmail = _phoneNumberController.text.trim().isEmpty
            ? _emailTextController.text.trim()
            : '$countryCode${_phoneNumberController.text.trim()}';
        await authCubit.forgetPassword(phoneNumberOrEmail);
        // _goToOtpVerificationPage(context);
      },
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _phoneFormKey,
          autovalidateMode: _isAutoValidating
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: PhoneTextFormField(
            isEnabled: _emailTextController.text.trim().isEmpty,
            currentController: _phoneNumberController,
            currentFocusNode: _phoneFocusNode,
            nextFocusNode: null,
            initialValue: _phoneNumber,
            onInputChanged: (value) => _phoneNumber = value,
          ),
        ),
        const SizedBox(height: 12.0),
        _buildVerticalLineSplittedWithORText(context),
        const SizedBox(height: 12.0),
        Form(
          key: _emailFormKey,
          autovalidateMode: _isAutoValidating
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: DefaultTextFormField(
            enabled: _phoneNumberController.text.trim().isEmpty,
            currentFocusNode: _emailFocusNode,
            currentController: _emailTextController,
            prefixIcon: buildImage(ImageConstant.imgCheckmarkBlueGray40001),
            hint: 'email_address'.tr(),
            validator: Validator().validateEmailWithoutRequired,
          ),
        ),
      ],
    );
  }

  Padding buildImage(String imagePath) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 17.h, 10.w, 19.h),
      child: CustomImageView(
        imagePath: imagePath,
        height: 20.h,
        width: 20.w,
        color: appTheme.blueGray40001,
      ),
    );
  }

  bool _isNotValid() {
    bool isEmailEmpty = _emailTextController.text.trim().isEmpty;
    bool isPhoneEmpty = _phoneNumberController.text.trim().isEmpty;

    if (isEmailEmpty && isPhoneEmpty) {
      showSnackBar(context, message: 'email_or_phone_number_required'.tr());
      return true;
    }
    if (!isEmailEmpty) {
      if (!_emailFormKey.currentState!.validate()) {
        setState(() => _isAutoValidating = true);
        return true;
      }
    }

    if (!isPhoneEmpty) {
      if (!_phoneFormKey.currentState!.validate()) {
        setState(() => _isAutoValidating = true);
        return true;
      }
    }

    return false;
  }

  Widget _buildVerticalLineSplittedWithORText(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: 'or',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.FONT_LIGHT_COLOR,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ],
    );
  }

  void _goBackToLoginPage(BuildContext context, bool isSuccess) =>
      NavigatorHelper.of(context).pop(isSuccess);

  void _goToOtpVerificationPage(BuildContext context) {
    final emailOrPhone = _phoneNumberController.text.trim().isEmpty
        ? _emailTextController.text.trim()
        : _phoneNumber!.completeNumber;
    NavigatorHelper.of(context).push(
      MaterialPageRoute(
        builder: (_) => OTPVerificationPage(
          fromForgetPassword: true,
          emailOrPhoneNumber: emailOrPhone,
        ),
      ),
    );
  }
}
