import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/login/domain/entities/authenticated_user_entity.dart';
import 'package:ioasys_tdd/features/login/domain/usecases/authenticate_usecase.dart';
import 'package:ioasys_tdd/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticateUseCase extends Mock implements AuthenticateUsecase {}

void main() {
  late MockAuthenticateUseCase mockAuthenticateUseCase;

  setUp(() {
    mockAuthenticateUseCase = MockAuthenticateUseCase();
    registerFallbackValue(
        Params(email: 'test@test.com', password: 'testpassword'));
  });

  test('initialState should be AuthenticationInitial', () {
    //arrange
    final bloc =
        AuthenticationBloc(authenticateUsecase: mockAuthenticateUseCase);
    // assert
    expect(bloc.state, equals(AuthenticationInitial()));
    bloc.close();
  });

  group('Authenticate User', () {
    final int tId = 1;
    final String tInvestorName = 'test name';
    final String tEmail = 'test@test.com';
    final String tPassword = 'testpassword';
    final String tCity = 'testecity';
    final String tCountry = 'tCountry';
    final num tBalance = 1000.0;

    final authenticatedUser = AuthenticatedUserEntity(
      id: tId,
      investorName: tInvestorName,
      email: tEmail,
      city: tCity,
      country: tCountry,
      balance: tBalance,
    );

    blocTest(
      'should emit [loading, loaded] from authenticate use case',
      build: () {
        when(() => mockAuthenticateUseCase(any()))
            .thenAnswer((_) async => Right(authenticatedUser));
        return AuthenticationBloc(authenticateUsecase: mockAuthenticateUseCase);
      },
      act: (AuthenticationBloc bloc) =>
          bloc.add(Authenticate(tEmail, tPassword)),
      expect: () => [
        AuthenticationLoading(),
        AuthenticationLoaded(authenticatedUser: authenticatedUser),
      ],
    );
    blocTest(
      'should emit [loading, error] from authenticate use case',
      build: () {
        when(() => mockAuthenticateUseCase(any()))
            .thenAnswer((_) async => Left(AuthenticationFailure()));
        return AuthenticationBloc(authenticateUsecase: mockAuthenticateUseCase);
      },
      act: (AuthenticationBloc bloc) =>
          bloc.add(Authenticate('test@email', 'testPass')),
      expect: () => [
        AuthenticationLoading(),
        AuthenticationError(message: AUTHENTICATION_FAILURE_MESSAGE),
      ],
    );
  });
}
