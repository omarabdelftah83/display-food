import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mina/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_preference.dart';

///1 I want to come back instance in Dio///
///2  must add option //
///logger interceptor => watch in input & output in response
///use shared pref//
const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "langauge";

//sec 60//
class DioFactory {
  ///come back share pref//
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  ///duration//
  Duration duration =
      const Duration(milliseconds: Constant.duration); // a min time out

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String lang = await _appPreferences.getAppLanguage();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "SEND TOKEN HERE",
      DEFAULT_LANGUAGE: lang, // todo get lang from app prefs
    };

    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        headers: headers,
        receiveTimeout: duration,
        sendTimeout: duration);

    ///sec 61//
    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
