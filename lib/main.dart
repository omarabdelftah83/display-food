import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mina/app/app.dart';
import 'package:mina/app/di.dart';
import 'package:mina/presention/resources/language_manager.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await EasyLocalization.ensureInitialized();
 await initAppModule();
 runApp(MyApp());
 runApp(EasyLocalization(
     child: Phoenix(child: MyApp()),
     supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
     path: ASSET_PATH_LOCALISATIONS));
}