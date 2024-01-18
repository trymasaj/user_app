import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_chip.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/confirm_password_text_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/email_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/password_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';

import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/auth/data/models/user.dart';
import 'package:masaj/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUp';

  const SignUpPage({
    super.key,
    bool startFromSubscriptionStep = false,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Gender selectedGender = Gender.male;
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _fullNameTextController;
  late final TextEditingController _phoneTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  late final TextEditingController _passwordConfirmTextController;
  late final TextEditingController _birthDateTextController;

  late final FocusNode _fullNameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _passwordConfirmFocusNode;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _birthDateFocusNode;
  bool _isAutoValidating = false;
  PhoneNumber? _phoneNumber;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _fullNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _passwordConfirmTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _birthDateTextController = TextEditingController();

    _fullNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordConfirmFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _birthDateFocusNode = FocusNode();
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
          return _goToHomePage(
            context,
            userFullName: user!.fullName,
          );
        }
      },
      child: Builder(
        builder: (context) => CustomAppPage(
          withBackground: true,
          child: CustomAppPage(
            safeTop: true,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: _buildBody(context),
              ),
            ),
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
          const SizedBox(height: 28.0),
          const CustomText(
            text: 'create_an_account',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 6.0),
          _buildHaveAccountRow(context),
          _buildSignUpForm(),
          _buildGenderRow(context),
          _buildTermsAndConditions(context),
          const SizedBox(height: 16.0),
          _buildSignUpButton(context),
          _buildContinueAsGuestButton(context),
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
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DefaultTextFormField(
            currentController: _fullNameTextController,
            currentFocusNode: _fullNameFocusNode,
            nextFocusNode: _emailFocusNode,
            hint: 'full_name',
            isRequired: true,
          ),
          const SizedBox(height: 18.0),
          EmailTextFormField(
            currentController: _emailTextController,
            currentFocusNode: _emailFocusNode,
            nextFocusNode: _passwordFocusNode,
          ),
          const SizedBox(height: 18.0),
          PhoneTextFormField(
            currentController: _phoneTextController,
            currentFocusNode: _phoneFocusNode,
            nextFocusNode: null,
            initialValue: _phoneNumber,
            onInputChanged: (value) => _phoneNumber = value,
          ),
          const SizedBox(height: 18.0),
          DefaultTextFormField(
            currentFocusNode: _birthDateFocusNode,
            currentController: _birthDateTextController,
            keyboardType: TextInputType.datetime,
            suffixIcon:
                const Icon(Icons.calendar_month_outlined, color: Colors.black),
            isRequired: true,
            hint: 'birth_date',
            readOnly: true,
            onTap: () async {
              final initialDate = _birthDateTextController.text.isNotEmpty
                  ? _birthDateTextController.text.parseDate()
                  : DateTime.now();
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: DateTime.now().subtract(const Duration(days: 43800)),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                _birthDateTextController.text = pickedDate.formatDate();
              }
            },
          ),
          const SizedBox(height: 18.0),
          PasswordTextFormField(
              currentFocusNode: _passwordFocusNode,
              nextFocusNode: _passwordConfirmFocusNode,
              currentController: _passwordTextController),
          const SizedBox(height: 18.0),
          ConfirmPasswordTextFormField(
            currentFocusNode: _passwordConfirmFocusNode,
            currentController: _passwordConfirmTextController,
            passwordController: _passwordTextController,
            hint: 'confirm_password',
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    Future<void> signUpCallBack() async {
      if (_isNotValid()) return;

      await authCubit.signUp(
        User(
            fullName: _fullNameTextController.text.trim(),
            email: _emailTextController.text.trim(),
            password: _passwordTextController.text,
            confirmPassword: _passwordConfirmTextController.text,
            phone: _phoneNumber?.number,
            countryCode: _phoneNumber?.countryCode,
            birthDate: _birthDateTextController.text.parseDate(),
            gender: selectedGender,
            countryId: 1),
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
        message: 'welcome_user'.tr(args: [userFullName]),
        margin: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
      );
    }
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
            height: 56,
            label: Gender.male.toString(),
            value: Gender.male,
            groupValue: selectedGender,
            isExpanded: true,
            onValueSelected: (selectedValue) {
              setState(() => selectedGender = selectedValue);
            }),
        const SizedBox(width: 8.0),
        CustomChip(
          height: 56,
          label: Gender.female.toString(),
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
