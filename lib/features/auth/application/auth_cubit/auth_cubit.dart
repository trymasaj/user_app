import 'dart:async';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
// import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/core/data/show_case_helper.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/domain/exceptions/social_media_login_canceled_exception.dart';
import 'package:masaj/features/auth/data/managers/auth_manager.dart';

import 'package:masaj/core/data/models/interest_model.dart';
import 'package:masaj/features/account/data/models/contact_us_message_model.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {

  final AuthManager _authManager;
  final ShowCaseHelper _showCaseHelper;
  final SystemService _system;

  AuthCubit(
    this._authManager,
    this._showCaseHelper,
    this._system
  ):super(const AuthState());


  Future<void> init() async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final user = await _authManager.getUserData();
      //TODO this is need refactoring by puting status in cubit and when user press continure as guest we will change the status to guest
      emit(user?.token == null ||
              user?.verified == false ||
              user?.isProfileCompleted == false
          ? state.copyWith(status: AuthStateStatus.guest, user: user)
          : state.copyWith(status: AuthStateStatus.loggedIn, user: user));

      final userFirebaseId = (user?.id ?? '') + (user?.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].init()' ,e);
    } catch (e) {
      logger.error('[$runtimeType].init()' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> login(
      String phoneNumber, String password, String countryCode) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user =
          await _authManager.login(phoneNumber, countryCode, password);
      emit(state.copyWith(status: AuthStateStatus.loggedIn, user: user));

      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
      //AdjustTracker.trackLogin();
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].login($phoneNumber,$password, $countryCode)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].login($phoneNumber,$password, $countryCode)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loginWithGoogle(
      Future<String?> Function() onEmailRequiredError) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user = await _authManager.loginWithGoogle(onEmailRequiredError);
      final isLoggedIn =
          (user.isProfileCompleted ?? false) && (user.verified ?? false);

      isLoggedIn
          ? emit(state.copyWith(status: AuthStateStatus.loggedIn, user: user))
          : emit(state.copyWith(
              status: AuthStateStatus.completeSignUp, user: user));
      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
      if (user.isProfileCompleted ?? false) {
        //AdjustTracker.trackLogin();
      } else {
        //AdjustTracker.trackGuestRegistration();
      }
    } on SocialLoginCanceledException catch (e) {
      logger.error('[$runtimeType].loginWithGoogle()' ,e);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].loginWithGoogle()' ,e);
    } catch (e) {
      logger.error('[$runtimeType].loginWithGoogle()' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
      rethrow;
    }
  }

  Future<void> loginWithApple(
      Future<String?> Function() onEmailRequiredError) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user = await _authManager.loginWithApple(onEmailRequiredError);
      final isLoggedIn =
          (user.isProfileCompleted ?? false) && (user.verified ?? false);
      isLoggedIn
          ? emit(state.copyWith(status: AuthStateStatus.loggedIn, user: user))
          : emit(state.copyWith(
              status: AuthStateStatus.completeSignUp, user: user));
      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
      // if (user.isProfileCompleted ?? false) {
      //   AdjustTracker.trackLogin();
      // } else {
      //   AdjustTracker.trackGuestRegistration();
      // }
    } on SocialLoginCanceledException catch (e) {
      logger.error('[$runtimeType].loginWithApple()' ,e);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].loginWithApple()' ,e);
    } catch (e) {
      logger.error('[$runtimeType].loginWithApple()' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> verifyUser(String otp) async {
    if (state.user == null) return;
    final afterLogin = state.status != AuthStateStatus.guest;

    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user = await _authManager.verifyOtp(state.user!, otp,
          afterLogin: afterLogin);
      emit(state.copyWith(
          status: afterLogin ? AuthStateStatus.loggedIn : AuthStateStatus.guest,
          user: user));
    } on SocialLoginCanceledException catch (e) {
      logger.error('[$runtimeType].verifyUser($otp)' ,e);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].verifyUser($otp)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].verifyUser($otp)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changePhone({
    String? phone,
    String? countryCode,
  }) async {
    if (phone == null || countryCode == null) return;

    emit(state.copyWith(accountStatus: AccountStateStatus.loading));
    try {
      final response = await _authManager.changePhone(
        phone: phone,
        countryCode: countryCode,
      );
      emit(state.copyWith(
        accountStatus: AccountStateStatus.changePhone,
      ));
    } on SocialLoginCanceledException catch (e) {
      logger.error('[$runtimeType].changePhone($phone, $countryCode)' ,e);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].changePhone($phone, $countryCode)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].changePhone($phone, $countryCode)' ,e);
      emit(state.copyWith(
          accountStatus: AccountStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> verifyChangePhone({
    String? phone,
    String? countryCode,
    String? otp,
  }) async {
    if (phone == null || countryCode == null || otp == null) return;

    emit(state.copyWith(accountStatus: AccountStateStatus.loading));
    try {
      final user = await _authManager.verifyChangePhone(
          phone: phone, countryCode: countryCode, otp: otp);
      emit(state.copyWith(
          accountStatus: AccountStateStatus.verifyingChangePhone, user: user));
    } on SocialLoginCanceledException catch (e) {
      logger.error('[$runtimeType].verifyChangePhone($phone, $countryCode, $otp)' ,e);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].verifyChangePhone($phone, $countryCode, $otp)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].verifyChangePhone($phone, $countryCode, $otp)' ,e);
      emit(state.copyWith(
          accountStatus: AccountStateStatus.error, errorMessage: e.toString()));
    }
  }

  // resendOtp
  Future<void> resendOtp() async {
    if (state.user == null) return;
    final afterLogin = state.status != AuthStateStatus.guest;

    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authManager.resendOtp(
        state.user!,
      );

      emit(state.copyWith(
        beginResendTimer: _system.now,
        status: afterLogin ? AuthStateStatus.loggedIn : AuthStateStatus.guest,
      ));
    } on SocialLoginCanceledException catch (e) {
      logger.error('[$runtimeType].resendOTP()' ,e);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].resendOTP()' ,e);
    } catch (e) {
      logger.error('[$runtimeType].resendOTP()' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> signUp(User user) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final userAfterSignUp = await _authManager.signUp(user);
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn, user: userAfterSignUp));
      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
      // AdjustTracker.trackRegistrationCompleted(userAfterSignUp.toMap());
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].signup($user)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].signup($user)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateProfileInformation(User user) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final userAfterSignUp =
          await _authManager.updateProfileInformation(user);
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn, user: userAfterSignUp));
      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].updateProfileInfo($user)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].updateProfileInfo($user)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authManager.forgetPassword(email);
      emit(state.copyWith(status: AuthStateStatus.initial, user: null));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].forgetPassword($email)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].forgetPassword($email)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> verifyForgetPassword(String otp, String email) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user = await _authManager.verifyForgetPassword(otp, email);
      emit(state.copyWith(status: AuthStateStatus.initial, user: user));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].verifyForgetPassword($email)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].verifyForgetPassword($email)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> resetPassword(
      String password, String passwordConfirm, int userId, String token) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user = await _authManager.resetPassword(
          password, password, userId, token);
      emit(state.copyWith(status: AuthStateStatus.guest, user: user));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].resetPassword($password, $passwordConfirm, $userId, $token)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].resetPassword($password, $passwordConfirm, $userId, $token)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    try {
      emit(state.copyWith(accountStatus: AccountStateStatus.loading));
      await _authManager.changePassword(
          oldPassword, newPassword, confirmPassword);
      emit(state.copyWith(accountStatus: AccountStateStatus.changePassword));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].changePassword($oldPassword, $newPassword, $confirmPassword)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].changePassword($oldPassword, $newPassword, $confirmPassword)' ,e);
      emit(state.copyWith(
          accountStatus: AccountStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getUserData([bool fromRemote = false]) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final user = await _authManager.getUserData(fromRemote);
      var oldUser = state.user;
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn,
          user: user?.copyWith(
            token: oldUser?.token,
            refreshToken: oldUser?.refreshToken,
            points: oldUser?.points,
          )));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].getUserData($fromRemote)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].getUserData($fromRemote)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<bool> editAccountData(User? newUser) async {
    if (newUser == null) return false;
    if (newUser.fullName == state.user?.fullName &&
        newUser.email == state.user?.email &&
        newUser.gender == state.user?.gender &&
        newUser.ageGroup == state.user?.ageGroup) return false;
    final oldUser = state.user;
    emit(state.copyWith(accountStatus: AccountStateStatus.loading));
    try {
      final user = await _authManager.editAccountData(newUser.copyWith(
          id: oldUser!.id,
          phone: oldUser.phone,
          countryCode: oldUser.countryCode));

      emit(state.copyWith(
          accountStatus: AccountStateStatus.updateUser, user: user));
      return true;
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].editAccountData($newUser)' ,e);
      return false;
    } catch (e) {
      logger.error('[$runtimeType].editAccountData($newUser)' ,e);
      emit(state.copyWith(
          accountStatus: AccountStateStatus.error, errorMessage: e.toString()));
      return false;
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authManager.logout();
    } catch (e) {
      logger.error('[$runtimeType].logout()' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
    emit(const AuthState(status: AuthStateStatus.guest));
  }

  Future<void> deleteAccount() async {
    final user = state.user;

    final message = ContactUsMessage(
      name: user?.fullName ?? '',
      email: user?.email ?? '',
      message: 'Request account deletion\n User ID: ${user?.id ?? ''}',
    );
    try {
      await _authManager.deleteAccount(message);
      emit(state.copyWith(status: AuthStateStatus.loggedIn));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].deleteAccount()' ,e);
    } catch (e) {
      logger.error('[$runtimeType].deleteAccount()' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> informBackendAboutLanguageChanges(String languageCode) async {
    try {
      await _authManager.informBackendAboutLanguageChanges(languageCode);
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].informBackendAboutLanguageChanges($languageCode)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].informBackendAboutLanguageChanges($languageCode)' ,e);
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateUserNotificationStatus(bool isEnabled) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      await _authManager.updateUserNotificationStatus(isEnabled);
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn,
          user: state.user?.copyWith(notificationEnabled: isEnabled)));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].updateUserNotificationStatus($isEnabled)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].updateUserNotificationStatus($isEnabled)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateUserPoints(int points) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      await _authManager.updateUserPoints(points);
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn,
          user: state.user?.copyWith(points: points)));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].updateUserPoints($points)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].updateUserPoints($points)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getInterestData() async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));

      final interests = await _authManager.getInterestData();

      List<int?>? selectedInterests = List.filled(interests.length, null);

      for (var i = 0; i < interests.length; i++) {
        if (interests[i].selected) selectedInterests[i] = interests[i].id;
      }

      emit(state.copyWith(
          status: AuthStateStatus.interestsLoaded,
          interests: interests,
          selectedInterests: selectedInterests));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].getInterestData()' ,e);
    } catch (e) {
      logger.error('[$runtimeType].getInterestData()' ,e);
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void selectGender(Gender gender) {
    emit(state.copyWith(status: AuthStateStatus.loading));

    emit(state.copyWith(
      status: AuthStateStatus.loggedIn,
      selectedGender: gender,
    ));
  }

  Future<void> resendVerificationEmail(VoidCallback onSuccess) async {
    try {
      await _authManager.resendVerificationEmail();
      onSuccess();
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].resendVerificationEmail($onSuccess)' ,e);
    } catch (e) {
      logger.error('[$runtimeType].resendVerificationEmail($onSuccess)' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refreshUser() async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));

      final emailVerified = await _authManager.checkEmailVerified();
      emit(state.copyWith(
        status: AuthStateStatus.loggedIn,
        user: state.user!.copyWith(emailVerified: emailVerified),
      ));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].refreshUser()' ,e);
    } catch (e) {
      logger.error('[$runtimeType].refreshUser()' ,e);
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> continueAsGuest() async {
    try {
      final user = await _authManager.loginAsGuest();
      emit(state.copyWith(status: AuthStateStatus.guest, user: user));
    } on RedundantRequestException catch (e) {
      logger.error('[$runtimeType].continueAsGuest()' ,e);
    } catch (e) {
      logger.error('[$runtimeType].continueAsGuest()' ,e);
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> resetShowCaseDisplayedPages() =>
      _showCaseHelper.resetShowCaseDisplayed();

  void updateTicketMXToken(String token) {
    emit(state.copyWith(
      status: AuthStateStatus.loggedIn,
      user: state.user!.copyWith(ticketMXAccessToken: token),
    ));
  }

  Future<void> submitQuizAnsewerd() async {
    try {
      final user = await _authManager.updateUser(
        state.user!.copyWith(quizAnswered: true),
      );
      emit(state.copyWith(status: AuthStateStatus.loggedIn, user: user));
    } catch (e) {
      logger.error('[$runtimeType].submitQuizAnsewerd()' ,e);
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}

/*
{
  status: 404,
    errorType: ValidationError,
  message: User not found,
  errors:{
    fieldName: [

    ],
    fieldName2: [

    ]

  }
  timepStamp: 2021-09-30T12:00:00Z
  

}

*/
