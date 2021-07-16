import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/companies/domain/entities/enterprise_entity.dart';
import 'package:ioasys_tdd/features/companies/domain/usecases/get_all_enterprises_usecase.dart';
import 'package:ioasys_tdd/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllEnterprisesUseCase extends Mock
    implements GetAllEnterprisesUsecase {}

void main() {
  late MockGetAllEnterprisesUseCase mockUseCase;
  setUp(() {
    mockUseCase = MockGetAllEnterprisesUseCase();
    registerFallbackValue(NoParams());
  });

  test('the initial state should be a CompaniesInitial state', () {
    // arrange
    final bloc = CompaniesBloc(allEnterprisesUsecase: mockUseCase);

    //assert
    expect(bloc.state, isA<CompaniesInitial>());
    bloc.close();
  });

  group('Get all enterprises', () {
    List<EnterpriseEntity> enterprises = [
      EnterpriseEntity(
        id: 1,
        emailEnterprise: 'teste@teste.com',
        facebook: 'teste_facebook',
        twitter: 'teste_twitter',
        linkedin: 'teste_linkedin',
        phone: '11 2222-2222',
        ownEnterprise: false,
        enterpriseName: "Fluoretiq Limited",
        photo: "/uploads/enterprise/photo/1/240.jpeg",
        description:
            "FluoretiQ is a Bristol based medtech start-up developing diagnostic technology to enable bacteria identification within the average consultation window, so that patients can get the right anti-biotics from the start.  ",
        city: "Bristol",
        country: "UK",
        value: 0,
        sharePrice: 5000.0,
        ownShares: 0,
        shares: 0,
        enterpriseType: EnterpriseType(enterpriseTypeName: 'Health', id: 3),
      )
    ];

    blocTest(
      'should emit [loading, loaded] from get all enterprises use case',
      build: () {
        when(() => mockUseCase(any()))
            .thenAnswer((_) async => Right(enterprises));
        return CompaniesBloc(allEnterprisesUsecase: mockUseCase);
      },
      act: (CompaniesBloc bloc) => bloc.add(GetAllEnterprisesEvent()),
      expect: () => [
        CompaniesLoading(),
        CompaniesLoaded(enterprises: enterprises),
      ],
    );

    blocTest(
      'should emit [loading, error] from authenticate use case',
      build: () {
        when(() => mockUseCase(any()))
            .thenAnswer((_) async => Left(GetAllEnterpriseFailure()));
        return CompaniesBloc(allEnterprisesUsecase: mockUseCase);
      },
      act: (CompaniesBloc bloc) => bloc.add(GetAllEnterprisesEvent()),
      expect: () => [
        CompaniesLoading(),
        CompaniesError(message: ERROR_GET_ALL_ENTERPRISES),
      ],
    );
  });
}
