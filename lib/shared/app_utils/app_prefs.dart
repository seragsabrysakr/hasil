import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_theme.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_strings.dart';

@injectable
class AppPreferences {
  static const String _isDarkMode = 'isDarkMode';
  static const String lang = 'lang';
  static const String introShow = 'introShow';
  static const String isLogin = 'isLogin';
  static const String userData = 'userData';
  static const String userToken = 'IdToken';
  static const String os = 'operatingSystem';
  static const String deviceId = 'deviceId';
  static const String privacy = 'privacy-polices';
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<bool> _putData(String key, dynamic value) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    return await _sharedPreferences.setBool(key, value);
  }

  dynamic getData(String key, dynamic def) {
    var value = _sharedPreferences.get(key);
    return value ?? def;
  }

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  set token(String token) {
    _putData(userToken, token);
  }

  String get token => getData(userToken, '');

  String getLanguage() {
    return getData(lang, AppStrings.defaultLanguage);
  }

  bool get isIntroShow => getData(introShow, true);

  set isIntroShow(bool value) {
    _putData(introShow, value);
  }

  setLanguage(String language) {
    _putData(lang, language);
  }

  ThemeData? getTheme() {
    final bool isDark = getData(_isDarkMode, false);
    ThemeData? theme;
    if (isDark) {
      theme = appThemeData[AppTheme.darkAppTheme];
    } else {
      theme = appThemeData[AppTheme.lightAppTheme];
    }
    return theme;
  }

  setTheme(bool isDark) {
    _putData(_isDarkMode, isDark);
  }
}
