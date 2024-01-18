import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/features/auth/data/models/user.dart';

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
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final CacheService _cacheService;

  AuthLocalDataSourceImpl(this._cacheService);

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
    print('userString: $userString');
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
}
