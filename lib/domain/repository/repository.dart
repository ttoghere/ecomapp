
import 'package:dartz/dartz.dart';
import 'package:ecomapp/app/app_shelf.dart';
import 'package:ecomapp/data/request/request.dart';
import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(
      {required LoginRequest loginRequest});
}
