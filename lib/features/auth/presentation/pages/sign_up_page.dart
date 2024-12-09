import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_chip.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/email_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/password_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/legal/pages/terms_and_condititons_screen.dart';

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
  // di
  final SystemService system = DI.find();

  final TextEditingController _fullNameTextController = TextEditingController(),
      _emailTextController = TextEditingController(),
      _passwordTextController = TextEditingController(),
      _passwordConfirmTextController = TextEditingController(),
      _phoneTextController = TextEditingController(),
      _birthDateTextController = TextEditingController();

  bool _acceptTerms = false;

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
    final topPadding = MediaQuery.of(context).padding.top;
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
        body: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: SingleChildScrollView(
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          CustomText(
            text: widget.isFromSocial ? AppText.one_more_step : AppText.create_an_account,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          if (!widget.isFromSocial) ...[
            SizedBox(height: 6.0.h),
            _buildHaveAccountRow(context),
          ],
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
        CustomText(
          text: AppText.already_have_account,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.FONT_LIGHT_COLOR,
        ),
        const SizedBox(width: 8.0),
        GestureDetector(
          onTap: () => _goToSignInPage(context),
          child: CustomText(
            text: AppText.sign_in,
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
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DefaultTextFormField(
            isRequired: true,
            currentFocusNode: _fullNameFocusNode,
            currentController: _fullNameTextController,
            nextFocusNode: _emailFocusNode,
            inputFormatters: [LengthLimitingTextInputFormatter(40)],
            hint: AppText.lbl_name,
            prefixIcon: buildImage(ImageConstant.imgLock),
            validator: Validator().validateUserName,
          ),
          SizedBox(height: 18.h),
          if (!widget.isFromSocial) ...[
            EmailTextFormField(
              currentController: _emailTextController,
              currentFocusNode: _emailFocusNode,
              nextFocusNode: _phoneFocusNode,
              prefixIcon: buildImage(ImageConstant.imgCheckmarkBlueGray40001),
            ),
            SizedBox(height: 18.h),
          ],
          PhoneTextFormField(
            currentController: _phoneTextController,
            currentFocusNode: _phoneFocusNode,
            nextFocusNode: _birthDateFocusNode,
            initialValue: _phoneNumber,
            onInputChanged: (value) => _phoneNumber = value,
          ),
          const SizedBox(height: 18.0),
          DefaultTextFormField(
            isRequired: true,
            readOnly: true,
            currentFocusNode: _birthDateFocusNode,
            currentController: _birthDateTextController,
            nextFocusNode: _passwordFocusNode,
            hint: AppText.lbl_birth_date,
            prefixIcon: buildImage(ImageConstant.imgCalendar),
            suffixIcon: buildImage(ImageConstant.imgCalendar),
            validator: (input)=> Validator().validateEmptyField(input) ?? Validator().validateBirthDate(input, 16),
            onTap: () async {
              final initialDate = _birthDateTextController.text.isNotEmpty
                  ? _birthDateTextController.text.parseDate()
                  : system.now;
              final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate:
                      system.now.subtract(const Duration(days: 43800)),
                  lastDate: system.now,
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
          ),
          if (!widget.isFromSocial) ...[
            const SizedBox(height: 18.0),
            PasswordTextFormField(
                currentController: _passwordTextController,
                currentFocusNode: _passwordFocusNode,
                nextFocusNode: _passwordConfirmFocusNode,
                hint: AppText.password,
                validator: widget.isFromSocial
                    ? (value) {
                        return null;
                      }
                    : null),
            const SizedBox(height: 18.0),
            PasswordTextFormField(
              currentFocusNode: _passwordConfirmFocusNode,
              currentController: _passwordConfirmTextController,
              hint: AppText.confirm_password,
              validator: widget.isFromSocial
                  ? (value) {
                      return null;
                    }
                  : (value) {
                      return Validator().validateConfPassword(
                          _passwordTextController.text, value);
                    },
            ),
          ],
        ],
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
  Future<void> signUpCallBack() async {
    final authCubit = context.read<AuthCubit>();
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

  Widget _buildSignUpButton(BuildContext context) {
    return DefaultButton(
      label: AppText.sign_up,
      isExpanded: true,
      iconLocation: DefaultButtonIconLocation.End,
      onPressed: signUpCallBack,
    );
  }

  bool _isNotValid() {
    _fullNameTextController.text = _fullNameTextController.text.trim();
    _emailTextController.text = _emailTextController.text.trim();
    if (!_acceptTerms) {
      showSnackBar(context, message: AppText.terms_validation);
      return true;
    }
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return Row(
      children: [
        Checkbox.adaptive(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppColors.PRIMARY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(color: AppColors.PRIMARY_DARK_COLOR),
        ),
        CustomText(
          text: AppText.i_agree,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(width: 4.0),
        GestureDetector(
          onTap: () {
            NavigatorHelper.of(context)
                .pushNamed(TermsAndCondititonsScreen.routeName);
          },
          child: CustomText(
            text: AppText.terms_and_conditions,
            decoration: TextDecoration.underline,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
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
        message: AppText.welcome(args: [userFullName]),
        margin: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
      );
    }
  }

  _goToOtpVerify(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(
        OTPVerificationPage.routeName);
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
          text: AppText.continue_guest,
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
            label: AppText.lbl_male,
            value: Gender.male,
            groupValue: selectedGender,
            isExpanded: true,
            onValueSelected: (selectedValue) {
              setState(() => selectedGender = selectedValue);
            }),
        const SizedBox(width: 8.0),
        CustomChip(
          height: 56.h,
          label: AppText.lbl_female,
          value: Gender.female,
          groupValue: selectedGender,
          isExpanded: true,
          onValueSelected: (selectedValue) {
            setState(() => selectedGender = selectedValue);
          },
        ),
        const SizedBox(width: 8.0),
        CustomChip(
          height: 56.h,
          label: AppText.lbl_other,
          value: Gender.other,
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
