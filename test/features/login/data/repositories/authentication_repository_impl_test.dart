import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/core/errors/exceptions.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/login/data/datasources/authentication_datasource.dart';
import 'package:ioasys_tdd/features/login/data/models/authenticated_user_model.dart';
import 'package:ioasys_tdd/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationDataSource extends Mock
    implements AuthenticationDataSource {}

void main() {
  late MockAuthenticationDataSource mockAuthenticationDataSource;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    mockAuthenticationDataSource = MockAuthenticationDataSource();
    repositoryImpl =
        AuthenticationRepositoryImpl(datasource: mockAuthenticationDataSource);
  });

  final int tId = 1;
  final String tInvestorName = 'test name';
  final String tEmail = 'test@test.com';
  final String tPassword = 'testpassword';
  final String tCity = 'testecity';
  final String tCountry = 'tCountry';
  final num tBalance = 1000.0;

  final authenticatedUserModel = AuthenticatedUserModel(
    id: tId,
    investorName: tInvestorName,
    email: tEmail,
    city: tCity,
    country: tCountry,
    balance: tBalance,
  );

  group('Authenticate', () {
    test(
        "should return remote data when the call to remote data source is successful",
        () async {
      //arrange
      when(() => mockAuthenticationDataSource.authenticate(any(), any()))
          .thenAnswer((_) async => authenticatedUserModel);

      // actual
      final result = await repositoryImpl.authenticate(tEmail, tPassword);

      //assert
      verify(
          () => mockAuthenticationDataSource.authenticate(tEmail, tPassword));
      expect(result, equals(Right(authenticatedUserModel)));
      verifyNoMoreInteractions(mockAuthenticationDataSource);
    });
  });

  test(
      'should throw a Authentication Failure when the call to remote data source is unuccessful',
      () async {
    //arrange
    when(() => mockAuthenticationDataSource.authenticate(any(), any()))
        .thenThrow(AuthenticationException());

    // actual
    final result = await repositoryImpl.authenticate(tEmail, tPassword);

    // assert
    verify(() => mockAuthenticationDataSource.authenticate(tEmail, tPassword));
    expect(result, equals(Left(AuthenticationFailure())));
    verifyNoMoreInteractions(mockAuthenticationDataSource);
  });
}
