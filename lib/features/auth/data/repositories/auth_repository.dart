import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/data/device/notification_service.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';

import 'package:masaj/core/data/datasources/device_type_data_source.dart';
import 'package:masaj/core/data/datasources/external_login_data_source.dart';
import 'package:masaj/core/data/models/interest_model.dart';
import 'package:masaj/features/account/data/models/contact_us_message_model.dart';
import 'package:masaj/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:masaj/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<bool> isLoggedIn();

  Future<User> login(
    String phoneNumber,
    String countryCode,
    String password,
  );

  Future<User> loginWithGoogle(Future<String?> Function() onEmailRequiredError);

  Future<User> loginWithApple(Future<String?> Function() onEmailRequiredError);

  Future<User> signUp(User params);
  Future<User> updateProfileInformation(User user);

  Future<void> forgetPassword(String email);

  Future<void> logout();

  Future<User?> getUserData([bool fromRemote = false]);

  Future<void> changePassword(String oldPassword, String newPassword);

  Future<User> editAccountData(User newUser);

  Future<void> deleteAccount(ContactUsMessage message);

  Future<void> updateUserNotificationStatus(bool isEnabled);

  Future<void> updateUserPoints(int points);

  Future<void> informBackendAboutLanguageChanges(String languageCode);

  Future<List<InterestModel>> getInterestData();

  Future<void> editUserInterests(List<int> selectedInterests);

  Future<void> resendVerificationEmail();

  Future<bool> checkEmailVerified();

  Future<User> loginAsGuest();
  Future<User?> verifyOtp(User user, String otp, {bool afterLogin = false});
  Future<User?> updateUser(User user);
  Future<void> resendOtp(User user);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NotificationService _notificationService;
  final DeviceTypeDataSource _deviceTypeDataSource;
  final ExternalLoginDataSource _appleExternalDataSource;
  final ExternalLoginDataSource _googleExternalDataSource;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._deviceTypeDataSource,
    this._notificationService,
    this._appleExternalDataSource,
    this._googleExternalDataSource,
  );

  @override
  Future<bool> isLoggedIn() {
    return _localDataSource.checkUserDataExist();
  }

  @override
  Future<User> signUp(User user) async {
    final mobileAppId = await _notificationService.getDeviceTokenId();
    final deviceType = _deviceTypeDataSource.getDeviceType();

    final resultUser = await _remoteDataSource.signUp(user.copyWith(
      mobileAppId: mobileAppId,
      deviceType: deviceType,
    ));
    //Todo: delete this after testing
    // await _localDataSource.saveUserData(resultUser);
    return resultUser;
  }

  @override
  Future<User> login(
    String phoneNumber,
    String countryCode,
    String password,
  ) async {
    final deviceType = _deviceTypeDataSource.getDeviceType();
    final mobileAppId = await _notificationService.getDeviceTokenId();
    final resultUser = await _remoteDataSource.login(
      phoneNumber,
      countryCode,
      password,
      mobileAppId,
      deviceType,
    );
    await _localDataSource.saveUserData(resultUser);
    return resultUser;
  }

  @override
  Future<User> loginWithApple(
    Future<String?> Function() onEmailRequiredError,
  ) async {
    late User newAppleUser;
    try {
      final country = await _localDataSource.getCountry();
      final countryId = country?.id;
      final appleUser = await _appleExternalDataSource.login();
      final savedAppleUserData = await _localDataSource.getAppleUserData();

      newAppleUser = (savedAppleUserData == null ||
              User.fromJson(savedAppleUserData).fullName == null)
          ? appleUser
          : User.fromJson(savedAppleUserData)
              .copyWith(idToken: appleUser.idToken);
      await _localDataSource.saveAppleUserData(newAppleUser);
      final user = await _externalLogin(newAppleUser.copyWith(
        countryId: countryId ?? 0,
      ));
      return user;
    } on RequestException catch (e) {
      if (e.message.contains('Email Required')) {
        final email = await onEmailRequiredError();
        if (email == null) rethrow;
        final user = await _externalLogin(newAppleUser.copyWith(email: email));
        return user;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<User> loginWithGoogle(
      Future<String?> Function() onEmailRequiredError) async {
    late User externalUser;
    try {
      final country = await _localDataSource.getCountry();
      final countryID = country?.id;
      externalUser = await _googleExternalDataSource.login();
      final user = await _externalLogin(
          externalUser.copyWith(countryId: countryID ?? 0));
      return user;
    } on RequestException catch (e) {
      if (e.message.contains('Email Required')) {
        final email = await onEmailRequiredError();
        if (email == null) rethrow;
        final user = await _externalLogin(externalUser.copyWith(email: email));
        return user;
      } else {
        rethrow;
      }
    }
  }

  Future<User> _externalLogin(User externalUser) async {
    final mobileAppId = await _notificationService.getDeviceTokenId();
    final deviceType = _deviceTypeDataSource.getDeviceType();
    final resultUser =
        await _remoteDataSource.externalLogin(externalUser.copyWith(
      mobileAppId: mobileAppId,
      deviceType: deviceType,
    ));
    await _localDataSource.saveUserData(resultUser);
    return resultUser;
  }

  @override
  Future<void> forgetPassword(String email) {
    return _remoteDataSource.forgetPassword(email);
  }

  @override
  Future<void> logout() async {
    final currentUser = await _localDataSource.getUserData();
    final userId = currentUser?.id;
    await Future.wait([
//TODO: uncomment this
      // if (userId != null) _remoteDataSource.logout(userId),
      _localDataSource.clearUserData(),
      _notificationService.cancelAll(),
    ]);
  }

  @override
  Future<User?> getUserData([bool fromRemote = false]) => fromRemote
      ? _remoteDataSource.getUserData()
      : _localDataSource.getUserData();

  @override
  Future<void> changePassword(String oldPassword, String newPassword) {
    return _remoteDataSource.changePassword(oldPassword, newPassword);
  }

  @override
  Future<User> editAccountData(User newUser) async {
    final user = await _remoteDataSource.editAccountData(newUser);

    await _localDataSource.updateUserData(user);
    return user;
  }

  @override
  Future<void> deleteAccount(ContactUsMessage message) =>
      _remoteDataSource.deleteAccount(message);

  @override
  Future<void> informBackendAboutLanguageChanges(String languageCode) =>
      _remoteDataSource.informBackendAboutLanguageChanges(languageCode);

  @override
  Future<List<InterestModel>> getInterestData() =>
      _remoteDataSource.getInterestData();

  @override
  Future<void> editUserInterests(List<int> selectedInterests) async {
    await _remoteDataSource.editUserInterests(selectedInterests);
    final user = await _localDataSource.getUserData();
    await _localDataSource.saveUserData(
        user!.copyWith(interestsSelected: selectedInterests.isNotEmpty));
  }

  @override
  Future<bool> checkEmailVerified() async {
    final emailVerified = await _remoteDataSource.checkEmailVerified();
    if (!emailVerified) return false;
    final user = await _localDataSource.getUserData();

    await _localDataSource.saveUserData(user!.copyWith(emailVerified: true));
    return true;
  }

  @override
  Future<void> resendVerificationEmail() =>
      _remoteDataSource.resendVerificationEmail();

  @override
  Future<User> loginAsGuest() async {
    await logout();
    final guestUser = User();
    await _localDataSource.saveUserData(guestUser);
    return guestUser;
  }

  @override
  Future<void> updateUserNotificationStatus(bool isEnabled) async {
    await _remoteDataSource.updateUserNotificationStatus(isEnabled);
    await _localDataSource.updateUserNotification(isEnabled);
  }

  @override
  Future<void> updateUserPoints(int points) async {
    await _localDataSource.updateUserPoints(points);
  }

  @override
  Future<User?> verifyOtp(User user, String otp,
      {bool afterLogin = false}) async {
    //  by remote
    final verifiedUser = await _remoteDataSource.verifyOtp(user, otp);
    if (verifiedUser != null && afterLogin) {
      await _localDataSource.saveUserData(verifiedUser);
    }
    return verifiedUser;
  }

  @override
  Future<User?> updateUser(User user) async {
    await _localDataSource.saveUserData(user);
    return await _localDataSource.getUserData();
  }

  @override
  Future<void> resendOtp(User user) async {
    await _remoteDataSource.resendOtp(user);
  }

  @override
  Future<User> updateProfileInformation(User user) {
    return _remoteDataSource.updateProfileInformation(user);
  }
}
