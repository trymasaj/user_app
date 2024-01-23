import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/back_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/email_text_form_field.dart';
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
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailTextController;
  late final FocusNode _emailFocusNode;
  late final TextEditingController _phoneNumberController;
  late final FocusNode _phoneFocusNode;
  PhoneNumber? _phoneNumber;
  late bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailTextController = TextEditingController();
    _emailFocusNode = FocusNode();
    _phoneNumberController = TextEditingController();
    _phoneFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) {
          showSnackBar(context, message: state.errorMessage);
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
      text: 'forget_password',
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
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PhoneTextFormField(
            currentController: _phoneNumberController,
            currentFocusNode: _phoneFocusNode,
            nextFocusNode: null,
            initialValue: _phoneNumber,
            onInputChanged: (value) => _phoneNumber = value,
          ),
          const SizedBox(height: 12.0),
          _buildVerticalLineSplittedWithORText(context),
          const SizedBox(height: 12.0),
          EmailTextFormField(
            currentFocusNode: _emailFocusNode,
            currentController: _emailTextController,
          ),
        ],
      ),
    );
  }

  bool _isNotValid() {
    if (_emailTextController.text.trim().isEmpty &&
        _phoneNumberController.text.trim().isEmpty) {
      showSnackBar(context, message: 'email_or_phone_number_required'.tr());
      return true;
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
    NavigatorHelper.of(context).push(
      MaterialPageRoute(
        builder: (_) => OTPVerificationPage(
          fromForgetPassword: true,
          email: _emailTextController.text.trim(),
        ),
      ),
    );
  }
}
