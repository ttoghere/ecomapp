import 'package:dio/dio.dart';
import '../data_shelf.dart';


enum DataSource {
  Success,
  No_Content,
  Bad_Request,
  Forbidden,
  Unauthorised,
  Not_Found,
  Internal_Server_Error,
  Connect_Timeout,
  Cancel,
  Receive_Timeout,
  Send_Timeout,
  Cache_Error,
  No_Internet_Connection,
  Default,
}

class ResponseCode {
  //Api durum kodları
  static int Success = 200;
  static int No_Content = 201;
  static const int Bad_Request = 400;
  static const int Forbidden = 403;
  static const int Unauthorised = 401;
  static const int Not_Found = 404;
  static const int Internal_Server_Error = 500;

  //Cihaz durum kodları
  static int Unknown = -1;
  static int Connect_Timeout = -2;
  static int Cancel = -3;
  static int Receive_Timeout = -4;
  static int Send_Timeout = -5;
  static int Cache_Error = -6;
  static int No_Internet_Connection = -7;
  static int Default = -8;
}

class ResponseMessage {
  //Api durum kodları
  static String Success = "Success";
  static String No_Content = "No Content";
  static String Bad_Request = "Bad Request";
  static String Forbidden = "Forbidden";
  static String Unauthorised = "Unauthorised";
  static String Not_Found = "Not_Found";
  static String Internal_Server_Error = "Internal_Server_Error";

  //Cihaz durum kodları
  static String Unknown = "Bir sorun oluştu";
  static String Connect_Timeout = "Zaman aşımı";
  static String Cancel = "İstek başarısız oldu";
  static String Receive_Timeout = "Zaman aşımı";
  static String Send_Timeout = "Zaman aşımı";
  static String Cache_Error = "Cache hatası";
  static String No_Internet_Connection = "İnternet bağlantısı yok";
  static String Default = "Bir sorun oluştu";
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.Bad_Request:
        return Failure(
            code: ResponseCode.Bad_Request,
            message: ResponseMessage.Bad_Request);
      case DataSource.Forbidden:
        return Failure(
            code: ResponseCode.Forbidden, message: ResponseMessage.Forbidden);

      case DataSource.Unauthorised:
        return Failure(
            code: ResponseCode.Unauthorised,
            message: ResponseMessage.Unauthorised);

      case DataSource.Not_Found:
        return Failure(
            code: ResponseCode.Not_Found, message: ResponseMessage.Not_Found);

      case DataSource.Internal_Server_Error:
        return Failure(
            code: ResponseCode.Internal_Server_Error,
            message: ResponseMessage.Internal_Server_Error);

      case DataSource.Connect_Timeout:
        return Failure(
            code: ResponseCode.Connect_Timeout,
            message: ResponseMessage.Connect_Timeout);

      case DataSource.Cancel:
        return Failure(
            code: ResponseCode.Cancel, message: ResponseMessage.Cancel);

      case DataSource.Receive_Timeout:
        return Failure(
            code: ResponseCode.Receive_Timeout,
            message: ResponseMessage.Receive_Timeout);

      case DataSource.Send_Timeout:
        return Failure(
            code: ResponseCode.Send_Timeout,
            message: ResponseMessage.Send_Timeout);

      case DataSource.Cache_Error:
        return Failure(
            code: ResponseCode.Cache_Error,
            message: ResponseMessage.Cache_Error);

      case DataSource.No_Internet_Connection:
        return Failure(
            code: ResponseCode.No_Internet_Connection,
            message: ResponseMessage.No_Internet_Connection);
      case DataSource.Default:
        return Failure(
            code: ResponseCode.Default, message: ResponseMessage.Default);

      default:
        return Failure(
            code: ResponseCode.Unknown, message: ResponseMessage.Unknown);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //Dio hatası
      failure = _handleError(error);
    } else {
      //Varsayılan hata
      failure = DataSource.Default.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.Connect_Timeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.Send_Timeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.Receive_Timeout.getFailure();
      case DioErrorType.cancel:
        return DataSource.Cancel.getFailure();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.Bad_Request:
            return DataSource.Bad_Request.getFailure();
          case ResponseCode.Forbidden:
            return DataSource.Forbidden.getFailure();
          case ResponseCode.Unauthorised:
            return DataSource.Unauthorised.getFailure();
          case ResponseCode.Not_Found:
            return DataSource.Not_Found.getFailure();
          case ResponseCode.Internal_Server_Error:
            return DataSource.Internal_Server_Error.getFailure();
          default:
            return DataSource.Default.getFailure();
        }

      case DioErrorType.other:
        return DataSource.Default.getFailure();
    }
  }
}

class ApiInternalStatus {
  static const int Success = 0;
  static const int Failure = 1;
}
