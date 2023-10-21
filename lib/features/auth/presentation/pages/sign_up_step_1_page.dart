import 'package:masaj/features/home/presentation/pages/home_page.dart';

import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../core/enums/topic_type.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../account/presentation/pages/topic_page.dart';
import '../../data/models/user.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/text_fields/password_text_form_field.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../blocs/auth_cubit/auth_cubit.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

class SignUpStep1Page extends StatefulWidget {
  static const routeName = '/SignUpStep1Page';
  const SignUpStep1Page({super.key});

  @override
  State<SignUpStep1Page> createState() => _SignUpStep1PageState();
}

class _SignUpStep1PageState extends State<SignUpStep1Page> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  bool _isAutoValidating = false;
  bool _isPrivacyAndTermsAccepted = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

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
        if (state.isLoggedIn) _goToSignUpStep2Page(context);
      },
      child: CustomAppPage(
        withBackground: true,
        safeBottom: false,
        safeTop: true,
        backgroundPath: 'lib/res/assets/sign_up_step_1_background.svg',
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
        const Spacer(flex: 3),
        const TitleText.extraLarge(
          text: 'welcome_message',
          textAlign: TextAlign.start,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        const TitleText(
          text: 'sign_up',
          margin: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        const SizedBox(height: 16.0),
        Expanded(
          flex: 7,
          child: _buildForm(),
        ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitleText(text: 'your_email'),
              const SizedBox(height: 8.0),
              EmailTextFormField(
                currentController: _emailTextController,
                currentFocusNode: _emailFocusNode,
                nextFocusNode: _passwordFocusNode,
              ),
              const SizedBox(height: 16.0),
              const TitleText(text: 'password'),
              const SizedBox(height: 8.0),
              PasswordTextFormField(
                currentFocusNode: _passwordFocusNode,
                currentController: _passwordTextController,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLowerSection(BuildContext context) {
    return Expanded(
      flex: 8,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLinkText(context),
              const SizedBox(height: 8.0),
              _buildCreateAccountButton(context),
              const SizedBox(height: 8.0),
              _buildContinueAsGuestButton(context),
              const SizedBox(height: 8.0),
              _buildAlreadyHaveAccountButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    Future<void> signUpCallBack() async {
      if (_isNotValid()) return;

      await authCubit.signUp(
        User(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text,
        ),
      );
    }

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
        label: 'sign_up'.tr(),
        labelStyle: textStyle,
        backgroundColor: Colors.transparent,
        borderWidth: 2.0,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        icon: const Icon(Icons.arrow_forward),
        iconLocation: DefaultButtonIconLocation.End,
        borderColor: Colors.white,
        enabled: _isPrivacyAndTermsAccepted,
        isExpanded: true,
        onPressed: signUpCallBack,
      ),
    );
  }

  bool _isNotValid() {
    _emailTextController.text = _emailTextController.text.trim();

    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  Widget _buildContinueAsGuestButton(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 16.0,
            tabletLarge: 18.0,
            desktopSmall: 21.0,
          ),
        );
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    final authCubit = context.read<AuthCubit>();

    return SizedBox(
      width: screenWidth * 0.6,
      child: DefaultButton(
        label: 'continue_guest'.tr(),
        labelStyle: textStyle,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        backgroundColor: Colors.transparent,
        borderWidth: 2.0,
        icon: const Icon(Icons.arrow_forward),
        iconLocation: DefaultButtonIconLocation.End,
        borderColor: Colors.white,
        isExpanded: true,
        onPressed: () async {
          await authCubit.continueAsGuest();
          _goToHomePage(context);
        },
      ),
    );
  }

  Widget _buildAlreadyHaveAccountButton(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 12.0,
            tabletLarge: 14.0,
            desktopSmall: 16.0,
          ),
        );
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: 'already_have_account_message'.tr(), style: textStyle),
            TextSpan(
              text: 'login'.tr(),
              style: textStyle.copyWith(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _goToLoginPage(context),
            ),
          ],
        ));
  }

  Widget _buildLinkText(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCheckButton(context),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'by_pressing_continue'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14.0),
                ),
                TextSpan(
                  text: 'terms_of_use'.tr(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _gToTopicsPage(context, TopicType.Terms),
                ),
                TextSpan(
                  text: ' ${'and'.tr()} ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14.0),
                ),
                TextSpan(
                  text: 'privacy_policy'.tr(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _gToTopicsPage(context, TopicType.Privacy),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }

  Widget _buildCheckButton(BuildContext context) {
    return Checkbox(
      value: _isPrivacyAndTermsAccepted,
      onChanged: (value) =>
          setState(() => _isPrivacyAndTermsAccepted = value ?? false),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      checkColor: Colors.white,
    );
  }

  void _goToHomePage(BuildContext context) =>
      NavigatorHelper.of(context).pushNamedAndRemoveUntil(
        HomePage.routeName,
        (route) => false,
      );

  Future<void> _goToSignUpStep2Page(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(SignUpPage.routeName);

  Future<void> _gToTopicsPage(BuildContext context, TopicType topicType) {
    return NavigatorHelper.of(context).push(
      MaterialPageRoute(builder: (_) => TopicPage(id: topicType)),
    );
  }

  Future<void> _goToLoginPage(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(LoginPage.routeName);
}
