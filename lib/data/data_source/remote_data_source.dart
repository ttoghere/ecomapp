import 'package:ecomapp/data/network/app_api.dart';
import 'package:ecomapp/data/request/request.dart';
import 'package:ecomapp/data/responses/responses.dart';

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
