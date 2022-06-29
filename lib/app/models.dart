class SliderObject {
  String title;
  String subtitle;
  String image;
  SliderObject({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SlideViewObject({
    required this.sliderObject,
    required this.numOfSlides,
    required this.currentIndex,
  });
  
}

class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer({
    required this.id,
    required this.name,
    required this.numOfNotifications,
  });
}

class Contacts {
  String email;
  String phone;
  String link;
  Contacts({
    required this.email,
    required this.phone,
    required this.link,
  });
}

class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication({
    required this.customer,
    required this.contacts,
  });
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo({
    required this.name,
    required this.identifier,
    required this.version,
  });
}
