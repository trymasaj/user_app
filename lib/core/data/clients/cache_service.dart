import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/domain/enums/show_case_displayed_page.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/domain/entities/country.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheService {
  Future<bool> saveUserData(String userData);

  Future<String?> getUserData();

  Future<bool> saveAppleUserData(String userData);

  Future<String?> getAppleUserData();

  Future<bool?> clearUserData();

  Future<String?> getLanguageCode();

  Future<void> setLanguageCode(String languageCode);

  Future<String?> getCountryCode();

  Future<Country?> getCurrentCountry();

  Future<Address?> getCurrentAddress();

  Future<void> setCurrentAddress(Address address);

  Future<void> setCountryCode(String countryCode);

  Future<void> setCurrentCountry(Country country);

  Future<bool> getIsFirstLaunch();

  Future<void> setIsFirstLaunch(bool isFirstLaunch);

  Future<Set<ShowCaseDisplayedPage>> getShowCaseDisplayedPages();

  Future<void> addShowCaseDisplayedPages(ShowCaseDisplayedPage page);

  Future<void> resetShowCaseDisplayedPages();
  // save service model
  Future<bool> saveServiceModel(ServiceModel serviceModel);
  // get all service models
  Future<List<ServiceModel>> getAllServiceModels();
  Future<bool> removeServiceModel(ServiceModel serviceModel);
}

@LazySingleton(as: CacheService)
class CacheServiceImplV2 implements CacheService {
  static const _USERDATA = 'USER_DATA';
  static const _APPLE_USER_DATA = 'APPLE_USER_DATA';
  static const _LOCALE = 'locale';
  static const _IS_FIRST_LAUNCH = 'IS_FIRST_LAUNCH';
  static const _HAS_RUN_BEFORE = 'HAS_RUN_BEFORE';
  static const _SHOW_CASE_DISPLAYED = 'SHOW_CASE_DISPLAYED';
  static const _COUNTRY_CODE = 'COUNTRY_CODE';
  static const _COUNTRY = 'COUNTRY';
  static const _SERVICE_MODEL = 'SERVICE';
  static const _ADDRESS = 'ADDRESS';

  @override
  Future<bool> saveUserData(String userData) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_USERDATA, userData);
    return true;
  }

  @override
  Future<String?> getUserData() async {
    final pref = await SharedPreferences.getInstance();

    return pref.getString(_USERDATA);
  }

  @override
  Future<String?> getAppleUserData() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_APPLE_USER_DATA);
  }

  @override
  Future<bool> saveAppleUserData(String userData) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setString(_APPLE_USER_DATA, userData);
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
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getString(_IS_FIRST_LAUNCH);
    return isFirstLaunch == null ? true : false;
  }

  @override
  Future<void> setIsFirstLaunch(bool isFirstLaunch) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_IS_FIRST_LAUNCH, isFirstLaunch.toString());
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_USERDATA);
  }

  @override
  Future<String?> getCountryCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_COUNTRY_CODE);
  }

  @override
  Future<void> setCountryCode(String countryCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_COUNTRY_CODE, countryCode);
  }

  @override
  Future<void> setCurrentCountry(Country country) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_COUNTRY, jsonEncode(country.toMap()));
  }

  @override
  Future<Country?> getCurrentCountry() async {
    final prefs = await SharedPreferences.getInstance();
    final country = prefs.getString(_COUNTRY);
    if (country == null) return null;
    return Country.fromMap(jsonDecode(country));
  }

  @override
  Future<List<ServiceModel>> getAllServiceModels() async {
    final prefs = await SharedPreferences.getInstance();
    final serviceModels = prefs.getString(_SERVICE_MODEL);

    if (serviceModels == null) {
      return [];
    }
    final List<ServiceModel> serviceModelList = [];
    final List<dynamic> serviceModelMap = jsonDecode(serviceModels);
    for (var item in serviceModelMap) {
      serviceModelList.add(ServiceModel.fromMap(item));
    }
    return serviceModelList;
  }

  @override
  Future<bool> saveServiceModel(ServiceModel serviceModel) async {
    final prefs = await SharedPreferences.getInstance();
    final serviceModels = await getAllServiceModels();
    if (serviceModels
        .any((element) => element.serviceId == serviceModel.serviceId)) {
      serviceModels.removeWhere(
          (element) => element.serviceId == serviceModel.serviceId);
    }
    if (serviceModels.length >= 10) {
      serviceModels.removeLast();
    }
    serviceModels.add(serviceModel);
    await prefs.setString(_SERVICE_MODEL,
        jsonEncode(serviceModels.map((e) => e.toMap()).toList()));
    return true;
  }

// remove    service model
  Future<bool> removeServiceModel(ServiceModel serviceModel) async {
    final prefs = await SharedPreferences.getInstance();
    final serviceModels = await getAllServiceModels();
    if (serviceModels
        .any((element) => element.serviceId == serviceModel.serviceId)) {
      serviceModels.removeWhere(
          (element) => element.serviceId == serviceModel.serviceId);
    }

    await prefs.setString(_SERVICE_MODEL,
        jsonEncode(serviceModels.map((e) => e.toMap()).toList()));
    return true;
  }

  @override
  Future<Address?> getCurrentAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final address = prefs.getString(_ADDRESS);
    return Address.fromMap(jsonDecode(address!));
  }

  @override
  Future<void> setCurrentAddress(Address address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_ADDRESS, jsonEncode(address.toMap()));
  }
}
