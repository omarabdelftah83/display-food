
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mina/presention/store_datiles/store_detailes_viewmodel.dart';

import '../../app/di.dart';
import '../../domain/entitiy/entity.dart';
import '../common/state_renderer/state_renderer_imp.dart';
import '../resources/string_manager.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  @override
  void initState() {
    bind();
    super.initState();
  }

  bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return Container(
              child:
              snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.start();
              }) ??
                  Container(),
            );
          },
        ));
  }

  Widget _getContentWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(AppString.storeDetails).tr(),
          elevation: 0,
          iconTheme: IconThemeData(
            //back button
            color: Colors.white,
          ),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: StreamBuilder<StoreDetails>(
              stream: _viewModel.outputStoreDetails,
              builder: (context, snapshot) {
                return _getItems(snapshot.data);
              },
            ),
          ),
        ));
  }

  Widget _getItems(StoreDetails? storeDetails) {
    if (storeDetails != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.network(
                storeDetails.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              )),
          _getSection(AppString.details),
          _getInfoText(storeDetails.details),
          _getSection(AppString.services),
          _getInfoText(storeDetails.services),
          _getSection(AppString.about),
          _getInfoText(storeDetails.about)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
            bottom: 2),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium));
  }

  Widget _getInfoText(String info) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(info, style: Theme.of(context).textTheme.bodySmall),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
