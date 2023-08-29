import 'dart:async';
import 'dart:ffi';

import 'package:mina/presention/common/state_renderer/state_renderer.dart';
import 'package:mina/presention/common/state_renderer/state_renderer_imp.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entitiy/entity.dart';
import '../../../../domain/usercase/home_usecase.dart';
import '../../../base/base_view_Model.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
        (l) => {
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, l.message)),
            },
        (homeObj)  {
          ///...api.....///
          inputState.add(ContentState());
          inputBanners.add(homeObj.data?.banners);
          inputServices.add(homeObj.data?.services);
          inputStores.add(homeObj.data?.stores);

        });
  }

  @override
  // TODO: implement inputBanners
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  // TODO: implement inputServices
  Sink get inputServices => _servicesStreamController.sink;

  @override
  // TODO: implement inputStores
  Sink get inputStores => _storesStreamController.sink;

  @override
  // TODO: implement outputBanners
  Stream<List<BannerAd>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  // TODO: implement outputServices
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  // TODO: implement outputStores
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInput {
  Sink get inputStores;

  Sink get inputServices;

  Sink get inputBanners;
}

abstract class HomeViewModelOutput {
  Stream<List<Store>> get outputStores;

  Stream<List<Service>> get outputServices;

  Stream<List<BannerAd>> get outputBanners;
}

