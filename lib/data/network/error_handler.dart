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
  Default
}

class ResponseCode {
  //Api durum kodları
  static int Success = 200;
  static int No_Content = 201;
  static int Bad_Request = 400;
  static int Forbidden = 403;
  static int Unauthorised = 401;
  static int Not_Found = 404;
  static int Internal_Server_Error = 500;

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
}
