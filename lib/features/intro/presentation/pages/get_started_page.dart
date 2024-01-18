import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/email_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/auth/presentation/pages/sign_up_page.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:size_helper/size_helper.dart';

class GetStartedPage extends StatefulWidget {
  static const routeName = '/GetStartedPage';

  const GetStartedPage({this.isLogin = false, super.key});

  final bool isLogin;

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      safeBottom: false,
      withBackground: true,
      backgroundPath: 'assets/images/get_started_background.svg',
      backgroundFit: BoxFit.fitWidth,
      backgroundAlignment: Alignment.topCenter,
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);

        if (state.isLoggedIn) {
          final user = state.user;

          return _goToHomePage(
            context,
            userFullName: user!.fullName,
          );
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              reverse: true,
              children: [
                _buildGetStartedText(),
                const SizedBox(height: 12.0),
                _buildAppleButton(context),
                _buildGoogleButton(context),
                _buildEmailButton(context),
                const SizedBox(height: 16.0),
              ].reversed.toList(),
            ),
          ),
          _buildLowerSection(context),
        ],
      ),
    );
  }

  Widget _buildGetStartedText() {
    return const TitleText.extraLarge(
      text: 'get_started_page_main_text',
      textAlign: TextAlign.start,
    );
  }

  Widget _buildLowerSection(BuildContext context) {
    return Expanded(
      flex: 2,
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
              _buildContinueAsGuestButton(context),
              const SizedBox(height: 24.0),
              _buildAlreadyHaveAccountButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueAsGuestButton(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 16.0,
            tabletLarge: 18.0,
            desktopSmall: 21.0,
          ),
        );
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final verticalPadding = context.sizeHelper(
      mobileExtraLarge: 14.0,
      tabletLarge: 18.0,
      desktopSmall: 21.0,
    );

    final authCubit = context.read<AuthCubit>();
    return SizedBox(
      width: screenWidth * 0.6,
      child: DefaultButton(
        label: 'continue_guest'.tr(),
        labelStyle: textStyle,
        backgroundColor: Colors.transparent,
        icon: const Icon(Icons.arrow_forward),
        padding: EdgeInsets.symmetric(vertical: verticalPadding - 10),
        iconLocation: DefaultButtonIconLocation.End,
        borderColor: Colors.white,
        onPressed: () async {
          await authCubit.continueAsGuest();
          _goToHomePage(context);
        },
      ),
    );
  }

  Widget _buildAlreadyHaveAccountButton(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 14.0,
            tabletLarge: 16.0,
            desktopSmall: 18.0,
          ),
        );
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: 'already_have_account_message'.tr(), style: textStyle),
          TextSpan(
            text: 'login'.tr(),
            style: textStyle.copyWith(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _goToLoginPage(context),
          ),
        ],
      ),
    );
  }

  Future<void> _goToLoginPage(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(LoginPage.routeName);

  Widget _buildAppleButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      isExpanded: true,
      borderColor: Colors.white,
      contentAlignment: MainAxisAlignment.start,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      label: 'continue_with_apple'.tr(),
      labelStyle: const TextStyle(color: Colors.white),
      icon: SvgPicture.asset(
        'assets/images/apple.svg',
        width: context.sizeHelper(
          tabletExtraLarge: 26.0,
          desktopSmall: 40.0,
        ),
      ),
      onPressed: () {
        return authCubit.loginWithApple(() => _showEmailDialog(context));
      },
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
                //   text: 'email_required'.tr(),
                //   margin: const EdgeInsets.all(12.0),
                // ),
                EmailTextFormField(
                  currentController: emailController,
                  currentFocusNode: emailFocusNode,
                  //hint: 'email',
                  margin: const EdgeInsets.all(8.0),
                ),
                DefaultButton(
                  label: 'confirm'.tr(),
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

  Widget _buildGoogleButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      isExpanded: true,
      borderColor: Colors.white,
      contentAlignment: MainAxisAlignment.start,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      label: 'continue_with_google'.tr(),
      labelStyle: const TextStyle(color: Colors.white),
      icon: SvgPicture.asset(
        'assets/images/google.svg',
        width: context.sizeHelper(
          tabletExtraLarge: 26.0,
          desktopSmall: 40.0,
        ),
      ),
      onPressed: () {
        return authCubit.loginWithGoogle(() => _showEmailDialog(context));
      },
    );
  }

  Widget _buildEmailButton(BuildContext context) {
    return DefaultButton(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      isExpanded: true,
      contentAlignment: MainAxisAlignment.start,
      backgroundColor: AppColors.SECONDARY_COLOR,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      label: 'continue_with_email'.tr(),
      labelStyle: const TextStyle(color: Colors.white),
      icon: SvgPicture.asset(
        'assets/images/email.svg',
        width: context.sizeHelper(
          tabletExtraLarge: 26.0,
          desktopSmall: 40.0,
        ),
      ),
      onPressed: () {
        if (widget.isLogin) {
          _goToLoginPage(context);
        }
        //todo
        // else
        //   _goToSignUpStep1Page(context);
      },
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
      showSnackBar(context, message: 'welcome'.tr(args: [userFullName]));
    }
  }

  void _goToSignUpStep2Page(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(SignUpPage.routeName);
}
