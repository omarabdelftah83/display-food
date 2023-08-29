import 'package:flutter/material.dart';
import 'package:mina/presention/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_LANG = 'PREF_KEY_LANG';

const String PREF_KEY_ONBOARDING_SCREEN = 'PREF_KEY_ONBOARDING_SCREEN';
const String PREF_KEY_IS_USER_LOGIN = 'PREF_KEY_IS_USER_LOGIN';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREF_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }


  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.ARABIC.getValue()) {
      // set english
      _sharedPreferences.setString(
          PREF_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      // set arabic
      _sharedPreferences.setString(
          PREF_KEY_LANG, LanguageType.ARABIC.getValue());
    }
  }
/// com back lang//
  Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.ARABIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }
  ///onBoarding Screen
  Future<void> setOnBoardingScreenView() async {
    _sharedPreferences.setBool(PREF_KEY_ONBOARDING_SCREEN, true);
  }

  Future<bool> isBoardingScreenView() async {
    return _sharedPreferences.getBool(PREF_KEY_ONBOARDING_SCREEN) ?? false;
  }

  ///login Screen
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREF_KEY_IS_USER_LOGIN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREF_KEY_IS_USER_LOGIN) ?? false;
  }
  //log out //
  Future<void> logout() async {
    _sharedPreferences.remove(PREF_KEY_IS_USER_LOGIN);
  }



}
