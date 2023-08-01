

import 'dart:async';

import 'package:mina/presention/base/base_view_Model.dart';

import '../../../domain/entitiy/entity.dart';
import '../../resources/image_path.dart';
import '../../resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModelOutput {

  final StreamController _streamController = StreamController<SliderViewObj>();
 late SliderObj sliderObj;
  late final List<SliderObj> _list;
  //int _currentIndex = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
  }

  @override
  void start() {
    ///sent data
    _list = _getSliderObj();///start load data to _list
    _postDataToView();
  }

  @override
  // void onPageChanged(int index) {
  //   _currentIndex = index;
  //   _postDataToView();
  // }

  ///onBoarding view Model input
  @override
  // TODO: implement onSliderViewModel
  Sink get inputSliderViewModel => _streamController.sink;




  ///onBoarding view Model output
  @override
  Stream<SliderViewObj> get outputSliderViewModel =>

      throw _streamController.stream.map((sliderViewObj) => sliderViewObj);

      void _postDataToView(){
           inputSliderViewModel.add(SliderViewObj(SliderObj() ,_list.length));
  }

  List<SliderObj> _getSliderObj() => [
        SliderObj(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1,
            ImagePath.onBoardingLogo1),
        SliderObj(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2,
            ImagePath.onBoardingLogo1),
        SliderObj(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3,
            ImagePath.onBoardingLogo1),
        SliderObj(AppString.onBoardingTitle4, AppString.onBoardingSubTitle4,
            ImagePath.onBoardingLogo1),
      ];
}






abstract class OnBoardingViewModelInput {
  ///use his way sink
  Sink get inputSliderViewModel;
}

abstract class OnBoardingViewModelOutput {
  ///use his way Stream controller outputs///
  Stream<SliderViewObj> get outputSliderViewModel;
}
