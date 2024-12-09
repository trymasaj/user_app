import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
// import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/app_logo.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/email_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/password_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';

import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/email_verification_page.dart';
import 'package:masaj/features/auth/presentation/pages/forget_password_page.dart';
import 'package:masaj/features/auth/presentation/pages/sign_up_page.dart';
import 'package:masaj/features/quiz/presentation/pages/quiz_start_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailTextController;
  late final TextEditingController _phoneNumberConttroleer;

  late final TextEditingController _passwordTextController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _phoneFocusNode;
  PhoneNumber? _phoneNumber;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneNumberConttroleer = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneNumberConttroleer.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  void _goToOtpVerify(BuildContext context) => NavigatorHelper.of(context)
      .pushReplacementNamed(OTPVerificationPage.routeName);
  void _goToQuiz(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(QuizStartPage.routeName);
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
        final user = state.user;
        if (state.isCompleteSignUp) {
          _goToCompleteSignUpPage(context);
        }

        if (state.isLoggedIn) {
          if (user?.isProfileCompleted != true) {
            return _goToCompleteSignUpPage(context);
          }
          if (user?.verified != true) {
            return _goToOtpVerify(context);
          }
          if (user?.quizAnswered != true) {
            return _goToQuiz(context);
          }

          return _goToHomePage(
            context,
            userFullName: user!.fullName,
          );
        }
      },
      child: CustomAppPage(
        withBackground: true,
        backgroundPath: 'assets/images/Bg.png',
        safeBottom: false,
        safeTop: true,
        backgroundFit: BoxFit.fitWidth,
        backgroundAlignment: Alignment.topCenter,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              _buildTopSection(),
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildTopSection() {
    return SizedBox(
      height: 120.h,
      child: AppLogo(
        alignment: Alignment.center,
        height: 20.h,
        width: 138.w,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            topRight: Radius.circular(28.0),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: 30,
        ),
        child: ListView(
          children: [
            CustomText(
              text: AppText.welcome_back,
              textAlign: TextAlign.start,
              margin: const EdgeInsets.only(bottom: 4.0),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            _buildDoNotHaveAccountButton(context),
            const SizedBox(height: 16.0),
            _buildForm(),
            _buildContinueAsGuestButton(context),
            _buildVerticalLineSplittedWithORText(context),
            const SizedBox(height: 16.0),
            if (Platform.isIOS) ...[
              _buildAppleButton(context),
              const SizedBox(height: 4.0),
            ],
            _buildGoogleButton(context),
          ],
        ),
      ),
    );
  }

  Future<String?> _showEmailDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        final formKey = GlobalKey<FormState>();
        final emailController = TextEditingController();
        final emailFocusNode = FocusNode();

        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TitleText.small(
                //   text: 'email_required,
                //   margin: const EdgeInsets.all(12.0),
                // ),
                EmailTextFormField(
                  currentController: emailController,
                  currentFocusNode: emailFocusNode,
                  //hint: 'email,
                  margin: const EdgeInsets.all(8.0),
                  prefixIcon:
                      buildImage(ImageConstant.imgCheckmarkBlueGray40001),
                ),

                DefaultButton(
                  label: AppText.confirmed,
                  isExpanded: true,
                  borderColor: AppColors.GREY_DARK_COLOR,
                  margin: const EdgeInsets.all(8.0),
                  onPressed: () => formKey.currentState!.validate()
                      ? Navigator.of(context).pop(emailController.text.trim())
                      : null,
                ),
              ],
            ),
          ),
        );
      },
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

  Widget _buildGoogleButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    const labelStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

    return DefaultButton(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      contentAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      label: AppText.lbl_sign_with_google,
      labelStyle: labelStyle,
      color: const Color(0xFFF6F6F6),
      icon: SvgPicture.asset(
        'assets/images/google.svg',
        color: Colors.black,
      ),
      onPressed: () {
        return authCubit.loginWithGoogle(() => _showEmailDialog(context));
      },
    );
  }

  Widget _buildAppleButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    const labelStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

    return DefaultButton(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      isExpanded: true,
      contentAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      label: AppText.lbl_sign_with_apple,
      labelStyle: labelStyle,
      color: const Color(0xFFF6F6F6),
      icon: SvgPicture.asset(
        'assets/images/apple.svg',
        color: Colors.black,
      ),
      onPressed: () {
        return authCubit.loginWithApple(() => _showEmailDialog(context));
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
            currentController: _phoneNumberConttroleer,
            currentFocusNode: _phoneFocusNode,
            nextFocusNode: _passwordFocusNode,
            initialValue: _phoneNumber,
            onInputChanged: (value) => _phoneNumber = value,
          ),
          const SizedBox(height: 16.0),
          PasswordTextFormField(
            currentFocusNode: _passwordFocusNode,
            currentController: _passwordTextController,
          ),
          _buildForgetPasswordButton(context),
          const SizedBox(height: 16.0),
          _buildSignInButton(context),
        ],
      ),
    );
  }

  Widget _buildForgetPasswordButton(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
          child: CustomText(
            text: AppText.msg_forgot_password,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          onPressed: () => _goToForgetPasswordPage(context)),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: AppText.sign_in,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      isExpanded: true,
      onPressed: () async {
        if (_isNotValid()) return;
        await authCubit.login(_phoneNumberConttroleer.text.trim(),
            _passwordTextController.text, _phoneNumber?.countryCode ?? '');
      },
    );
  }

  bool _isNotValid() {
    _emailTextController.text = _emailTextController.text.trim();

    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    if (_phoneNumberConttroleer.text.isEmpty) {
      showSnackBar(context,
          message:
              Validator().validatePhoneNumber(_phoneNumber?.completeNumber));
      return true;
    }

    return false;
  }

  Widget _buildContinueAsGuestButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          await authCubit.continueAsGuest();
          // AdjustTracker.trackGuestRegistration();
          _goToHomePage(context);
        },
        child: CustomText(
          text: AppText.continue_guest,
          decoration: TextDecoration.underline,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          margin: const EdgeInsets.symmetric(vertical: 18.0),
        ),
      ),
    );
  }

  void _goToHomePage(
    BuildContext context, {
    String? userFullName,
  }) {
    NavigatorHelper.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()),
      (_) => false,
    );
    if (userFullName != null) {
      showSnackBar(context, message: AppText.welcome(args: [userFullName]));
    }
  }

  Widget _buildDoNotHaveAccountButton(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: AppText.dont_have_account_message,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.FONT_LIGHT_COLOR,
        ),
        const SizedBox(width: 8.0),
        GestureDetector(
          onTap: () => _goToSignUpPage(context),
          child: CustomText(
            text: AppText.sign_up,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  Future<void> _goToForgetPasswordPage(BuildContext context) async {
    final success = await NavigatorHelper.of(context)
        .pushNamed(ForgetPasswordPage.routeName);
    if (success == true) {
      showSnackBar(context, message: AppText.forget_password_success);
    }
  }

  void _goToSignUpPage(BuildContext context) {
    // AdjustTracker.trackRegistrationInitiated();
    NavigatorHelper.of(context).pushNamed(SignUpPage.routeName);
  }

  void _goToEmailVerificationPage(BuildContext context) =>
      NavigatorHelper.of(context).pushNamed(EmailVerificationPage.routeName);

  Widget _buildVerticalLineSplittedWithORText(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.FONT_LIGHT_COLOR,
          ),
        ),
        CustomText(
          text: AppText.or,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.FONT_LIGHT_COLOR,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.FONT_LIGHT_COLOR,
          ),
        ),
      ],
    );
  }

  void _goToCompleteSignUpPage(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const SignUpPage(
            isFromSocial: true,
          ),
        ),
      );
}
