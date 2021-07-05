import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/features/login/domain/entities/authenticated_user_entity.dart';
import 'package:ioasys_tdd/features/login/domain/repositories/authentication_repository.dart';
import 'package:ioasys_tdd/features/login/domain/usecases/authenticate_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticateUsecase usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = AuthenticateUsecase(mockAuthenticationRepository);
  });

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

  test('should return a authenticated user from the respository', () async {
    // arrange
    when(() => mockAuthenticationRepository.authenticate(any(), any()))
        .thenAnswer((_) async => Right(authenticatedUser));

    // action
    final result = await usecase(Params(email: tEmail, password: tPassword));

    // assert
    expect(result, Right(authenticatedUser));
    verify(() => mockAuthenticationRepository.authenticate(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
