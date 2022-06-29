import 'package:dartz/dartz.dart';
import '../../app/app_shelf.dart';
import '../../data/data_shelf.dart';
import '../domain_shelf.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository repository;
  LoginUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
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
