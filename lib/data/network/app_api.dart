import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mina/app/constant.dart';
import 'package:mina/data/network/dio_factory.dart';
import 'package:retrofit/http.dart';

import '../response/response.dart';

part 'app_api.g.dart';



@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
///I want to come back instance in dio///
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future< AuthenticationResponse> loginApi(
      @Field("email") String email, @Field("password") String password);
}