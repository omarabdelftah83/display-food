
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    print('objec==================t');
    return const Scaffold(
      body: Center(child: Text(' omar mohamed '),),
    );
  }
}
