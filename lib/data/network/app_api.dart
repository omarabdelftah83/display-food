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
///login///
  @POST("/customers/login")
  Future< AuthenticationResponse> loginApi(
      @Field("email") String email, @Field("password") String password);
///register///
  @POST("/customers/register")
  Future< AuthenticationResponse> registerApi(
      @Field("user_name") String userName,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile_picture") String profilePicture);

  @GET("/home")
  Future< HomeResponse> getHomeData();

  @GET("/storeDetails/1")
  Future<StoreDetailsResponse> getStoreDetails();
}
