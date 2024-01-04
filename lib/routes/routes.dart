import 'package:masaj/features/account/presentation/pages/account_screen/account_screen.dart';
import 'package:masaj/features/account/presentation/pages/change_password/create_new_password_one_screen.dart';
import 'package:masaj/features/account/presentation/pages/my_profile_screen/my_profile_screen.dart';
import 'package:masaj/features/account/presentation/pages/phone_screen/phone_screen.dart';
import 'package:masaj/features/account/presentation/pages/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:masaj/features/account/presentation/pages/terms_and_condititons_screen/terms_and_condititons_screen.dart';
import 'package:masaj/features/account/presentation/pages/verification_code_screen/verification_code_screen.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/settings_tab/presentation/pages/add_member_screen/add_member_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/add_new_address_screen/add_new_address_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/cancellation_policy_screen/cancellation_policy_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/conditions_screen/conditions_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/gift_cards_my_gifts_tab_container_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/legal_screen/legal_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/manage_members_screen/manage_members_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/medical_form_screen/medical_form_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/reschedule_policy_screen/reschedule_policy_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/top_up_wallet_screen/top_up_wallet_screen.dart';
import 'package:masaj/features/settings_tab/presentation/pages/wallet_screen/wallet_screen.dart';

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
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

final routes = <String, WidgetBuilder>{
  SplashPage.routeName: (context) => const SplashPage(),
  GuidePage.routeName: (context) => const GuidePage(),
  GetStartedPage.routeName: (context) => const GetStartedPage(),
  LoginPage.routeName: (context) => const LoginPage(),
  SignUpStep1Page.routeName: (context) => const SignUpStep1Page(),
  SignUpPage.routeName: (context) => const SignUpPage(),
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
  HomePage.routeName: (context) => const HomePage(),
  LegalScreen.routeName: (context) => LegalScreen.builder(context),
  PrivacyPolicyScreen.routeName: (context) =>
      PrivacyPolicyScreen.builder(context),
  TermsAndCondititonsScreen.routeName: (context) =>
      TermsAndCondititonsScreen.builder(context),
  ReschedulePolicyScreen.routeName: (context) =>
      ReschedulePolicyScreen.builder(context),
  CancellationPolicyScreen.routeName: (context) =>
      CancellationPolicyScreen.builder(context),
  WalletScreen.routeName: (context) => WalletScreen.builder(context),
  MedicalFormScreen.routeName: (context) => MedicalFormScreen.builder(context),
  ManageMembersScreen.routeName: (context) =>
      ManageMembersScreen.builder(context),
  AddMemberScreen.routeName: (context) => AddMemberScreen.builder(context),
  AddNewAddressScreen.routeName: (context) =>
      AddNewAddressScreen.builder(context),
  ConditionsScreen.routeName: (context) => ConditionsScreen.builder(context),
  GiftCardsScreen.routeName: (context) => GiftCardsScreen.builder(context),
  TopUpWalletScreen.routeName: (context) => TopUpWalletScreen.builder(context),
  VerificationCodeScreen.routeName: (context) =>
      VerificationCodeScreen.builder(context),
  PhoneScreen.routeName: (context) => PhoneScreen.builder(context),
  AccountScreen.routeName: (context) => AccountScreen.builder(context),
  CreateNewPasswordOneScreen.routeName: (context) =>
      CreateNewPasswordOneScreen.builder(context),
  MyProfileScreen.routeName: (context) => MyProfileScreen.builder(context),
};
