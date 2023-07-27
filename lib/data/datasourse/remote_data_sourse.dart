
////$$$$///
import '../network/app_api.dart';
import '../network/requests.dart';
import '../response/response.dart';

abstract class RemoteDataSource{

  Future<AuthenticationResponse>loginDataSource(LoginRequest loginRequest);

}


class RemoteDataSourceImpl extends RemoteDataSource{

  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> loginDataSource(LoginRequest loginRequest) async{

 return await _appServiceClient.loginApi(loginRequest.email, loginRequest.password);
  }
}