import 'package:flutter/material.dart';
import 'package:mina/app/app.dart';
import 'package:mina/app/di.dart';

void main()async {
  ///not crash to app//
  //WidgetsFlutterBinding.ensureInitialized();
 // await initAppModule();
  runApp(MyApp());
}
///    <uses-permission android:name="android.permission.INTERNET"/>
///                android:usesCleartextTraffic="true"
///                <key>NSAppTransportSecurity</key>
//     <dict>
//         <key>NSAllowsArbitraryLoads</key>
//         <true/>
//     </dict>