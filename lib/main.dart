import 'package:flutter/material.dart';
import 'package:mina/app/app.dart';
import 'package:mina/app/di.dart';

void main()async {
  ///not crash to app//

 WidgetsFlutterBinding.ensureInitialized();
 // await initAppModule();
 await initAppModule();
  runApp(MyApp());
}
