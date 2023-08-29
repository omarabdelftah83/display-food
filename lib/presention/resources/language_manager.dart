
import 'package:flutter/material.dart';

/// very important///
enum LanguageType{
  ARABIC,
  ENGLISH,
}
const String ASSET_PATH_LOCALISATIONS = "assets/translation";
const Locale ARABIC_LOCAL = Locale("ar", "SA");
const Locale ENGLISH_LOCAL = Locale("en", "US");


const String ARABIC='ar';
const String ENGLISH='en';
extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.ARABIC:
       return ARABIC;
      case LanguageType.ENGLISH:
       return ENGLISH;
    }
  }
}