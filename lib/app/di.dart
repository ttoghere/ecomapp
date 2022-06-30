import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ecomapp/app/app_prefs.dart';
import 'package:ecomapp/app/constants.dart';
import 'package:ecomapp/data/data_source/remote_data_source.dart';
import 'package:ecomapp/data/network/app_api.dart';
import 'package:ecomapp/data/network/dio_factory.dart';
import 'package:ecomapp/data/network/network_info.dart';
import 'package:ecomapp/data/repository/repository_impl.dart';
import 'package:ecomapp/domain/repository/repository.dart';
import 'package:ecomapp/domain/usecase/login_usecase.dart';
import 'package:ecomapp/presentation/view/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  //SP instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  //AP instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(
      sharedPreferences: instance<SharedPreferences>(),
    ),
  );
  //NI instance
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkImplementation(
      dataConnectionChecker: DataConnectionChecker(),
    ),
  );
  //DF instance
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(appPreferences: instance()),
  );
  //ASC instance
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(
      () => AppServiceClient(dio, baseUrl: Constantss.baseUrl));
  //RDS instance
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementer(
      appServiceClient: instance(),
    ),
  );
  //Repo instance
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSource: instance(),
      networkInfo: instance(),
    ),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    //LU instance
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(
        repository: instance(),
      ),
    );
    //LWM instance
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(
        instance(),
      ),
    );
  }
}
