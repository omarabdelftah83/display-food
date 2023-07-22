import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mina/presention/onBoarding/on_pearding_page_body.dart';
import 'package:mina/presention/resources/image_path.dart';
import 'package:mina/presention/resources/routes_manager.dart';
import 'package:mina/presention/resources/string_manager.dart';
import 'package:mina/presention/resources/valuies_manager.dart';
import 'package:mina/presention/widget/slider_obj.dart';

class onBoardingView extends StatefulWidget {
  const onBoardingView({super.key});

  @override
  State<onBoardingView> createState() => _onBoardingViewState();
}

List<SliderObj> _getSliderObj() =>
    [
      SliderObj(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1,
          ImagePath.onBoardingLogo1),
      SliderObj(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2,
          ImagePath.onBoardingLogo1),
      SliderObj(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3,
          ImagePath.onBoardingLogo1),
      SliderObj(AppString.onBoardingTitle4, AppString.onBoardingSubTitle4,
          ImagePath.onBoardingLogo1),
    ];
late final List<SliderObj> _list = _getSliderObj();

int _currentIndex = 0;



class _onBoardingViewState extends State<onBoardingView> {
  late  PageController _pageController ;
  @override
  void initState() {
    // TODO: implement initState
    _pageController=PageController(initialPage: 0);
  }
  @override
  void dispose() {
   _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///body///
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
             controller: _pageController,
               itemCount: _list.length,
              itemBuilder: (context, index) {
                return OnBeardingPageBody(_list[index]);
              },
            ),
          ),

        ],
      ),


      ///bottom sheet///
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.orangeAccent,
          height: AppSize.s80,
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: const Text(
                    AppString.skip,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),

               Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                4,
                    (index) => Container(
                    width: 7,
                    height: 7,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 0
                            ? Colors.greenAccent
                            : index == 1
                            ? Colors.white
                            : Colors.pink))),
          )
            ],
          ),

        ),
      ),
    );
  }
}
















//
// Widget _getBottomSheet() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       IconButton(onPressed: () {
//         _pageController.animateToPage(
//             _getPreviesIndex(), duration: Duration(milliseconds: 100),
//             curve: Curves.bounceInOut);
//       }, icon: Icon(Icons.arrow_back_ios_new)),
//
//       ///three point///
//       Row(children: [
//         for (int i = 0; i < _list.length; i++)
//           Padding(padding: const EdgeInsets.all(10),
//             child: _getProperCircle(i),
//           ),
//
//       ],),
//
//
//       IconButton(onPressed: () {
//         _pageController.animateToPage(
//             _getNextIndex(), duration: Duration(milliseconds: 100),
//             curve: Curves.bounceInOut);
//       }, icon: Icon(Icons.arrow_forward_ios))
//     ],);
// }
//
//
// _getProperCircle(int index) {
//   if (index == _currentIndex) {
//     return SvgPicture.asset('assets/images/Small-dark-grey-circle.svg.png');
//   } else {
//     return SvgPicture.asset('assets/images/Circle_Davys-Grey_Solid.svg.png');
//   }
// }
//
//   _getPreviesIndex(){
// int  priviesIndex=_currentIndex --;
// if(priviesIndex == -1){
//   priviesIndex=_list.length-1;
// }
// return priviesIndex;
// }
//
//
// _getNextIndex(){
//   int  nextIndex=_currentIndex ++;
//   if(nextIndex == _list.length){
//     nextIndex=0;
//   }
//   return nextIndex;
// }
//



///appbar///
// appBar: AppBar(
//   backgroundColor: Colors.white,
//   systemOverlayStyle: const SystemUiOverlayStyle(
//       statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
// ),



































///three point ///
//  Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(
//               3,
//                   (index) => Container(
//                   width: 7,
//                   height: 7,
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       color: index == 0
//                           ? Colors.greenAccent
//                           : index == 1
//                           ? Colors.white
//                           : Colors.pink))),
//         )