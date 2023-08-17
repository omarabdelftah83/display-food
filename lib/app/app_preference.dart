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
}
