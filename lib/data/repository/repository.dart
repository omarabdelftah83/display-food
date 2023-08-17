////$$$$$///
import 'package:dartz/dartz.dart';
import 'package:mina/data/datasourse/remote_data_sourse.dart';
import 'package:mina/data/mapper/mapper.dart';
import 'package:mina/data/network/error_handle.dart';
import 'package:mina/data/network/falier.dart';
import 'package:mina/data/network/requests.dart';
import 'package:mina/domain/entitiy/entity.dart';
import 'package:mina/domain/repository/repository.dart';

import '../network/network_info.dart';

class RepositoryImp implements BaseRepository {
  final RemoteDataSource _remoteDataSource;
  final NetWorkInf _netWorkInf;

  RepositoryImp(this._remoteDataSource, this._netWorkInf);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {


    if (await _netWorkInf.isConnected) {
      try {
        ///add (try & catch) after handle code///
        /// for him try & catch because Dio use //
        print('========================hhhh=====');

        final response = await _remoteDataSource.loginDataSource(loginRequest);
        print('$response================rrrrrrrrrr');

        if (response.status == ApiInternal.SUCCESS) {
          ///success///return data

          return right(response.toDomain());
        } else {
          ////error///return error//
          return left(Failure(ApiInternal.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }

      } catch (error) {
        ///handle code//return error
        return left(ErrorHandle.handle(error).failure);
      }



    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
