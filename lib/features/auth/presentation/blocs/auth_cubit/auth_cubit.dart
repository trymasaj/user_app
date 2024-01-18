import 'dart:async';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/models/interest_model.dart';
import 'package:masaj/core/data/show_case_helper.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/domain/exceptions/social_media_login_canceled_exception.dart';
import 'package:masaj/features/account/data/models/contact_us_message_model.dart';
import 'package:masaj/features/auth/data/models/user.dart';
import 'package:masaj/features/auth/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
    required ShowCaseHelper showCaseHelper,
  })  : _authRepository = authRepository,
        _showCaseHelper = showCaseHelper,
        super(const AuthState());

  final AuthRepository _authRepository;
  final ShowCaseHelper _showCaseHelper;

  Future<void> init() async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final user = await _authRepository.getUserData();
      emit(user?.accessToken == null
          ? state.copyWith(status: AuthStateStatus.guest, user: user)
          : state.copyWith(status: AuthStateStatus.loggedIn, user: user));

      if (user != null) {
        final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
        FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
        FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
      }
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user = await _authRepository.login(email, password);
      emit(state.copyWith(status: AuthStateStatus.loggedIn, user: user));

      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loginWithGoogle(
      Future<String?> Function() onEmailRequiredError) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user = await _authRepository.loginWithGoogle(onEmailRequiredError);

      emit(state.copyWith(status: AuthStateStatus.loggedIn, user: user));
      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
    } on SocialLoginCanceledException catch (e) {
      log(e.toString());
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loginWithApple(
      Future<String?> Function() onEmailRequiredError) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final user = await _authRepository.loginWithApple(onEmailRequiredError);
      emit(state.copyWith(status: AuthStateStatus.loggedIn, user: user));
      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
    } on SocialLoginCanceledException catch (e) {
      log(e.toString());
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> signUp(User user) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final userAfterSignUp = await _authRepository.signUp(user);
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn, user: userAfterSignUp));
      final userFirebaseId = (user.id ?? '') + (user.fullName ?? '');
      FirebaseCrashlytics.instance.setUserIdentifier(userFirebaseId);
      FirebaseAnalytics.instance.setUserId(id: userFirebaseId);
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.forgetPassword(email);
      emit(state.copyWith(status: AuthStateStatus.initial, user: null));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      await _authRepository.changePassword(oldPassword, newPassword);
      emit(state.copyWith(status: AuthStateStatus.loggedIn));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getUserData([bool fromRemote = false]) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final user = await _authRepository.getUserData(fromRemote);
      var oldUser = state.user;
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn,
          user: user?.copyWith(
            accessToken: oldUser?.accessToken,
            refreshToken: oldUser?.refreshToken,
            points: oldUser?.points,
          )));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<bool> editAccountData(User newUser) async {
    if (newUser.fullName == state.user?.fullName &&
        newUser.email == state.user?.email &&
        newUser.gender == state.user?.gender &&
        newUser.ageGroup == state.user?.ageGroup) return false;
    final oldUser = state.user;
    try {
      final user = await _authRepository.editAccountData(newUser.copyWith(
        id: oldUser!.id,
      ));

      emit(state.copyWith(
          status: AuthStateStatus.loggedIn,
          user: user.copyWith(
            accessToken: oldUser.accessToken,
            refreshToken: oldUser.refreshToken,
          )));
      return true;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
      return false;
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.logout();
    } catch (e) {
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
      await _authRepository.deleteAccount(message);
      emit(state.copyWith(status: AuthStateStatus.loggedIn));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> informBackendAboutLanguageChanges(String languageCode) async {
    try {
      await _authRepository.informBackendAboutLanguageChanges(languageCode);
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateUserNotificationStatus(bool isEnabled) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      await _authRepository.updateUserNotificationStatus(isEnabled);
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn,
          user: state.user?.copyWith(notificationEnabled: isEnabled)));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateUserPoints(int points) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      await _authRepository.updateUserPoints(points);
      emit(state.copyWith(
          status: AuthStateStatus.loggedIn,
          user: state.user?.copyWith(points: points)));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getInterestData() async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));

      final interests = await _authRepository.getInterestData();

      List<int?>? selectedInterests = List.filled(interests.length, null);

      for (var i = 0; i < interests.length; i++) {
        if (interests[i].selected) selectedInterests[i] = interests[i].id;
      }

      emit(state.copyWith(
          status: AuthStateStatus.interestsLoaded,
          interests: interests,
          selectedInterests: selectedInterests));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
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
      await _authRepository.resendVerificationEmail();
      onSuccess();
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refreshUser() async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));

      final emailVerified = await _authRepository.checkEmailVerified();
      emit(state.copyWith(
        status: AuthStateStatus.loggedIn,
        user: state.user!.copyWith(emailVerified: emailVerified),
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> continueAsGuest() async {
    try {
      final user = await _authRepository.loginAsGuest();
      emit(state.copyWith(status: AuthStateStatus.guest, user: user));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
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
}
