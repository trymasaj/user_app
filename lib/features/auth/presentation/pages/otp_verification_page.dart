import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/back_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:masaj/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/reset_password_page.dart';

class OTPVerificationPage extends StatefulWidget {
  static const routeName = '/otp-verification';

  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // timer
  late Timer _timer;
  int _start = 60;
  bool _isTimerRunning = false;

  void startTimer() {
    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isTimerRunning = false;
        });
        _timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  final otpController = TextEditingController();

  bool _isAutoValidating = false;

  @override
  void dispose() {
    otpController.dispose();
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) {
          showSnackBar(context, message: state.errorMessage);
        } else if (state.isInitial) _goBackToLoginPage(context, true);
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
              _buildMainText(context),
              const SizedBox(height: 8.0),
              _buildSubText(context),
              const SizedBox(height: 16.0),
              _buildForm(),
              const SizedBox(height: 16.0),
              _buildSendButton(context),
              const SizedBox(height: 16.0),
              if (_isTimerRunning) _buildTimer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainText(BuildContext context) {
    return const CustomText(
      text: 'verification_code',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildSubText(BuildContext context) {
    return const CustomText(
      text: 'verification_code_sub',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.FONT_LIGHT_COLOR,
    );
  }

  Widget _buildSendButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'send',
      backgroundColor: Colors.transparent,
      onPressed: () async {
        _goToResetPasswordPage(context);

        if (_isNotValid()) return;
        //await authCubit.forgetPassword(_emailTextController.text.trim());
      },
    );
  }

  Widget _buildForm() {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        fieldHeight: 55,
        fieldWidth: 55,
        activeFillColor: const Color(0xffF8F8F8),
        selectedColor: AppColors.PRIMARY_COLOR,
        selectedFillColor: const Color(0xffF8F8F8),
        selectedBorderWidth: 2,
        inactiveFillColor: const Color(0xffF8F8F8),
        inactiveColor: Colors.transparent,
        activeColor: Colors.transparent,
      ),
      length: 5,
      autoFocus: true,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      obscureText: false,
      animationType: AnimationType.fade,
      cursorColor: Colors.black,
      cursorWidth: 2,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      enableActiveFill: true,
      controller: otpController,
      keyboardType: TextInputType.number,
      onCompleted: (value) {
        //context.read<OtpCubit>().setCode(value);
      },
    );
  }

  // build timer
  Widget _buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'do_not_receive_code'.tr(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.FONT_COLOR,
          ),
        ),
        Text(
          'resend_in'.tr(args: ['$_start']),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.FONT_COLOR,
          ),
        ),
      ],
    );
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  void _goToResetPasswordPage(BuildContext context) {
    NavigatorHelper.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ResetPasswordPage(),
      ),
    );
  }

  void _goBackToLoginPage(BuildContext context, bool isSuccess) =>
      NavigatorHelper.of(context).pop(isSuccess);
}
