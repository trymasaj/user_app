import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/domain/enums/show_case_displayed_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

abstract class CacheService {
  Future<bool> saveUserData(String userData);
  Future<String?> getUserData();

  Future<bool> saveAppleUserData(String userData);
  Future<String?> getAppleUserData();

  Future<bool?> clearUserData();

  Future<String?> getLanguageCode();
  Future<void> setLanguageCode(String languageCode);

  Future<bool> getIsFirstLaunch();
  Future<void> setIsFirstLaunch(bool isFirstLaunch);

  Future<bool> getIsQuizCompleted();
  Future<bool> setIsQuizCompleted(bool isQuizCompleted);

  Future<Set<ShowCaseDisplayedPage>> getShowCaseDisplayedPages();
  Future<void> addShowCaseDisplayedPages(ShowCaseDisplayedPage page);
  Future<void> resetShowCaseDisplayedPages();
}

@LazySingleton(as: CacheService)
class CacheServiceImplV2 implements CacheService {
  static const _USERDATA = 'USER_DATA';
  static const _APPLE_USER_DATA = 'APPLE_USER_DATA';
  static const _LOCALE = 'locale';
  static const _IS_FIRST_LAUNCH = 'IS_FIRST_LAUNCH';
  static const _IS_QUIZ_COMPLETED = 'IS_QUIZ_COMPLETED';
  static const _HAS_RUN_BEFORE = 'HAS_RUN_BEFORE';
  static const _SHOW_CASE_DISPLAYED = 'SHOW_CASE_DISPLAYED';

  final _completer = Completer<FlutterSecureStorage>();

  CacheServiceImplV2() {
    SharedPreferences.getInstance().then((prefs) async {
      if (prefs.getBool(_HAS_RUN_BEFORE) != true) {
        const storage = FlutterSecureStorage();
        await storage.deleteAll();
        await prefs.setBool(_HAS_RUN_BEFORE, true);
        _completer.complete(storage);
      } else {
        _completer.complete(const FlutterSecureStorage());
      }
    });
  }

  @override
  Future<bool> saveUserData(String userData) async {
    final storage = await _completer.future;
    await storage.write(key: _USERDATA, value: userData);
    return true;
  }

  @override
  Future<String?> getUserData() async {
    final storage = await _completer.future;

    return await storage.read(key: _USERDATA);
  }

  @override
  Future<String?> getAppleUserData() async {
    final storage = await _completer.future;
    return await storage.read(key: _APPLE_USER_DATA);
  }

  @override
  Future<bool> saveAppleUserData(String userData) async {
    final storage = await _completer.future;
    await storage.write(key: _APPLE_USER_DATA, value: userData);
    return true;
  }

  @override
  Future<String?> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LOCALE);
  }

  @override
  Future<void> setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_LOCALE, languageCode);
  }

  @override
  Future<bool> getIsFirstLaunch() async {
    final storage = await _completer.future;

    final isFirstLaunch = await storage.read(key: _IS_FIRST_LAUNCH);
    return isFirstLaunch == null ? true : false;
  }

  @override
  Future<void> setIsFirstLaunch(bool isFirstLaunch) async {
    final storage = await _completer.future;

    await storage.write(key: _IS_FIRST_LAUNCH, value: isFirstLaunch.toString());
  }

  @override
  Future<bool> getIsQuizCompleted() async {
    final storage = await _completer.future;

    final isQuizCompleted = await storage.read(key: _IS_QUIZ_COMPLETED);
    return isQuizCompleted == null ? false : true;
  }

  @override
  Future<bool> setIsQuizCompleted(bool isQuizCompleted) async {
    final storage = await _completer.future;

    await storage.write(
        key: _IS_QUIZ_COMPLETED, value: isQuizCompleted.toString());
    return true;
  }

  @override
  Future<void> addShowCaseDisplayedPages(ShowCaseDisplayedPage page) async {
    final prefs = await SharedPreferences.getInstance();
    final pagesSet = prefs.getStringList(_SHOW_CASE_DISPLAYED)?.toSet() ?? {};
    pagesSet.add(page.name);
    await prefs.setStringList(_SHOW_CASE_DISPLAYED, pagesSet.toList());
  }

  @override
  Future<Set<ShowCaseDisplayedPage>> getShowCaseDisplayedPages() async {
    final prefs = await SharedPreferences.getInstance();
    final pagesSet = prefs.getStringList(_SHOW_CASE_DISPLAYED)?.toSet() ?? {};
    return pagesSet
        .map((e) => ShowCaseDisplayedPage.values
            .firstWhereOrNull((element) => element.name == e))
        .whereNotNull()
        .toSet();
  }

  @override
  Future<void> resetShowCaseDisplayedPages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_SHOW_CASE_DISPLAYED);
  }

  @override
  Future<bool?> clearUserData() async {
    final storage = await _completer.future;

    await storage.delete(key: _USERDATA);
    return true;
  }
}