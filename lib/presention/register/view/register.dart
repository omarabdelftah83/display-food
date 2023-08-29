import 'dart:developer';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mina/app/di.dart';
import 'package:mina/presention/register/view_model/register_view_model.dart';
import 'package:mina/presention/resources/image_path.dart';

import '../../../app/app_preference.dart';
import '../../../app/constant.dart';
import '../../common/state_renderer/state_renderer_imp.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/valuies_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _userNameEditingController.addListener(() {
      _viewModel.setUserName(_userNameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });
    /// to main ....///
    _viewModel.isUsedRegisterInSuccessStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance?.addPersistentFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orangeAccent),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  //if data in null _getContentWidget/// data not null _viewModel.register()
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        padding: const EdgeInsets.only(top: AppPadding.p14),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Center(
                    child: Image(image: AssetImage(ImagePath.splashLogo))),
                const SizedBox(
                  height: AppSize.s18,
                ),

                ///USER NAME
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorUserName,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameEditingController,
                          decoration: InputDecoration(
                              hintText: AppString.username,
                              labelText: AppString.username,
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),

                ///mobile num..../
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: (country) {
                                // update view model with code
                                _viewModel.setCountryCode(country.dialCode ?? '');
                              },
                              initialSelection: '+20',
                              favorite: const ['+39', 'FR', "+966"],
                              // optional. Shows only country name and flag
                              showCountryOnly: true,
                              hideMainText: true,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: true,
                            )),
                        Expanded(
                            flex: 4,
                            child: StreamBuilder<String?>(
                                stream: _viewModel.outputErrorMobileNumber,
                                builder: (context, snapshot) {
                                  return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _mobileNumberEditingController,
                                    decoration: InputDecoration(
                                        hintText: AppString.mobileNumber.tr(),
                                        labelText: AppString.mobileNumber.tr(),
                                        errorText: snapshot.data),
                                  );
                                }))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),

                ///email......///
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmail,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailEditingController,
                          decoration: InputDecoration(
                              hintText: AppString.emailHint.tr(),
                              labelText: AppString.emailHint.tr(),
                              errorText: snapshot.data),
                        );
                      }),
                ),

                const SizedBox(
                  height: AppSize.s18,
                ),

                ///PASSWORD......///
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPassword,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordEditingController,
                          decoration: InputDecoration(
                              hintText: AppString.password,
                              labelText: AppString.password,
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),

                ///profile picture....//
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.grey)),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                       _showPicker(context);
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: AppSize.s18,
                ),
                ///Elevated button....////
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputAreAllInputValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child:  Text(AppString.register.tr())),
                        );
                      }),
                ),

                ///text button....../
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppString.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.titleMedium).tr(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  _showPicker(BuildContext context){
showModalBottomSheet(context: context, builder: (BuildContext context){
  return SafeArea(child: Wrap(children: [
    ListTile(
      trailing: const Icon(Icons.arrow_forward),
      leading: const Icon(Icons.camera),
      title: const Text(AppString.photoGallery).tr(),
      onTap: () {
        _imageFromGallery();
        Navigator.of(context).pop();
      },
    ),
    ListTile(
      trailing: const Icon(Icons.arrow_forward),
      leading: const Icon(Icons.camera_alt_outlined),
      title: const Text(AppString.photoCamera).tr(),
      onTap: () {
       _imageFromCamera();
        Navigator.of(context).pop();
      },
    )
  ],));
});
  }
  _imageFromGallery() async {
    try{
      log("=====basuony===========");
      var image = await _imagePicker.pickImage(source: ImageSource.gallery);
      _viewModel.setProfilePicture(File(image?.path ?? ""));
    }catch(e,s)
    {
      log("========e==$e==$s");
    }
  }

  _imageFromCamera() async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }



  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Flexible(child: Text(AppString.profilePicture).tr()),
       Flexible(child: StreamBuilder<File>(
           stream: _viewModel.outputIsProfilePictureValid,
           builder: (context,snapshot){
             return _imagePichet(snapshot.data);
  }
    )),
          const Flexible( child: Image(image: AssetImage('assets/images/images.jpg')))
        ],
      ),
    );
  }
  Widget _imagePichet(File? image){
    if(image!=null && image.path.isNotEmpty){
return Image.file(image);
    }else{
return Container();
    }
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }
}
