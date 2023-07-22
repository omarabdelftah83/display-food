
import 'package:flutter/material.dart';
import 'package:mina/presention/onBoarding/onboarding_view.dart';
import 'package:mina/presention/resources/valuies_manager.dart';
import 'package:mina/presention/widget/slider_obj.dart';

class OnBeardingPageBody extends StatelessWidget {
  final SliderObj _sliderObj;

  const OnBeardingPageBody(this._sliderObj, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: AppSize.s250,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              _sliderObj.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              _sliderObj.subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,


            ),
          ),
          const SizedBox(
            height: AppSize.s40,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image(image: AssetImage(_sliderObj.image)),
          ),
        ],
      ),
    );
  }
}

