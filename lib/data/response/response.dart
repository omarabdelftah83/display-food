
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
