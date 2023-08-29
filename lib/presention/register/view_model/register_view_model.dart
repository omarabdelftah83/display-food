import 'dart:async';
import 'dart:io';

import 'package:mina/domain/usercase/register_usecase.dart';
import 'package:mina/presention/base/base_view_Model.dart';
import 'package:mina/presention/resources/string_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/data_classes/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_imp.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController userNameStreamController =
  BehaviorSubject<String>();
  final StreamController mobileNumberStreamController =
  BehaviorSubject<String>();
  final StreamController emailStreamController =
  BehaviorSubject<String>();
  final StreamController passwordStreamController =
  BehaviorSubject<String>();
  final StreamController profilePictureStreamController =
  BehaviorSubject<File>();
  ///check to valid //
  final StreamController areAllInputValidStreamController =
  BehaviorSubject<void>();
  ///login to main //
  StreamController isUsedRegisterInSuccessStreamController =
  BehaviorSubject<bool>();
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject('', '', '', '', '', '');

  @override
  void start() {
inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _registerUseCase.execute(
        RegisterUseCaseInput(
            registerObject.userName, registerObject.countryMobileCode,
            registerObject.mobileNumber, registerObject.email,
            registerObject.password, registerObject.profilePicture)))
        .fold((left) {
      print('==========omar======= ');
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, left.message));
    }, (right) {
          ///to do
     print('==========mohamed======= ');
      inputState.add(ContentState());
      isUsedRegisterInSuccessStreamController.add(true);});


    try{

    }catch(e,slc){
      print('=====$slc====');

    }
  }






  @override
  void dispose() {
    super.dispose();
    userNameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputValidStreamController.close();
    isUsedRegisterInSuccessStreamController.close();
  }

  ///inputs//
  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Sink get inputAllInputValid => areAllInputValidStreamController.sink;

  ///output.......//
  @override
  Stream<bool> get outputIsUserNameValid =>
      userNameStreamController.stream
          .map((userName) => _isUserNameValid(userName));

  @override
  //connect 2 stream by some//
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map(
            (isUserName) => isUserName ? null : AppString.errorEmail,
      );

  ///............///
  @override
  Stream<bool> get outputIsEmailValid =>
      emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail =>
      outputIsEmailValid
          .map((isEmailValid) => isEmailValid ? null : AppString.emailValid);

  ///............///

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      mobileNumberStreamController.stream
          .map((mobileNum) => _isMobileNumValid(mobileNum));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map(
              (isMobileNumValid) =>
          isMobileNumValid ? null : AppString.mobileNumValid);

  ///............///
  @override
  Stream<bool> get outputIsPasswordValid =>
      passwordStreamController.stream.map((password) => _isPassValid(password));

  @override
  Stream<String?> get outputErrorPassword =>
      outputIsPasswordValid
          .map((isPassValid) => isPassValid ? null : AppString.passValid);

  ///............///

  @override
  Stream<File> get outputIsProfilePictureValid =>
      profilePictureStreamController.stream.map((file) => file);

  ///............///

  @override
  Stream<bool> get outputAreAllInputValid =>
      areAllInputValidStreamController.stream.map((_) => _areAllInputsValid());

/////
  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      //  update register view object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset username value in register view object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      //  update register view object
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      // reset code value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      //  update register view object
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumValid(mobileNumber)) {
      //  update register view object
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset mobileNumber value in register view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPassValid(password)) {
      //  update register view object
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      //  update register view object
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture value in register view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  ///private function..//

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isEmailValid(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _isMobileNumValid(String mobileNum) {
    return mobileNum.length >= 11;
  }

  bool _isPassValid(String pass) {
    return pass.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputAllInputValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  register();

  setUserName(String userName);

  setMobileNumber(String mobileNumber);

  setCountryCode(String countryCode);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File profilePicture);

  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  Sink get inputAllInputValid;
}

abstract class RegisterViewModelOutput {
  ///connect 2 stream
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;

  Stream<bool> get outputAreAllInputValid;
}





