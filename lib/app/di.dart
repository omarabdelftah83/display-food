// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:mina/app/app_preference.dart';
// import 'package:mina/data/datasourse/remote_data_sourse.dart';
// import 'package:mina/data/network/app_api.dart';
// import 'package:mina/data/network/dio_factory.dart';
// import 'package:mina/data/network/network_info.dart';
// import 'package:mina/data/repository/repository.dart';
// import 'package:mina/domain/repository/repository.dart';
// import 'package:mina/domain/usercase/login_usecase.dart';
// import 'package:mina/presention/login/viewmodel/login_viewmodel.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// final instance = GetIt.instance;
//
// Future<void> initAppModule() async {
//   ///shared pref && app pref//
//   final sharedPref = await SharedPreferences.getInstance();
//   instance.registerLazySingleton<SharedPreferences>(() => sharedPref);
//   instance.registerLazySingleton<AppPreferences>(() => instance());
//
//   ///network info//
//   instance.registerLazySingleton<NetWorkInf>(
//       () => NetWorkInfImp(InternetConnectionChecker()));
//
//   ///dio factory//
//   instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
//
//   ///dio//
//   Dio dio = await instance<DioFactory>().getDio();
//
//   ///app serves client///
//   instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
//
//   ///remote data source//
//   instance.registerLazySingleton<RemoteDataSource>(
//       () => RemoteDataSourceImpl(instance()));
//
//   ///base repository//
//   instance.registerLazySingleton<BaseRepository>(
//       () => RepositoryImp(instance(), instance()));
// }
//
//  loginModule(){
//   if(!GetIt.I.isRegistered<LoginUseCase>()){
//     ///login useCase//
//     instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
//     ///login view model
//     instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
//   }
//
// }