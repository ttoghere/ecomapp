import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkImplementation implements NetworkInfo {
  DataConnectionChecker dataConnectionChecker;
  NetworkImplementation({
    required this.dataConnectionChecker,
  });
  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
