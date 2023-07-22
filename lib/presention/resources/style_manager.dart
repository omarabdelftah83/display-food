import 'dart:ui';

import 'package:mina/presention/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: FontConstance.fontFamily);
}
//regular style//
TextStyle getRegularStyle({
  double fontSize = FontSize.s16,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}
//medium style//
TextStyle mediumStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}
//light style//
TextStyle lightStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}
//semiBold style//
TextStyle semiBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
//bold style//
TextStyle boldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}