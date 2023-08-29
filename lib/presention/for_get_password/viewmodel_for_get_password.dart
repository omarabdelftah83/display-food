import 'dart:async';

import 'package:mina/presention/base/base_view_Model.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();
  var email = "";
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  forgotPassword() {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  setEmail(String email) {
   inputEmail.add(email);
   this.email = email;
  _validate();
  }

  @override
  // TODO: implement inputEmail
  Sink get inputEmail => _emailStreamController.sink;

  @override
  // TODO: implement inputIsAllInputValid
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;


  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isValidPassword(email));
///must convert string to bool
  bool _isValidPassword(String email) {
    return email.isNotEmpty;
  }

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((_) => _isAllInputValid());
/// use email in sink==> in fun setEmail//
  _isAllInputValid() {
    return _isValidPassword( email);
  }
  _validate() {
    inputIsAllInputValid.add(null);
  }

}

abstract class ForgotPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
