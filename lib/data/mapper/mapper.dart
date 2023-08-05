

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