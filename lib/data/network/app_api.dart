import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../app/app_shelf.dart';
import '../data_shelf.dart';
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
