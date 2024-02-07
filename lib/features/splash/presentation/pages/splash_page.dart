import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/app_logo.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/features/address/presentation/pages/select_location_screen.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';

import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/email_verification_page.dart';
import 'package:masaj/features/auth/presentation/pages/sign_up_page.dart';
import 'package:masaj/features/intro/presentation/pages/choose_language_page.dart';
import 'package:masaj/features/intro/presentation/pages/guide_page.dart';
import 'package:masaj/features/quiz/presentation/pages/quiz_start_page.dart';
import 'package:masaj/features/splash/presentation/splash_cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/SplashPage';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });
    //TODO: just A Workaround for the issue of flutter_svg
    // Don't forget to remove it once the issue is fixed!!
    svg.cache.maximumSize = 1000;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.isError) {
          return showSnackBar(context, message: state.errorMessage);
        }

        if (state.isLoaded) {
          final user = authCubit.state.user;
          // if (authCubit.state.isGuest)
          //   return _goToHomePage(
          //     context,
          //   );

          final notLoggedIn = !authCubit.state.isLoggedIn;

          final isFirstLaunch = state.isFirstLaunch ?? true;
          final languageNotSet = state.isLanguageSet != true;
          final isNotVerified = user?.verified != true;
          final countryNotSet = state.isCountrySet != true;
          final quicIsNotAnswered = user?.quizAnswered != true;

          if (languageNotSet) return _goToChooseLanguagePage(context);
          if (countryNotSet) return _goToSelectLocationPage(context);
          if (isFirstLaunch) return _goToGuidePage(context);
          if (notLoggedIn) return _goToLoginPage(context);
          if (isNotVerified) return _goToOtpVerify(context);
          if (quicIsNotAnswered) return gotToQuiz(context);

          //TODO need refactoring

          if (languageNotSet) return _goToChooseLanguagePage(context);
          if (isFirstLaunch) return _goToGuidePage(context);
          if (countryNotSet) return _goToSelectLocationPage(context);
          if (notLoggedIn) return _goToLoginPage(context);

          return _goToHomePage(
            context,
          );
        }
      },
      child: CustomAppPage(
          withBackground: true,
          // safeBottom: false,
          backgroundPath: 'assets/images/Bg.png',
          child: Center(
            child: AppLogo(
              width: 208.w,
              height: 34.h,
            ),
          )),
    );
  }

  void _goToLoginPage(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(LoginPage.routeName);

  void _goToHomePage(BuildContext context) {
    NavigatorHelper.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  void _goToGuidePage(BuildContext context) {
    NavigatorHelper.of(context).pushReplacementNamed(GuidePage.routeName);
  }

  void _goToSignUpStep2Page(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(SignUpPage.routeName);

  void _goToChooseLanguagePage(BuildContext context) =>
      NavigatorHelper.of(context)
          .pushReplacementNamed(ChooseLanguagePage.routeName);

  void _goToSelectLocationPage(BuildContext context) =>
      NavigatorHelper.of(context)
          .pushReplacementNamed(SelectLocationScreen.routeName);

  void _goToEmailVerificationPage(BuildContext context) =>
      NavigatorHelper.of(context)
          .pushReplacementNamed(EmailVerificationPage.routeName);
  void _goToOtpVerify(BuildContext context) => NavigatorHelper.of(context)
      .pushReplacementNamed(OTPVerificationPage.routeName);
  void gotToQuiz(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(QuizStartPage.routeName);
}
