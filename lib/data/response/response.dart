
//$$//
import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

///Response Login Api///

///create replacing fromJson///
@JsonSerializable()
class BaseResponse {

  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;

}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotification")
  int? numOfNotification;

  CustomerResponse(this.id, this.name, this.numOfNotification);
  ///from json//
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  ///toJson//
  Map<String,dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactResponse(this.phone, this.email, this.link);
  ///from json//
  factory ContactResponse.fromJson(Map<String, dynamic> json) => _$ContactResponseFromJson(json);

  ///toJson//
  Map<String,dynamic> toJson() => _$ContactResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactResponse? contact;

  AuthenticationResponse(this.customer, this.contact);

  ///from json//
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  ///toJson//
  Map<String,dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

///.........home.........//
@JsonSerializable()
class ServicesResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  ServicesResponse(this.id,this.title,this.image);

  ///toJson//
  Map<String,dynamic> toJson() => _$ServicesResponseToJson(this);
  ///from json//
  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);

}
@JsonSerializable()
class BannersResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "link")
  String? link;
  BannersResponse(this.id,this.title,this.image,this.link);

  ///toJson//
  Map<String,dynamic> toJson() => _$BannersResponseToJson(this);
  ///from json//
  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);

}
@JsonSerializable()
class StoreResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  StoreResponse(this.id,this.title,this.image);

  ///toJson//
  Map<String,dynamic> toJson() => _$StoreResponseToJson(this);
  ///from json//
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

}
@JsonSerializable()
class HomeDataResponse{
  @JsonKey(name: "services")
  List<ServicesResponse>? services;
  @JsonKey(name: "banners")
  List<BannersResponse>? banners;
  @JsonKey(name: "stores")
  List<StoreResponse>? stores;
  HomeDataResponse(this.services,this.banners,this.stores);

  ///toJson//
  Map<String,dynamic> toJson() => _$HomeDataResponseToJson(this);
  ///from json//
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}
@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeDataResponse? data;
  HomeResponse(this.data);

  ///toJson//
  Map<String,dynamic> toJson() => _$HomeResponseToJson(this);
  ///from json//
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

}
///details response...////

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'about')
  String? about;

  StoreDetailsResponse(this.id, this.title, this.image,this.details, this.services, this.about);

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}