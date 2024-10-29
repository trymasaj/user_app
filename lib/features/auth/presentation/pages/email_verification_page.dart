import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/app_logo.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:size_helper/size_helper.dart';

class EmailVerificationPage extends StatefulWidget {
  static const routeName = '/EmailVerificationPage';

  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight =
        mediaQueryData.size.height - mediaQueryData.padding.top;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
        // if (state.isLoggedIn && state.user?.emailVerified == true)
      },
      child: CustomAppPage(
        withBackground: true,
        safeBottom: false,
        safeTop: true,
        backgroundPath: 'assets/images/sign_up_step_2_background.svg',
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
    final appLogoSize = context.sizeHelper(
      mobileExtraLarge: 70.0,
      tabletLarge: 90.0,
      desktopSmall: 120.0,
    );
    return Column(
      children: [
        const Spacer(flex: 3),
        AppLogo(width: appLogoSize, height: appLogoSize),
        const Spacer(),
        const TitleText(
          text: 'please_verify_your_email_message',
          textAlign: TextAlign.center,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        const Spacer(),
        _buildBackToLoginButton(context),
        const Spacer(),
        const TitleText.medium(
          text: 'please_click_on_refresh_button_message',
          textAlign: TextAlign.center,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        const Spacer(),
        _buildRefreshButton(context),
        const Spacer(),
        const TitleText.medium(
          text: 'please_check_your_spam_message',
          textAlign: TextAlign.center,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        const Spacer(),
        _buildLowerSection(context),
      ],
    );
  }

  Widget _buildBackToLoginButton(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 16.0,
            tabletLarge: 18.0,
            desktopSmall: 21.0,
          ),
        );

    return DefaultButton(
      label: AppText.back_to_login,
      isExpanded: true,
      contentAlignment: MainAxisAlignment.start,
      backgroundColor: AppColors.SECONDARY_COLOR,
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      iconLocation: DefaultButtonIconLocation.End,
      labelStyle: textStyle,
      icon: SvgPicture.asset(
        'assets/images/email.svg',
        width: context.sizeHelper(
          tabletExtraLarge: 26.0,
          desktopSmall: 40.0,
        ),
      ),
      onPressed: () => _goToLoginPage(context),
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 16.0,
            tabletLarge: 18.0,
            desktopSmall: 21.0,
          ),
        );

    return DefaultButton(
      label: AppText.refresh,
      isExpanded: true,
      contentAlignment: MainAxisAlignment.start,
      backgroundColor: AppColors.SECONDARY_COLOR,
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      labelStyle: textStyle,
      onPressed: authCubit.refreshUser,
    );
  }

  Widget _buildLowerSection(BuildContext context) {
    return Expanded(
      flex: 4,
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
              const SizedBox(height: 16.0),
              _buildDidNotReceiveEmailText(context),
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
    final authCubit = context.read<AuthCubit>();
    return SizedBox(
      width: screenWidth * 0.6,
      child: DefaultButton(
        label: AppText.continue_guest,
        labelStyle: textStyle,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        backgroundColor: Colors.transparent,
        borderWidth: 2.0,
        icon: const Icon(Icons.arrow_forward),
        iconLocation: DefaultButtonIconLocation.End,
        borderColor: Colors.white,
        isExpanded: true,
        onPressed: () async {
          await authCubit.continueAsGuest();
        },
      ),
    );
  }

  Widget _buildDidNotReceiveEmailText(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppText.did_not_receive_email,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.0),
          ),
          TextSpan(
            text: AppText.resend,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => authCubit
                  .resendVerificationEmail(_showResendSuccessSnackBar(context)),
          ),
        ],
      ),
    );
  }

  Future<void> _goToLoginPage(BuildContext context) =>
      NavigatorHelper.of(context).pushNamedAndRemoveUntil(
        LoginPage.routeName,
        (route) => false,
      );

  VoidCallback _showResendSuccessSnackBar(BuildContext context) =>
      () => showSnackBar(context, message: AppText.email_sent_successfully);
}
