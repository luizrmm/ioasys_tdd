import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/login/domain/entities/authenticated_user_entity.dart';
import 'package:ioasys_tdd/features/login/domain/usecases/authenticate_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

const String AUTHENTICATION_FAILURE_MESSAGE = 'Credenciais incorretas';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticateUsecase authenticateUsecase;
  AuthenticationBloc({required this.authenticateUsecase})
      : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    yield AuthenticationLoading();
    if (event is Authenticate) {
      final failureOrAuthenticatedUser = await authenticateUsecase(
          Params(email: event.email, password: event.password));
      yield* _eitherLoadedOrErrorState(failureOrAuthenticatedUser);
    }
  }

  Stream<AuthenticationState> _eitherLoadedOrErrorState(
    Either<Failure, AuthenticatedUserEntity> failureOrAuthenticatedUser,
  ) async* {
    yield failureOrAuthenticatedUser.fold(
        (Failure failure) => AuthenticationError(
              message: _mapFailureToMessage(failure),
            ),
        (AuthenticatedUserEntity authenticatedUser) =>
            AuthenticationLoaded(authenticatedUser: authenticatedUser));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case AuthenticationFailure:
        return AUTHENTICATION_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
