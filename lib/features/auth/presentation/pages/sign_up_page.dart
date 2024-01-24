import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/data/validator/validation_functions.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateful/password_text_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_chip.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';

import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:video_player/video_player.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUp';
  final bool isFromSocial;

  const SignUpPage({
    super.key,
    bool startFromSubscriptionStep = false,
    this.isFromSocial = false,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Gender selectedGender = Gender.male;
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameTextController = TextEditingController(),
      _emailTextController = TextEditingController(),
      _passwordTextController = TextEditingController(),
      _passwordConfirmTextController = TextEditingController(),
      _phoneTextController = TextEditingController(),
      _birthDateTextController = TextEditingController();

  late final FocusNode _fullNameFocusNode = FocusNode(),
      _emailFocusNode = FocusNode(),
      _passwordFocusNode = FocusNode(),
      _passwordConfirmFocusNode = FocusNode(),
      _phoneFocusNode = FocusNode(),
      _birthDateFocusNode = FocusNode();
  bool _isAutoValidating = false;
  PhoneNumber? _phoneNumber;
  @override
  void initState() {
    final authCubit = context.read<AuthCubit>();
    if (widget.isFromSocial) {
      final user = authCubit.state.user;
      _emailTextController.text = user?.email ?? '';
      _fullNameTextController.text = user?.fullName ?? '';
      selectedGender = user?.gender ?? selectedGender;
    }
    super.initState();
  }

  @override
  void dispose() {
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passwordConfirmTextController.dispose();
    _phoneTextController.dispose();
    _birthDateTextController.dispose();
    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) {
          return showSnackBar(context, message: state.errorMessage);
        }
        if (state.isGuest) return _goToHomePage(context);

        if (state.isLoggedIn) {
          final user = state.user;
          if (!user!.verified!) {
            _goToOtpVerify(context);
            return;
          }
          return _goToHomePage(
            context,
            userFullName: user.fullName,
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: topPadding + 20.h),
          const CustomText(
            text: 'create_an_account',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 6.0.h),
          if (!widget.isFromSocial) _buildHaveAccountRow(context),
          _buildSignUpForm(),
          _buildGenderRow(context),
          SizedBox(
            height: 10.h,
          ),
          _buildTermsAndConditions(context),
          SizedBox(height: 16.0.h),
          _buildSignUpButton(context),
          if (!widget.isFromSocial) _buildContinueAsGuestButton(context),
        ],
      ),
    );
  }

  Widget _buildHaveAccountRow(BuildContext context) {
    return Row(
      children: [
        const CustomText(
          text: 'already_have_account',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.FONT_LIGHT_COLOR,
        ),
        const SizedBox(width: 8.0),
        GestureDetector(
          onTap: () => _goToSignInPage(context),
          child: const CustomText(
            text: 'sign_in',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: _buildForm(),
    );
  }

  Widget _buildForm() {
    const style = TextStyle(
      fontSize: 14.0,
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.w),
      borderSide: BorderSide.none,
    );
    final constraints = BoxConstraints(
      maxHeight: 56.h,
    );
    final contentPadding =
        EdgeInsets.only(top: 17.h, right: 30.w, bottom: 17.h);

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 17.0,
            horizontal: 30.0,
          ),
          fillColor: appTheme.gray5001,
          border: border,
          constraints: BoxConstraints(
            minHeight: 56.h,
          ),
          prefixIconColor: appTheme.blueGray40001,
          filled: true,
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        ),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: _isAutoValidating
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              validator: Validator().validateEmptyField,
              focusNode: _fullNameFocusNode,
              controller: _fullNameTextController,
              style: style,
              decoration: InputDecoration(
                  prefixIconConstraints: constraints,
                  prefixIcon: buildImage(ImageConstant.imgLock),
                  hintText: 'lbl_name'.tr(),
                  contentPadding: contentPadding),
            ),
            SizedBox(height: 18.h),
            TextFormField(
              controller: _emailTextController,
              validator: (value) {
                if (value == null || (!isValidEmail(value, isRequired: true))) {
                  return 'err_msg_please_enter_valid_email'.tr();
                }
                return null;
              },
              focusNode: _emailFocusNode,
              style: style,
              decoration: InputDecoration(
                  prefixIconConstraints: constraints,
                  prefixIcon:
                      buildImage(ImageConstant.imgCheckmarkBlueGray40001),
                  hintText: 'lbl_email'.tr(),
                  contentPadding: contentPadding),
            ),
            SizedBox(height: 18.h),
            PhoneTextFormField(
              currentController: _phoneTextController,
              currentFocusNode: _phoneFocusNode,
              nextFocusNode: null,
              initialValue: _phoneNumber,
              onInputChanged: (value) => _phoneNumber = value,
            ),
            const SizedBox(height: 18.0),
            TextFormField(
              readOnly: true,
              style: style,
              onTap: () async {
                final initialDate = _birthDateTextController.text.isNotEmpty
                    ? _birthDateTextController.text.parseDate()
                    : DateTime.now();
                final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 43800)),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppColors.PRIMARY_COLOR,
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (pickedDate != null) {
                  _birthDateTextController.text = pickedDate.formatDate();
                }
              },
              validator: Validator().validateEmptyField,
              focusNode: _birthDateFocusNode,
              controller: _birthDateTextController,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                prefixIconConstraints: constraints,
                prefixIcon: buildImage(ImageConstant.imgCalendar),
                hintText: 'lbl_birth_date'.tr(),
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 19.h, 10.w, 19.h),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgCalendar,
                      height: 20.adaptSize,
                      color: appTheme.blueGray40001,
                      width: 20.adaptSize),
                ),
                suffixIconConstraints: constraints,
              ),
            ),
            if (!widget.isFromSocial) ...[
              const SizedBox(height: 18.0),
              PasswordTextField(
                  iconColor: appTheme.blueGray40001,
                  controller: _passwordTextController,
                  hint: 'password'.tr(),
                  validator: widget.isFromSocial
                      ? (value) {
                          return null;
                        }
                      : null),
              const SizedBox(height: 18.0),
              PasswordTextField(
                iconColor: appTheme.blueGray40001,
                controller: _passwordConfirmTextController,
                hint: 'confirm_password'.tr(),
                validator: widget.isFromSocial
                    ? (value) {
                        return null;
                      }
                    : null,
              ),
            ],
          ],
        ),
      ),
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

  Widget _buildSignUpButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    Future<void> signUpCallBack() async {
      if (_isNotValid()) return;
      final oldUser = authCubit.state.user;
      final user = User(
        id: oldUser?.id,
        fullName: _fullNameTextController.text.trim(),
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text,
        confirmPassword: _passwordConfirmTextController.text,
        phone: _phoneNumber?.number,
        countryCode: _phoneNumber?.countryCode,
        birthDate: _birthDateTextController.text.parseDate(),
        gender: selectedGender,
        countryId: 1,
        token: oldUser?.token,
      );
      if (widget.isFromSocial) {
        await authCubit.updateProfileInformation(user);
        return;
      }
      await authCubit.signUp(
        user,
      );
    }

    return DefaultButton(
      label: 'sign_up'.tr(),
      backgroundColor: AppColors.PRIMARY_COLOR,
      isExpanded: true,
      iconLocation: DefaultButtonIconLocation.End,
      onPressed: signUpCallBack,
    );
  }

  bool _isNotValid() {
    _fullNameTextController.text = _fullNameTextController.text.trim();
    _emailTextController.text = _emailTextController.text.trim();
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {},
          fillColor: MaterialStateProperty.all(AppColors.PRIMARY_COLOR),
          checkColor: Colors.white,
        ),
        const CustomText(
          text: 'i_agree',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(width: 4.0),
        const CustomText(
          text: 'terms_and_conditions',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  void _goToHomePage(
    BuildContext context, {
    String? userFullName,
  }) {
    final authCubit = context.read<AuthCubit>();
    if (!authCubit.state.isGuest) {
      //To remove old home page from stack due to redundant request error(old cubit still exists)
      NavigatorHelper.of(context).popUntil((_) => false);
    }
    NavigatorHelper.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()),
      (_) => false,
    );
    if (userFullName != null) {
      showSnackBar(
        context,
        message: 'welcome'.tr(args: [userFullName]),
        margin: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
      );
    }
  }

  _goToOtpVerify(BuildContext context) {
    NavigatorHelper.of(context).pushNamedAndRemoveUntil(
        OTPVerificationPage.routeName, (route) => false);
  }

  void _goToSignInPage(BuildContext context) {
    NavigatorHelper.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  Widget _buildContinueAsGuestButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          await authCubit.continueAsGuest();
          _goToHomePage(context);
        },
        child: CustomText(
          text: 'continue_guest'.tr(),
          decoration: TextDecoration.underline,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          margin: const EdgeInsets.symmetric(vertical: 18.0),
        ),
      ),
    );
  }

  Widget _buildGenderRow(BuildContext context) {
    return Row(
      children: [
        CustomChip(
            height: 56.h,
            label: 'lbl_male'.tr(),
            value: Gender.male,
            groupValue: selectedGender,
            isExpanded: true,
            onValueSelected: (selectedValue) {
              setState(() => selectedGender = selectedValue);
            }),
        const SizedBox(width: 8.0),
        CustomChip(
          height: 56.h,
          label: 'lbl_female'.tr(),
          value: Gender.female,
          groupValue: selectedGender,
          isExpanded: true,
          onValueSelected: (selectedValue) {
            setState(() => selectedGender = selectedValue);
          },
        ),
      ],
    );
  }
}
