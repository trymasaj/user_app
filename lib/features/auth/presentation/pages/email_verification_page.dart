import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../intro/presentation/pages/get_started_page.dart';
import '../../../../shared_widgets/stateless/app_logo.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../blocs/auth_cubit/auth_cubit.dart';

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
    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 16.0,
            tabletLarge: 18.0,
            desktopSmall: 21.0,
          ),
        );

    return DefaultButton(
      label: 'back_to_login'.tr(),
      isExpanded: true,
      contentAlignment: MainAxisAlignment.start,
      backgroundColor: AppColors.SECONDARY_COLOR,
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      iconLocation: DefaultButtonIconLocation.End,
      labelStyle: textStyle,
      icon: SvgPicture.asset(
        'lib/res/assets/email.svg',
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

    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 16.0,
            tabletLarge: 18.0,
            desktopSmall: 21.0,
          ),
        );

    return DefaultButton(
      label: 'refresh'.tr(),
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
        decoration: BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
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
            text: 'did_not_receive_email'.tr(),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14.0),
          ),
          TextSpan(
            text: 'resend'.tr(),
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
        GetStartedPage.routeName,
        (route) => false,
      );

  VoidCallback _showResendSuccessSnackBar(BuildContext context) =>
      () => showSnackBar(context, message: 'email_sent_successfully'.tr());
}
