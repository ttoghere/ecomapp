import 'package:dartz/dartz.dart';
import '../../app/app_shelf.dart';
import '../../domain/repository/repository.dart';
import '../data_shelf.dart';

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
      try {
        final response =
            await remoteDataSource.login(loginRequest: loginRequest);
        if (response.status == ApiInternalStatus.Success) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              code: response.status ?? ApiInternalStatus.Failure,
              message: response.message ?? ResponseMessage.Default));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.No_Internet_Connection.getFailure());
    }
  }
}
