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
