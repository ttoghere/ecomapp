import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_shelf.dart';

//Constants
const String application_json = "application/json";
const String content_type = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String default_language = "language";

class DioFactory {
  AppPreferences appPreferences;
  DioFactory({
    required this.appPreferences,
  });

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeOut = 60 * 1000;
    String language = await appPreferences.getAppLanguage();
    Map<String, String> headers = {
      content_type: application_json,
      accept: application_json,
      authorization: Constantss.token,
      default_language: language,
    };
    dio.options = BaseOptions(
      baseUrl: Constantss.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );
    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
