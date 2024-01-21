import 'package:flutter/material.dart';
import 'package:masaj/features/account/models/verification_code_screen.dart';
import 'package:masaj/features/account/pages/account_screen.dart';
import 'package:masaj/features/account/pages/create_new_password_screen.dart';
import 'package:masaj/features/account/pages/manage_members_screen.dart';
import 'package:masaj/features/account/pages/my_profile_screen.dart';
import 'package:masaj/features/account/pages/phone_screen.dart';
import 'package:masaj/features/address/pages/add_new_address_screen.dart';
import 'package:masaj/features/address/pages/map_location_picker.dart';
import 'package:masaj/features/auth/presentation/pages/change_password_page.dart';
import 'package:masaj/features/auth/presentation/pages/edit_user_info_page.dart';
import 'package:masaj/features/auth/presentation/pages/email_verification_page.dart';
import 'package:masaj/features/auth/presentation/pages/forget_password_page.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:masaj/features/auth/presentation/pages/sign_up_page.dart';
import 'package:masaj/features/bookings_tab/presentation/pages/booking_details.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/intro/presentation/pages/choose_language_page.dart';
import 'package:masaj/features/intro/presentation/pages/guide_page.dart';
import 'package:masaj/features/legal/pages/cancellation_policy_screen.dart';
import 'package:masaj/features/legal/pages/conditions_screen.dart';
import 'package:masaj/features/legal/pages/legal_screen.dart';
import 'package:masaj/features/legal/pages/privacy_policy_screen.dart';
import 'package:masaj/features/legal/pages/reschedule_policy_screen.dart';
import 'package:masaj/features/legal/pages/terms_and_condititons_screen.dart';
import 'package:masaj/features/medical_form/pages/medical_form_screen.dart';
import 'package:masaj/features/splash/presentation/pages/splash_page.dart';
import 'package:masaj/features/wallet/pages/top_up_wallet_screen.dart';
import 'package:masaj/features/wallet/pages/wallet_screen.dart';

final routes = <String, WidgetBuilder>{
  SplashPage.routeName: (context) => const SplashPage(),
  OTPVerificationPage.routeName: (context) => const OTPVerificationPage(),
  MapLocationPicker.routeName: (context) => MapLocationPicker.builder(context),
  BookingDetialsScreen.routeName: (context) => const BookingDetialsScreen(),
  GuidePage.routeName: (context) => const GuidePage(),
  LoginPage.routeName: (context) => const LoginPage(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  ForgetPasswordPage.routeName: (context) => const ForgetPasswordPage(),
  ChangePasswordPage.routeName: (context) => const ChangePasswordPage(),
  EditUserInfoPage.routeName: (context) => const EditUserInfoPage(),
  ChooseLanguagePage.routeName: (context) => const ChooseLanguagePage(),
  EmailVerificationPage.routeName: (context) => const EmailVerificationPage(),
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
  // AddMemberScreen.routeName: (context) => AddMemberScreen.builder(context),
  AddNewAddressScreen.routeName: (context) =>
      AddNewAddressScreen.builder(context),
  ConditionsScreen.routeName: (context) => ConditionsScreen.builder(context),
  TopUpWalletScreen.routeName: (context) => TopUpWalletScreen.builder(context),
  VerificationCodeScreen.routeName: (context) =>
      VerificationCodeScreen.builder(context),
  PhoneScreen.routeName: (context) => PhoneScreen.builder(context),
  AccountScreen.routeName: (context) => AccountScreen.builder(context),
  CreateNewPasswordScreen.routeName: (context) =>
      CreateNewPasswordScreen.builder(context),
  MyProfileScreen.routeName: (context) => MyProfileScreen.builder(context),
};
