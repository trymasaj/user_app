import '../../../intro/presentation/pages/get_started_page.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../home/presentation/pages/home_page.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../blocs/auth_cubit/auth_cubit.dart';
import 'email_verification_page.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/text_fields/password_text_form_field.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'forget_password_page.dart';
import 'sign_up_step_2_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  bool _isAutoValidating = false;

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

        if (state.isLoggedIn) {
          final user = state.user;
          final notCompleteRegistration = user?.completeRegistration != true;
          final isNotEmailVerified = user?.emailVerified != true;

          if (notCompleteRegistration) return _goToSignUpStep2Page(context);
          if (isNotEmailVerified) return _goToEmailVerificationPage(context);

          return _goToHomePage(
            context,
            userFullName: user!.fullName,
          );
        }
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
            ),
          ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitleText(text: 'your_email'),
              const SizedBox(height: 8.0),
              EmailTextFormField(
                currentFocusNode: _emailFocusNode,
                nextFocusNode: _passwordFocusNode,
                currentController: _emailTextController,
              ),
              const SizedBox(height: 16.0),
              const TitleText(text: 'password'),
              const SizedBox(height: 8.0),
              PasswordTextFormField(
                currentFocusNode: _passwordFocusNode,
                currentController: _passwordTextController,
              ),
              const SizedBox(height: 8.0),
              _buildForgetPasswordButton(context),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
          child: const SubtitleText(
            text: 'forget_password',
          ),
          onPressed: () => _goToForgetPasswordPage(context)),
    );
  }

  Widget _buildLowerSection(BuildContext context) {
    return Expanded(
      flex: 5,
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
              const SizedBox(height: 8.0),
              _buildLoginButton(context),
              const SizedBox(height: 16.0),
              _buildContinueAsGuestButton(context),
              const SizedBox(height: 16.0),
              _buildDoNotHaveAccountButton(context),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
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
        label: 'login'.tr(),
        labelStyle: textStyle,
        backgroundColor: Colors.transparent,
        borderWidth: 2.0,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        icon: const Icon(Icons.arrow_forward),
        iconLocation: DefaultButtonIconLocation.End,
        borderColor: Colors.white,
        isExpanded: true,
        onPressed: () async {
          if (_isNotValid()) return;
          await authCubit.login(
            _emailTextController.text.trim(),
            _passwordTextController.text,
          );
        },
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
        padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  Widget _buildDoNotHaveAccountButton(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 14.0,
            tabletLarge: 18.0,
            desktopSmall: 18.0,
          ),
        );
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: 'dont_have_account'.tr(), style: textStyle),
          TextSpan(
            text: 'sign_up'.tr(),
            style: textStyle.copyWith(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _goToGetStartedPage(context),
          ),
        ],
      ),
    );
  }

  void _goToGetStartedPage(BuildContext context) {
    NavigatorHelper.of(context).pushReplacementNamed(GetStartedPage.routeName);
  }

  Future<void> _goToForgetPasswordPage(BuildContext context) async {
    final success = await NavigatorHelper.of(context)
        .pushNamed(ForgetPasswordPage.routeName);
    if (success == true)
      showSnackBar(context, message: 'forget_password_success');
  }

  void _goToHomePage(
    BuildContext context, {
    String? userFullName,
  }) {
    NavigatorHelper.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()),
      (_) => false,
    );
    if (userFullName != null)
      showSnackBar(context, message: 'welcome'.tr(args: [userFullName]));
  }

  void _goToSignUpStep2Page(BuildContext context) => NavigatorHelper.of(context)
      .pushReplacementNamed(SignUpStep2Page.routeName);

  void _goToEmailVerificationPage(BuildContext context) =>
      NavigatorHelper.of(context)
          .pushReplacementNamed(EmailVerificationPage.routeName);
}
