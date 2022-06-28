import 'package:dartz/dartz.dart';

import 'package:ecomapp/app/app_shelf.dart';
import 'package:ecomapp/app/functions.dart';
import 'package:ecomapp/data/network/failure.dart';
import 'package:ecomapp/data/request/request.dart';
import 'package:ecomapp/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository repository;
  LoginUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await repository.login(
        loginRequest: LoginRequest(
      email: input.email,
      password: input.password,
      imei: deviceInfo.identifier,
      deviceType: deviceInfo.name,
    ));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}
