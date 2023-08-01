
//$//
//onBoarding model//
class SliderObj {
  String title;
  String subTitle;
  String image;

  SliderObj(this.title, this.subTitle, this.image);
}
class SliderViewObj{
 SliderObj sliderObj;
  int numOfSlides;
  SliderViewObj(this.sliderObj,this.numOfSlides);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}
