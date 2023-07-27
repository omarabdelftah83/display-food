import 'package:dio/dio.dart';
import 'package:mina/app/constant.dart';
import 'package:retrofit/http.dart';

import '../response/response.dart';

part 'app_api.g.dart';



@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customer/login")
  Future< AuthenticationResponse> loginApi(
      @Field("email") String email, @Field("password") String password);
}