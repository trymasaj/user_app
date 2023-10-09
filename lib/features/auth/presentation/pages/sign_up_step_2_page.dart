import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:masaj/shared_widgets/text_fields/phone_number_text_field.dart';

import '../../../../core/enums/age_group.dart';
import 'email_verification_page.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../core/enums/gender.dart';
import '../../../../shared_widgets/stateful/custom_drop_down_menu.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../shared_widgets/text_fields/default_text_form_field.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../blocs/auth_cubit/auth_cubit.dart';

class SignUpStep2Page extends StatefulWidget {
  static const routeName = '/SignUpStep2Page';
  const SignUpStep2Page({super.key});

  @override
  State<SignUpStep2Page> createState() => _SignUpStep2PageState();
}

class _SignUpStep2PageState extends State<SignUpStep2Page> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _fullNameTextController;
  late final TextEditingController _phoneTextController;

  late final FocusNode _fullNameFocusNode;
  late final FocusNode _phoneFocusNode;

  Gender? _userGender;
  AgeGroup? _userAgeGroup;

  PhoneNumber? _phoneNumber;
  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _fullNameTextController = TextEditingController();
    _phoneTextController = TextEditingController();

    _fullNameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _fullNameTextController.dispose();
    _phoneTextController.dispose();

    _fullNameFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight =
        mediaQueryData.size.height - mediaQueryData.padding.top;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
      },
      child: CustomAppPage(
        withBackground: true,
        safeBottom: false,
        safeTop: true,
        backgroundPath: 'lib/res/assets/sign_up_step_2_background.svg',
        backgroundFit: BoxFit.fitWidth,
        backgroundAlignment: Alignment.topCenter,
        child: Scaffold(
          body: SingleChildScrollView(
              child: SizedBox(
            height: screenHeight,
            child: _buildBody(context),
          )),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 2),
        const TitleText.extraLarge(
          text: 'ready_to_complete_your_info',
          textAlign: TextAlign.start,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        const SizedBox(height: 16.0),
        Expanded(flex: 7, child: _buildForm()),
        _buildLowerSection(context),
      ],
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        autovalidateMode: _isAutoValidating
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TitleText(text: 'full_name'),
                const SizedBox(height: 8.0),
                DefaultTextFormField(
                  currentController: _fullNameTextController,
                  currentFocusNode: _fullNameFocusNode,
                  nextFocusNode: _phoneFocusNode,
                  hint: 'enter_full_name'.tr(),
                  isRequired: true,
                ),
                const SizedBox(height: 16.0),
                const TitleText(text: 'mobile_number'),
                const SizedBox(height: 8.0),
                PhoneTextFormField(
                  currentController: _phoneTextController,
                  currentFocusNode: _phoneFocusNode,
                  nextFocusNode: null,
                  initialValue: _phoneNumber,
                  onInputChanged: (value) => _phoneNumber = value,
                ),
                const SizedBox(height: 16.0),
                const TitleText(text: 'choose_your_gender'),
                const SizedBox(height: 8.0),
                CustomDropDownMenu<Gender>.adaptive(
                  currentItem: _userGender,
                  items: Gender.values,
                  hint: 'gender'.tr(),
                  onChanged: (value) => _userGender = value,
                  getStringFromItem: (item) => item.name.tr(),
                ),
                const SizedBox(height: 16.0),
                const TitleText(text: 'how_old_are_you'),
                const SizedBox(height: 8.0),
                CustomDropDownMenu<AgeGroup>.adaptive(
                  currentItem: _userAgeGroup,
                  items: AgeGroup.values,
                  hint: 'age_group'.tr(),
                  onChanged: (value) => _userAgeGroup = value,
                  getStringFromItem: (item) => item.name.tr(),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLowerSection(BuildContext context) {
    return Expanded(
      flex: 3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCompleteRegistration(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteRegistration(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 16.0,
            tabletLarge: 18.0,
            desktopSmall: 21.0,
          ),
        );
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return SizedBox(
      width: screenWidth * 0.6,
      child: DefaultButton(
          label: 'continue'.tr(),
          labelStyle: textStyle,
          backgroundColor: Colors.transparent,
          borderWidth: 2.0,
          icon: const Icon(Icons.arrow_forward),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          iconLocation: DefaultButtonIconLocation.End,
          borderColor: Colors.white,
          isExpanded: true,
          onPressed: () {}),
    );
  }

  bool _isNotValid() {
    _fullNameTextController.text = _fullNameTextController.text.trim();
    _phoneTextController.text = _phoneTextController.text.trim();

    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  Future<void> _goToEmailVerificationPage(BuildContext context) =>
      Navigator.of(context)
          .pushReplacementNamed(EmailVerificationPage.routeName);
}
