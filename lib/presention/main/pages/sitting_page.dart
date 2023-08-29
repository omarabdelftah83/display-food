import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../app/app_preference.dart';
import '../../../app/di.dart';
import '../../../data/datasourse/local_data_sourse.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';

class SittingPage extends StatefulWidget {
  const SittingPage({super.key});

  @override
  State<SittingPage> createState() => _SittingPageState();
}

class _SittingPageState extends State<SittingPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text(AppString.changeLanguage,
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Icon(Icons.chevron_right_outlined),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text(AppString.contactUs,
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Icon(Icons.chevron_right_outlined),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(AppString.inviteYourFriends,
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Icon(Icons.chevron_right_outlined),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(AppString.logout,
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Icon(Icons.chevron_right_outlined),
            onTap: () {
              _logout();
            },
          )
        ],
      ),
    );
  }

  _changeLanguage() {
    // i will implement it later
    _appPreferences.changeAppLanguage();
    //restart app//
    Phoenix.rebirth(context);
  }

  _contactUs() {
    // its a task for you to open any webpage using URL
  }

  _inviteFriends() {
    // its a task for you to share app name to friends
  }

  _logout() {
    // app prefs make that user logged out
    _appPreferences.logout();

    // clear cache of logged out user
    _localDataSource.clearCache();

    // navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
