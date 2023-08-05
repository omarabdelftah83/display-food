import 'package:flutter/material.dart';
import 'package:mina/app/di.dart';
import 'package:mina/presention/login/viewmodel/login_viewmodel.dart';
import 'package:mina/presention/resources/string_manager.dart';

import '../../resources/image_path.dart';
import '../../resources/routes_manager.dart';
import '../../resources/valuies_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ///instance in login view model //
  final LoginViewModel _viewModel = LoginViewModel(); //instance from loginViewModel
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController.addListener(
        () => _viewModel.setUserName(_userNameController.text)); //update user
    _userPasswordController.addListener(() =>
        _viewModel.setPassword(_userPasswordController.text)); //update pass
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 100),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Center(
                  child: Image(image: AssetImage(ImagePath.splashLogo)),
                ),
                const SizedBox(
                  height: 40,
                ),
                ///username//
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapShot) {
                      return TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppString.username,
                            labelText: AppString.username,
                            errorText: (snapShot.data ?? true)
                                ? null
                                : AppString.usernameError),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ///password///
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputPasswordValid,
                    builder: (context, snapShot) {
                      return TextFormField(
                        controller: _userPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: AppString.password,
                            labelText: AppString.password,
                            errorText: (snapShot.data ?? true)
                                ? null
                                : AppString.passwordError),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                ///check input valid///===>>login
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outAreAllInputValid,
                      builder: (context, snapshot) {
                        return Container(
                          width: 335,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.login();
                                    }
                                  : null,
                              child: const Text(AppString.login)),
                        );
                      }),
                ),
                ///forget password//
                Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        left: AppPadding.p28,
                        right: AppPadding.p28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.forgotPasswordRoute);
                          },
                          child: Text(AppString.forgetPassword,
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                        TextButton(

                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(AppString.registerText ,
                              style: Theme.of(context).textTheme.titleMedium,),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }
}
