import 'package:mina/presention/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String PREF_KEY_LANG ='PREF_KEY_LANG';



class AppPreferences{

final  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String>getAppLanguage()async{

  String? language =  _sharedPreferences.getString(PREF_KEY_LANG);
        if(  language !=null && language.isNotEmpty){
          return language;
        }else{
          return LanguageType.ENGLISH.getValue();
        }
  }
}