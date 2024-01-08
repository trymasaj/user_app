//ignore: unused_import
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceLocalClient {
  late final SharedPreferences instance;

  SharedPreferenceLocalClient();

  Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  Future<bool> clearPreferencesData() {
    return instance.clear();
  }
}
