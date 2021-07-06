import 'package:ioasys_tdd/core/errors/exceptions.dart';
import 'package:ioasys_tdd/features/login/data/datasources/authentication_datasource.dart';
import 'package:ioasys_tdd/features/login/domain/entities/authenticated_user_entity.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ioasys_tdd/features/login/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource datasource;

  AuthenticationRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, AuthenticatedUserEntity>> authenticate(
      String email, String password) async {
    try {
      final authenticatedUser = await datasource.authenticate(email, password);
      return Right(authenticatedUser);
    } on AuthenticationException {
      return Left(
        AuthenticationFailure(),
      );
    }
  }
}
