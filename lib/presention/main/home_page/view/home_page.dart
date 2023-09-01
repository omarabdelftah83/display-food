import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mina/app/di.dart';
import 'package:mina/domain/entitiy/entity.dart';
import 'package:mina/presention/main/home_page/view_model/home_view_model.dart';
import 'package:mina/presention/resources/string_manager.dart';

import '../../../common/state_renderer/state_renderer_imp.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/valuies_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(

        child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  _getContentWidget();
            }),
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppString.services.tr()),
        _getServices(),
        _getSection(AppString.stores.tr()),
        _getStores()
      ],
    );
  }

  ///banners....////
  Widget _getBannersCarousel() {
    return StreamBuilder<List<BannerAd>>(
        stream: _viewModel.outputBanners,
        builder: (context, snapshot) {
          return _getBanner(snapshot.data);
        });
  }

  Widget _getBanner(List<BannerAd>? banners) {
    if (banners != null) {
      //convert banners to items===  .map
      return CarouselSlider(
          items: banners
              .map((banner) =>
                  // convert list banner to list of widget ==sizedBox  //
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: const BorderSide(
                              color: Colors.orangeAccent, width: 1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(banner.image, fit: BoxFit.cover),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height:130,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  ///section...///
  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  ///services....///
  Widget _getServices() {
    return StreamBuilder<List<Service>>(
        stream: _viewModel.outputServices,
        builder: (context, snapshot) {
          return _getService(snapshot.data);
        });
  }

  Widget _getService(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: 140,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          //list...//
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: const BorderSide(
                              color: Colors.orangeAccent, width: 1)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.network(
                              service.image,
                              fit: BoxFit.cover,
                              width: AppSize.s100,
                              height: AppSize.s100,
                            ),
                          ),
                          //text...///
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: AppPadding.p8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  service.title.tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores() {
    return StreamBuilder<List<Store>>(
        stream: _viewModel.outputStores,
        builder: (context, snapshot) {
          return _getStore(snapshot.data);
        });
  }

  Widget _getStore(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        //No list ....//
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    // navigate to store details screen
                    Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                  },
                  child: Card(
                    elevation: 4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
