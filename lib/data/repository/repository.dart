////$$$$$///
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mina/data/datasourse/local_data_sourse.dart';
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
  final LocalDataSource _localDataSource;

  final NetWorkInf _netWorkInf;

  RepositoryImp(
      this._remoteDataSource, this._netWorkInf, this._localDataSource);

  ///login//
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _netWorkInf.isConnected) {
      try {
        ///add (try & catch) after handle code///
        /// for him try & catch because Dio use //

        final response = await _remoteDataSource.loginDataSource(loginRequest);

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

  ///register///
  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    log("=====================basuony=1=========");
    if (await _netWorkInf.isConnected) {
      try {
        ///add (try & catch) after handle code///
        /// for him try & catch because Dio use //

        final response =
            await _remoteDataSource.registerDataSource(registerRequest);

        if (response.status == ApiInternal.SUCCESS) {
          ///success///return data
          ///toDomain ==> convert  AuthenticationResponse to Authentication///
          return right(response.toDomain());
        } else {
          ////error///return error//
          return left(Failure(ApiInternal.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error, st) {
        ///handle code//return error
        print('=====$error==$st=omarrr=');
        return left(ErrorHandle.handle(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  /// home data .......///
  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      //get response from cache
      final response = await _localDataSource.getHomeData(); //
      log("===============getHome_localDataSource===========");
      return right(response.toDomain()); //
    } catch (cacheError) {
      log("===============getHomeDatacacheError===========");
      if (await _netWorkInf.isConnected) {
        try {
          ///add (try & catch) after handle code///
          /// for him try & catch because Dio use //
          final response = await _remoteDataSource.getHomeData();

          if (response.status == ApiInternal.SUCCESS) {
            ///success///return data
            ///save home response in cache
            _localDataSource.saveHomeToCache(response); //
            log("=============response.toDomain().toString()==${response.toDomain().toString()}");
            return right(response.toDomain());
          } else {
            return left(Failure(ApiInternal.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error, st) {
          ///handle code//return error
          return left(ErrorHandle.handle(error).failure);
        }
      } else {
        return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
///details .....//
  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails()async {
    if (await _netWorkInf.isConnected) {
      try {
        ///add (try & catch) after handle code///
        /// for him try & catch because Dio use //

        final response = await _remoteDataSource.getStoreDetails();

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
