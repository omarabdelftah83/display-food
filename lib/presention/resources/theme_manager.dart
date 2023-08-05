import 'package:flutter/material.dart';
import 'package:mina/presention/resources/color_manager.dart';
import 'package:mina/presention/resources/font_manager.dart';
import 'package:mina/presention/resources/style_manager.dart';
import 'package:mina/presention/resources/valuies_manager.dart';


ThemeData getAppTheme() {
  return ThemeData(
      //main color//
      primaryColor: ColorManager.primarycolor,

      //card//
      cardTheme: const CardTheme(
        color: Colors.white,
        shadowColor: Colors.grey,
        elevation: 4,
      ),

      //appBar//
      // appBarTheme: AppBarTheme(
      //   centerTitle: true,
      //   color: Colors.white,
      //   elevation: 4,
      //   //titleTextStyle: getRegularStyle(color: Colors.white,fontSize: FontSize()
      // ),

      //Elevated Button//
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12)),
          textStyle: const TextStyle(fontSize: FontSize.s17, color: Colors.white),
          primary: Colors.orange,
        ),
      ),

      ///textTheme//
      textTheme:const TextTheme(
        headlineLarge: TextStyle(color: Colors.grey, fontSize: FontSize.s16),
        subtitle1: TextStyle(color: Colors.grey, fontSize: FontSize.s14),
        caption: TextStyle(color: Colors.grey, fontSize: FontSize.s16),
        bodyText1: TextStyle(color: Colors.grey, fontSize: FontSize.s16),
      ),
      ///input decoration theme//
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppPadding.p8),
        labelStyle: TextStyle(color: Colors.grey, fontSize: FontSize.s14),
        hintStyle: TextStyle(color: Colors.blue, fontSize: FontSize.s14),
        errorStyle: TextStyle(
          color: Colors.red,
        ),



        ///enabledBorder///
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),


        ///focusedBorder//
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),


       ///errorBorder///
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),


        ///focusedErrorBorder///out
        focusedErrorBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ));
}
