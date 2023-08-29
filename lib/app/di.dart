import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mina/app/app_preference.dart';
import 'package:mina/data/datasourse/local_data_sourse.dart';
import 'package:mina/data/datasourse/remote_data_sourse.dart';
import 'package:mina/data/network/app_api.dart';
import 'package:mina/data/network/dio_factory.dart';
import 'package:mina/data/network/network_info.dart';
import 'package:mina/data/repository/repository.dart';
import 'package:mina/domain/repository/repository.dart';
import 'package:mina/domain/usercase/home_usecase.dart';
import 'package:mina/domain/usercase/login_usecase.dart';
import 'package:mina/domain/usercase/register_usecase.dart';
import 'package:mina/presention/login/viewmodel/login_viewmodel.dart';
import 'package:mina/presention/main/home_page/view_model/home_view_model.dart';
import 'package:mina/presention/register/view_model/register_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usercase/store_details_usecase.dart';
import '../presention/store_datiles/store_detailes_viewmodel.dart';


final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetWorkInf>(
          () => NetWorkInfImp(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImpl(instance<AppServiceClient>()));
  // local data source
  instance.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImp());

  instance.registerLazySingleton<BaseRepository>(
          () => RepositoryImp(instance(), instance(),instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }}
  initRegisterModule() {
    if (!GetIt.I.isRegistered<RegisterUseCase>()) {
      instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
      instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
      instance.registerFactory<ImagePicker>(() => ImagePicker());

    }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));

  }
}
initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCaseUseCase>()) {
    instance.registerFactory<StoreDetailsUseCaseUseCase>(
            () => StoreDetailsUseCaseUseCase(instance()));

    instance.registerFactory<StoreDetailsViewModel>(
            () => StoreDetailsViewModel(instance()));
  }
}

















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
//
//   if(!GetIt.I.isRegistered<LoginUseCase>()){
//     ///login useCase//  ===>>>where base login useCase
//     instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
//     ///login view model =====>>>where base login view model
//     instance.registerFactory<LoginViewModel>(() => LoginViewModel());
//   }
//
// }
