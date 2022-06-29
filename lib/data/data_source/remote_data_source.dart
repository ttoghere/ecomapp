import '../data_shelf.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login({required LoginRequest loginRequest});
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient appServiceClient;
  RemoteDataSourceImplementer({
    required this.appServiceClient,
  });
  @override
  Future<AuthenticationResponse> login(
      {required LoginRequest loginRequest}) async {
    return await appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }
}
