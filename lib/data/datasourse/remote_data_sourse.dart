////$$$$///
import 'dart:developer';

import '../network/app_api.dart';
import '../network/requests.dart';
import '../response/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> loginDataSource(LoginRequest loginRequest);

  Future<AuthenticationResponse> registerDataSource(
      RegisterRequest registerRequest);

  Future<HomeResponse> getHomeData();

  Future<StoreDetailsResponse> getStoreDetails();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> loginDataSource(
      LoginRequest loginRequest) async {
    return await _appServiceClient.loginApi(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<AuthenticationResponse> registerDataSource(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.registerApi(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        '');
  }
///home ...//
  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }
  ///details ....//
  @override
  Future<StoreDetailsResponse> getStoreDetails() async{
   return await _appServiceClient.getStoreDetails();
  }


}
