import 'package:ecomapp/data/data_shelf.dart';

class Failure {
  int code;
  String message;
  Failure({
    required this.code,
    required this.message,
  });
}

class DefaultFailure extends Failure {
  DefaultFailure()
      : super(code: ResponseCode.Default, message: ResponseMessage.Default);
}
