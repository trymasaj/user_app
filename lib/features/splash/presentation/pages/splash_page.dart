import 'package:masaj/features/auth/presentation/pages/login_page.dart';

import '../../../../shared_widgets/stateless/app_logo.dart';

import '../../../../di/injector.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../auth/presentation/pages/email_verification_page.dart';
import '../../../auth/presentation/pages/sign_up_page.dart';
import '../../../intro/presentation/pages/choose_language_page.dart';
import '../../../intro/presentation/pages/guide_page.dart';
import '../splash_cubit/splash_cubit.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../home/presentation/pages/home_page.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/SplashPage';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    //TODO: just A Workaround for the issue of flutter_svg
    // Don't forget to remove it once the issue is fixed!!
    svg.cache.maximumSize = 1000;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocProvider(
      create: (_) => Injector().splashCubit..init(),
      lazy: false,
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.isError)
            return showSnackBar(context, message: state.errorMessage);

          if (state.isLoaded) {
            final user = authCubit.state.user;
            // if (authCubit.state.isGuest)
            //   return _goToHomePage(
            //     context,
            //   );

            final notLoggedIn = !authCubit.state.isLoggedIn;

            final isFirstLaunch = state.isFirstLaunch ?? true;
            final languageNotSet = state.isLanguageSet != true;

            if (languageNotSet) return _goToChooseLanguagePage(context);
            if (isFirstLaunch) return _goToGuidePage(context);
            if (notLoggedIn) return _goToLoginPage(context);

            return _goToHomePage(
              context,
            );
          }
        },
        child: const CustomAppPage(
          withBackground: true,
          safeBottom: false,
          child: Column(
            children: [
              Spacer(),
              AppLogo(),
              Spacer(),
            ],
          ),
        ),
      ),
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

  void _goToEmailVerificationPage(BuildContext context) =>
      NavigatorHelper.of(context)
          .pushReplacementNamed(EmailVerificationPage.routeName);
}
