import 'package:dartz/dartz.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/login/domain/entities/authenticated_user_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticatedUserEntity>> authenticate(
      String email, String password);
}
