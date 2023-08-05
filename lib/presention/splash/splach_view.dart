import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mina/presention/resources/font_manager.dart';
import 'package:mina/presention/resources/image_path.dart';
import 'package:mina/presention/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  ///animation//timer///
  late AnimationController animationController;
  late Animation<Offset> animation;
  Timer? _timer;

  ///Timer///
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    });
  }
///animation function//
  void initAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }




  ///initState//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
    initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.orangeAccent.withOpacity(0.9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///image///
          const Image(image: AssetImage(ImagePath.splashLogo)),

          SizedBox(
            height: screenHight * 0.05,
          ),

          ///animation text///
          AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              return SlideTransition(
                  position: animation,
                  child: const Center(
                      child: Text(
                    'Welcome',
                    style:
                        TextStyle(fontSize: FontSize.s30, color: Colors.white),
                  )));
            },
          ),
        ],
      ),
    );
  }


  ///dispose///
  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    animationController.dispose();
    super.dispose();
  }





}



































///void navigateToHome()___ or____ Timer///
//
// void navigateToHome() {
//   Future.delayed(Duration(seconds: 2), () {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => HomeView(),
//         ));
//   });
// }
