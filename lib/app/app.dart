
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mina/presention/resources/routes_manager.dart';
import 'package:mina/presention/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app_preference.dart';
import 'di.dart';

class MyApp extends StatefulWidget {

  MyApp._internall();     ///named constractor
  static final MyApp _instance =MyApp._internall();  ///singelton or single instance
  factory MyApp() => _instance;   ///factory

  @override
  State<MyApp> createState() => _MyAppState();
}
final AppPreferences _appPreferences = instance<AppPreferences>();


class _MyAppState extends State<MyApp> {

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: RouteGenarator.getRoute,
      initialRoute: Routes.splashRoute,
     theme: getAppTheme(),
    );
  }
}
