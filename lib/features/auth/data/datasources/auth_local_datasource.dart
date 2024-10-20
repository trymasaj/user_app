
import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';

import 'package:masaj/features/address/domain/entities/country.dart';

abstract class AuthLocalDataSource {
  Future<bool> checkUserDataExist();

  Future<bool> saveUserData(User userData);

  Future<bool> saveAppleUserData(User appleUserData);

  Future<String?> getAppleUserData();

  Future<bool?> clearUserData();

  Future<User?> getUserData();

  Future<bool> updateUserData(User user);

  Future<bool> updateUserNotification(bool isEnabled);

  Future<bool> updateUserPoints(int points);

  Future<Country?> getCurrentCountry();

  Future<void> setCurrentCountry(Country country);

  Future<Address?> getCurrentAddress();

  Future<void> setCurrentAddress(Address address);
}


class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final CacheService _cacheService;
  final AbsLogger _logger;

  AuthLocalDataSourceImpl(this._cacheService, this._logger);

  @override
  Future<bool> checkUserDataExist() async {
    final userData = await _cacheService.getUserData();
    return userData != null && userData.isNotEmpty;
  }

  @override
  Future<bool> saveUserData(User userData) {
    return _cacheService.saveUserData(userData.toJson());
  }

  @override
  Future<bool> saveAppleUserData(User appleUserData) {
    return _cacheService.saveAppleUserData(appleUserData.toJson());
  }

  @override
  Future<String?> getAppleUserData() {
    return _cacheService.getAppleUserData();
  }

  @override
  Future<bool> updateUserData(User user) async {
    //TODO: check if need to set new interests
    final userString = await _cacheService.getUserData();
    if (userString == null) return false;
    final oldUser = User.fromJson(userString);
    final newUser = oldUser.copyWith(
      fullName: user.fullName,
      email: user.email,
      gender: user.gender,
      ageGroup: user.ageGroup,
    );
    return _cacheService.saveUserData(newUser.toJson());
  }

  @override
  Future<bool> updateUserNotification(bool isEnabled) async {
    final userString = await _cacheService.getUserData();
    if (userString == null) return false;
    final oldUser = User.fromJson(userString);
    final newUser = oldUser.copyWith(notificationEnabled: isEnabled);
    return _cacheService.saveUserData(newUser.toJson());
  }

  @override
  Future<bool?> clearUserData() => _cacheService.clearUserData();

  @override
  Future<User?> getUserData() async {
    final userString = await _cacheService.getUserData();
    if (userString == null) return null;
    _logger.info('userString: $userString');
    return User.fromJson(userString);
  }

  @override
  Future<bool> updateUserPoints(int points) async {
    final userString = await _cacheService.getUserData();
    if (userString == null) return false;
    final oldUser = User.fromJson(userString);
    final newUser = oldUser.copyWith(points: points);
    return _cacheService.saveUserData(newUser.toJson());
  }

  @override
  Future<Country?> getCurrentCountry() async {
    final country = await _cacheService.getCurrentCountry();
    if (country == null) return null;
    return country;
  }

  @override
  Future<void> setCurrentCountry(Country country) async {
    await _cacheService.setCurrentCountry(country);
  }

  @override
  Future<Address?> getCurrentAddress() async {
    final address = await _cacheService.getCurrentAddress();
    if (address == null) return null;
    return address;
  }

  @override
  Future<void> setCurrentAddress(Address address) async {
    await _cacheService.setCurrentAddress(address);
    if (address.country != null) {
      await _cacheService.setCurrentCountry(address.country!);
    }
  }
}
