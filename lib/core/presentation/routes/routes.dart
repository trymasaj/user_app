import 'package:flutter/material.dart';
import 'package:masaj/features/account/models/verification_code_screen.dart';
import 'package:masaj/features/account/pages/account_screen.dart';
import 'package:masaj/features/account/pages/create_new_password_screen.dart';
import 'package:masaj/features/account/pages/manage_members_screen.dart';
import 'package:masaj/features/account/pages/my_profile_screen.dart';
import 'package:masaj/features/account/pages/phone_screen.dart';
import 'package:masaj/features/address/presentation/pages/address_page.dart';
import 'package:masaj/features/address/presentation/pages/update_address_screen.dart';
import 'package:masaj/features/address/presentation/pages/map_location_picker.dart';
import 'package:masaj/features/address/presentation/pages/select_location_screen.dart';
import 'package:masaj/features/auth/presentation/pages/change_password_page.dart';
import 'package:masaj/features/auth/presentation/pages/edit_user_info_page.dart';
import 'package:masaj/features/auth/presentation/pages/email_verification_page.dart';
import 'package:masaj/features/auth/presentation/pages/forget_password_page.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:masaj/features/auth/presentation/pages/sign_up_page.dart';
import 'package:masaj/features/book_service/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/book_service/presentation/screens/book_servcie_screen.dart';
import 'package:masaj/features/book_service/presentation/screens/select_therapist_screen.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/review_tips_cubit/review_tips_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/pages/add_review_screen.dart';
import 'package:masaj/features/bookings_tab/presentation/pages/booking_details.dart';
import 'package:masaj/features/gifts/presentaion/pages/gift_cards.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/home/presentation/pages/notifications_page.dart';
import 'package:masaj/features/intro/presentation/pages/choose_language_page.dart';
import 'package:masaj/features/intro/presentation/pages/guide_page.dart';
import 'package:masaj/features/legal/pages/cancellation_policy_screen.dart';
import 'package:masaj/features/legal/pages/conditions_screen.dart';
import 'package:masaj/features/legal/pages/legal_screen.dart';
import 'package:masaj/features/legal/pages/privacy_policy_screen.dart';
import 'package:masaj/features/legal/pages/reschedule_policy_screen.dart';
import 'package:masaj/features/legal/pages/terms_and_condititons_screen.dart';
import 'package:masaj/features/medical_form/presentation/pages/medical_form_screen.dart';
import 'package:masaj/features/payment/presentaion/pages/checkout_screen.dart';
import 'package:masaj/features/providers_tab/presentation/pages/provider_details_screen.dart';
import 'package:masaj/features/members/presentaion/pages/add_member_screen.dart';
import 'package:masaj/features/quiz/presentation/pages/quiz_start_page.dart';
import 'package:masaj/features/services/presentation/screens/serice_details_screen.dart';
import 'package:masaj/features/splash/presentation/pages/splash_page.dart';
import 'package:masaj/features/wallet/pages/top_up_wallet_screen.dart';
import 'package:masaj/features/wallet/pages/wallet_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  final name = settings.name;
  switch (name) {
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    case OTPVerificationPage.routeName:
      return MaterialPageRoute(
          builder: (context) => const OTPVerificationPage());
    case MapLocationPicker.routeName:
      return MaterialPageRoute(
          builder: (context) => MapLocationPicker.builder(
                arguments as MapLocationPickerArguments,
              ));
    case AddressPage.routeName:
      return MaterialPageRoute(builder: (context) => const AddressPage());

    case QuizStartPage.routeName:
      return MaterialPageRoute(builder: (context) => const QuizStartPage());
    case BookingDetialsScreen.routeName:
      return MaterialPageRoute<ReviewTipsCubitState?>(
          builder: (context) =>
              BookingDetialsScreen.builder(context, arguments as int));
    case AddReviewScreen.routeName:
      return AddReviewScreen.route(arguments as BookingModel);
    case GuidePage.routeName:
      return MaterialPageRoute(builder: (context) => const GuidePage());
    case LoginPage.routeName:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case SignUpPage.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpPage());
    case ForgetPasswordPage.routeName:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordPage());
    case ChangePasswordPage.routeName:
      return MaterialPageRoute(
          builder: (context) => const ChangePasswordPage());
    case SelectLocationScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SelectLocationScreen());
    case EditUserInfoPage.routeName:
      return MaterialPageRoute(builder: (context) => const EditUserInfoPage());
    case ChooseLanguagePage.routeName:
      final bool? fromSetting = arguments as bool?;
      return MaterialPageRoute(
          builder: (context) =>
              ChooseLanguagePage(fromSetting: fromSetting ?? false));
    case EmailVerificationPage.routeName:
      return MaterialPageRoute(
          builder: (context) => const EmailVerificationPage());
    case HomePage.routeName:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case LegalScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => LegalScreen.builder(context));
    case PrivacyPolicyScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => PrivacyPolicyScreen.builder(context));
    case TermsAndCondititonsScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => TermsAndCondititonsScreen.builder(context));
    case ReschedulePolicyScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ReschedulePolicyScreen.builder(context));
    case CancellationPolicyScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => CancellationPolicyScreen.builder(context));
    case WalletScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => WalletScreen.builder(context));
    case MedicalFormScreen.routeName:
      return MaterialPageRoute(builder: (context) => const MedicalFormScreen());
    case ManageMembersScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ManageMembersScreen());
    // case AddMemberScreen.routeName:
    //   return MaterialPageRoute(builder: (context) => AddMemberScreen.builder(context));
    case AddAddressScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => AddAddressScreen.builder());
    case NotificationsPage.routeName:
      return MaterialPageRoute(builder: (context) => NotificationsPage());

    case EditAddressScreen.routeName:
      return MaterialPageRoute(
          builder: (context) =>
              EditAddressScreen.builder(arguments as EditAddressArguments));

    case ConditionsScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ConditionsScreen.builder(context));
    case TopUpWalletScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => TopUpWalletScreen.builder(context));
    case VerificationCodeScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => VerificationCodeScreen.builder(context));
    case PhoneScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => PhoneScreen.builder(context));
    case AccountScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => AccountScreen.builder(context));
    case CreateNewPasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => CreateNewPasswordScreen.builder(context));
    case MyProfileScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => MyProfileScreen.builder(context));
    case ServiceDetailsScreen.routeName:
      final serviceDetailsScreenArguments =
          arguments as ServiceDetailsScreenArguments;
      return ServiceDetailsScreen.router(serviceDetailsScreenArguments);

    case ProviderDetailsScreen.routeName:
      // there is no arguments for this route
      final arguments =
          settings.arguments as ProviderDetailsScreenNavArguements;

      return ProviderDetailsScreen.router(
        therapist: arguments.therapist,
        providersTabCubit: arguments.providersTabCubit,
        homeTherapistsCubit: arguments.homeTherapistsCubit,
        avialbleTherapistCubit: arguments.avialbleTherapistCubit,
      );
    case BookServiceScreen.routeName:
      return BookServiceScreen.router();
    case AddMemberScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AddMemberScreen());
    case SelectTherapist.routeName:
      final avialbleTherapistCubit = arguments as AvialbleTherapistCubit;
      return SelectTherapist.route(
          avialbleTherapistCubit: avialbleTherapistCubit);
    case CheckoutScreen.routeName:
      return MaterialPageRoute(builder: (context) {
        return CheckoutScreen();
      });
    case GiftCardsScreen.routeName:
      return MaterialPageRoute(builder: (context) {
        return const GiftCardsScreen();
      });

    default:
  }
  return null;
}
