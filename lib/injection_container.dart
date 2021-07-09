import 'package:get_it/get_it.dart';
import 'package:ioasys_tdd/features/login/data/datasources/authentication_datasource.dart';
import 'package:ioasys_tdd/features/login/domain/usecases/authenticate_usecase.dart';
import 'package:ioasys_tdd/features/login/presentation/bloc/authentication_bloc.dart';

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

  //UseCases
  sl.registerLazySingleton<AuthenticateUsecase>(
    () => AuthenticateUsecase(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(datasource: sl()),
  );

  //DataSources
  sl.registerLazySingleton<AuthenticationDataSource>(
    () => AuthenticationDataSourceImpl(client: sl()),
  );

  //! Core

  //! External
  sl.registerLazySingleton<Client>(() => Client());
}
