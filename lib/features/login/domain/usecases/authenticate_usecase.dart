import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/core/usecases/usecase.dart';
import 'package:ioasys_tdd/features/login/domain/entities/authenticated_user_entity.dart';
import 'package:ioasys_tdd/features/login/domain/repositories/authentication_repository.dart';

class AuthenticateUsecase implements UseCase<AuthenticatedUserEntity, Params> {
  final AuthenticationRepository repository;

  AuthenticateUsecase(this.repository);
  @override
  Future<Either<Failure, AuthenticatedUserEntity>> call(Params params) async {
    return await repository.authenticate(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
