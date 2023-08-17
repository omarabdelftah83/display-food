import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mina/presention/base/base_view_Model.dart';
import 'package:mina/presention/common/state_renderer/state_renderer.dart';
import 'package:mina/presention/common/state_renderer/state_renderer_imp.dart';

import '../../../domain/usercase/login_usecase.dart';
import '../../common/data_classes/freezed_data_classes.dart';
import 'package:mina/presention/resources/routes_manager.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUsedLoggerInSuccessStreamController =
      StreamController<bool>.broadcast();

  ///___dataClasses___//
  var loginObject = LoginObject('', '');

  ///useCase//
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  ///inputs///
  @override
  void dispose() {
    //dispose in base//
    super.dispose();

    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputValidStreamController.close();
    isUsedLoggerInSuccessStreamController.close();
  }

  @override
  void start() {
    ///base==>show content after login//
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreAllInputValid => _areAllInputValidStreamController.sink;

  @override
  login() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold((left) {
      print('=========llllllllll=====$left');

      inputState.add(ErrorState(StateRendererType.popupErrorState, left.message));
    }, (right) {
          print('=======rrrrrrrrrrrrrr=======$right');
      inputState.add(ContentState());

    isUsedLoggerInSuccessStreamController.add(true);
    });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);

    ///check to pass  in first
    inputAreAllInputValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName); //add sink
    loginObject = loginObject.copyWith(userName: userName); //add dataClasses
    ///check to user  in first

    inputAreAllInputValid.add(null);
  }

  ///outputs///
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isValidUserName(userName));

  @override
  Stream<bool> get outputPasswordValid => _passwordStreamController.stream
      .map((password) => _isValidPassword(password));

  @override
  Stream<bool> get outAreAllInputValid =>
      _areAllInputValidStreamController.stream.map((_) => _areAllInputValid());

  bool _areAllInputValid() {
    return _isValidUserName(loginObject.userName) &&
        _isValidPassword(loginObject.password);
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty;
  }

  bool _isValidUserName(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputPasswordValid;

  Stream<bool> get outAreAllInputValid;
}
