import 'package:mina/app/constant.dart';
import 'package:mina/app/extension.dart';

import '../../domain/entitiy/entity.dart';
import '../response/response.dart';

///convert response to obj///
///to model//
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(

        ///if id empty ==>''  //
        this?.id.orEmpty() ?? Constant.empty,
        this?.name.orEmpty() ?? Constant.empty,
        this?.numOfNotification.orZero() ?? Constant.zero);
  }
}

extension ContactsResponseMapper on ContactResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constant.empty,
        this?.email.orEmpty() ?? Constant.empty,
        this?.link.orEmpty() ?? Constant.empty);
  }
}

///important //
extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contact.toDomain());
  }
}

///home....//

extension ServiceResponseMapper on ServicesResponse? {
  Service toDomain() {
    //orEmpty() ==>convert string? to string//
    return Service(
        this?.id.orZero() ?? Constant.zero,
        this?.title.orEmpty() ?? Constant.empty,
        this?.image.orEmpty() ?? Constant.empty);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
        this?.id.orZero() ?? Constant.zero,
        this?.title.orEmpty() ?? Constant.empty,
        this?.image.orEmpty() ?? Constant.empty);
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id.orZero() ?? Constant.zero,
      this?.title.orEmpty() ?? Constant.empty,
      this?.image.orEmpty() ?? Constant.empty,
      this?.link.orEmpty() ?? Constant.empty,
    );
  }
}
///home....///
extension HomeDataResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    ///convert list to domain ///
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();
    List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannerResponse) => bannerResponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();
    List<Store> stores =
        (this?.data?.stores?.map((storeResponse) => storeResponse.toDomain()) ??
                const Iterable.empty())
            .cast<Store>()
            .toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}
///details ...//
extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
        this?.id?.orZero() ?? Constant.zero,
        this?.title?.orEmpty() ?? Constant.empty,
        this?.image?.orEmpty() ?? Constant.empty,
        this?.details?.orEmpty() ?? Constant.empty,
        this?.services?.orEmpty() ?? Constant.empty,
        this?.about?.orEmpty() ?? Constant.empty);
  }
}