
import '../../app/app_shelf.dart';
import '../data_shelf.dart';

const Empty = "";
const Zero = 0;

extension CustomerResponseManager on CustomResponse? {
  Customer toDomain() {
    return Customer(
        id: this?.id?.orEmpty() ?? Empty,
        name: this?.name?.orEmpty() ?? Empty,
        numOfNotifications: this?.numOfNotifications?.orZero() ?? Zero);
  }
}

extension ContactResponseManager on ContactResponse? {
  Contacts toDomain() {
    return Contacts(
        email: this?.email?.orEmpty() ?? Empty,
        phone: this?.phone?.orEmpty() ?? Empty,
        link: this?.link?.orEmpty() ?? Empty);
  }
}

extension AuthenticationManager on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        customer: this?.customer?.toDomain(),
        contacts: this?.contact?.toDomain());
  }
}
