
////$$$$$///
import 'package:dartz/dartz.dart';
import 'package:mina/data/datasourse/remote_data_sourse.dart';
import 'package:mina/data/mapper/mapper.dart';
import 'package:mina/data/network/falier.dart';
import 'package:mina/data/network/requests.dart';
import 'package:mina/domain/entitiy/entity.dart';
import 'package:mina/domain/repository/repository.dart';

import '../network/network_info.dart';

class Repository implements BaseRepository {
  final RemoteDataSource _remoteDataSource;
  final NetWorkInf _netWorkInf;

  Repository(this._remoteDataSource, this._netWorkInf);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest)async {

  if(await _netWorkInf.isConnected){
   final response= await _remoteDataSource.loginDataSource(loginRequest);

   if(response.status==0){
     ///success///return data
   return  right(response.toDomain());
   }else{
     ////error///return error
     return left(Failure(409, response.message??'error'));
   }

  }
  else{
 return left(Failure(501, 'please check your internet'));
  }
  }
}
