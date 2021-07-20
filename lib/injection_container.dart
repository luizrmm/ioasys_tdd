import 'package:get_it/get_it.dart';
import 'package:ioasys_tdd/core/external/headers_local_manager.dart';

import 'package:ioasys_tdd/features/companies/data/datasource/enterprise_datasource.dart';
import 'package:ioasys_tdd/features/companies/data/repositories/enterprise_repository_impl.dart';
import 'package:ioasys_tdd/features/companies/domain/repositories/enterprise_repository.dart';
import 'package:ioasys_tdd/features/companies/domain/usecases/get_all_enterprises_usecase.dart';
import 'package:ioasys_tdd/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:ioasys_tdd/features/login/data/datasources/authentication_datasource.dart';
import 'package:ioasys_tdd/features/login/domain/usecases/authenticate_usecase.dart';
import 'package:ioasys_tdd/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/external/authenticated_http_client.dart';
import 'features/login/data/repositories/authentication_repository_impl.dart';
import 'features/login/domain/repositories/authentication_repository.dart';
import 'package:http/http.dart' show Client;

final sl = GetIt.instance;
Future<void> init() async {
  //! Features - Authenticate
  // Bloc
  sl.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(authenticateUsecase: sl()),
  );
  sl.registerFactory<CompaniesBloc>(
      () => CompaniesBloc(allEnterprisesUsecase: sl()));

  //UseCases
  sl.registerLazySingleton<AuthenticateUsecase>(
    () => AuthenticateUsecase(sl<AuthenticationRepository>()),
  );
  sl.registerLazySingleton<GetAllEnterprisesUsecase>(
      () => GetAllEnterprisesUsecase(sl<EnterpriseRespository>()));

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton<EnterpriseRespository>(
    () => EnterpriseRepositoryImpl(datasource: sl<EnterpriseDataSource>()),
  );

  //DataSources
  sl.registerLazySingleton<AuthenticationDataSource>(
    () => AuthenticationDataSourceImpl(
        client: sl<Client>(), headersManager: sl<AuthHeadersManager>()),
  );
  sl.registerLazySingleton<EnterpriseDataSource>(
      () => EnterpriseDataSourceImpl(client: sl<AuthenticatedHttpClient>()));
  //! Core

  //! External

  sl.registerLazySingleton<Client>(() => Client());
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<AuthHeadersManager>(
      () => AuthHeadersManagerImpl(sharedPreferences: sl<SharedPreferences>()));

  sl.registerLazySingleton<AuthenticatedHttpClient>(
      () => AuthenticatedHttpClient(headersManager: sl<AuthHeadersManager>()));
}
