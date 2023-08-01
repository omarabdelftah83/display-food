import 'package:internet_connection_checker/internet_connection_checker.dart';
///check if in it internet///
abstract class NetWorkInf{
  Future<bool> get isConnected;
}
class NetWorkInfImp extends NetWorkInf{

final  InternetConnectionChecker _internetConnectionChecker;

  NetWorkInfImp(this._internetConnectionChecker);
  @override
  // TODO: implement isConnected

  Future<bool> get  isConnected => _internetConnectionChecker.hasConnection;///if connected connection api///
}