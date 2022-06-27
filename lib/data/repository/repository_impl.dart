import 'package:dartz/dartz.dart';

import 'package:ecomapp/app/models.dart';
import 'package:ecomapp/data/data_source/remote_data_source.dart';
import 'package:ecomapp/data/mapper/mapper.dart';
import 'package:ecomapp/data/network/failure.dart';
import 'package:ecomapp/data/network/network_info.dart';
import 'package:ecomapp/data/request/request.dart';
import 'package:ecomapp/domain/model.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Authentication>> login(
      {required LoginRequest loginRequest}) async {
    if (await networkInfo.isConnected) {
      //Api çağrısı için güvenli
      final response = await remoteDataSource.login(loginRequest: loginRequest);
      if (response.status == 0) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(
            code: 409,
            message:
                response.message ?? "we have biz error logic from api side"));
      }
    } else {
      return Left(
          Failure(code: 501, message: "please check your internet connection"));
    }
  }
}
