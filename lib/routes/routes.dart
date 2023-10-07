import '../features/account/presentation/pages/contact_us_page.dart';
import '../features/account/presentation/pages/coupon_page.dart';
import '../features/account/presentation/pages/ehtemam_page.dart';
import '../features/account/presentation/pages/favorites_page.dart';
import '../features/account/presentation/pages/settings_page.dart';
import '../features/auth/presentation/pages/email_verification_page.dart';
import '../features/intro/presentation/pages/choose_language_page.dart';
import '../features/intro/presentation/pages/get_started_page.dart';
import '../features/intro/presentation/pages/guide_page.dart';
import '../features/auth/presentation/pages/edit_user_info_page.dart';
import 'package:flutter/material.dart';
import '../features/account/presentation/pages/about_us_page.dart';
import '../features/account/presentation/pages/points_page.dart';
import '../features/auth/presentation/pages/change_password_page.dart';
import '../features/auth/presentation/pages/forget_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/sign_up_step_1_page.dart';
import '../features/auth/presentation/pages/sign_up_step_2_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

final routes = <String, WidgetBuilder>{
  SplashPage.routeName: (context) => const SplashPage(),
  GuidePage.routeName: (context) => const GuidePage(),
  GetStartedPage.routeName: (context) => const GetStartedPage(),
  LoginPage.routeName: (context) => const LoginPage(),
  SignUpStep1Page.routeName: (context) => const SignUpStep1Page(),
  SignUpStep2Page.routeName: (context) => const SignUpStep2Page(),
  ForgetPasswordPage.routeName: (context) => const ForgetPasswordPage(),
  ChangePasswordPage.routeName: (context) => const ChangePasswordPage(),
  AboutUsPage.routeName: (context) => const AboutUsPage(),
  ContactUsPage.routeName: (context) => const ContactUsPage(),
  EditUserInfoPage.routeName: (context) => const EditUserInfoPage(),
  ChooseLanguagePage.routeName: (context) => const ChooseLanguagePage(),
  EmailVerificationPage.routeName: (context) => const EmailVerificationPage(),
  SettingsPage.routeName: (context) => const SettingsPage(),
  EhtemamPage.routeName: (context) => const EhtemamPage(),
  FavoritesPage.routeName: (context) => const FavoritesPage(),
  CouponPage.routeName: (context) => const CouponPage(),
  PointsPage.routeName: (context) => const PointsPage(),
};
