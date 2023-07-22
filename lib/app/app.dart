
import 'package:flutter/material.dart';
import 'package:mina/presention/resources/routes_manager.dart';
import 'package:mina/presention/resources/theme_manager.dart';

class MyApp extends StatefulWidget {

  MyApp._internall();     ///named constractor
  static final MyApp _instance =MyApp._internall();  ///singelton or single instance
  factory MyApp() => _instance;   ///factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      onGenerateRoute: RouteGenarator.getRoute,
      initialRoute: Routes.splashRoute,
     theme: getAppTheme(),
    );
  }
}
