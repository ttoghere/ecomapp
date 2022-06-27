import 'package:dio/dio.dart';
import 'package:ecomapp/app/constants.dart';
import 'package:ecomapp/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constantss.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {required String baseUrl}) =
      _AppServiceClient;
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );
}
