import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mina/presention/main/home_page/view/home_page.dart';
import 'package:mina/presention/main/pages/notification_page.dart';
import 'package:mina/presention/main/pages/search_page.dart';
import 'package:mina/presention/main/pages/sitting_page.dart';
import 'package:mina/presention/resources/string_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SittingPage(),
  ];
  List<String> title = [
    AppString.home.tr(),
    AppString.search.tr(),
    AppString.notifications.tr(),
    AppString.settings.tr(),


  ];

  /// title change to scroll view///
 var  _title = AppString.home.tr();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black, spreadRadius: 1.5)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap:onTap,
          items:  [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: AppString.home.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppString.search.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppString.notifications.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppString.settings.tr()),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;//change page
      _title = title[index]; //change title
    });
  }
}
