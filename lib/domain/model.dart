import 'package:dartz/dartz.dart';
import 'package:ecomapp/app/app_shelf.dart';

import '../data/network/failure.dart';
import '../data/request/request.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(
      {required LoginRequest loginRequest});
}
