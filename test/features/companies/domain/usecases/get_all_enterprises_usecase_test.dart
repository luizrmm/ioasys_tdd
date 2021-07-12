import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/companies/domain/entities/enterprise_entity.dart';
import 'package:ioasys_tdd/features/companies/domain/repositories/enterprise_repository.dart';
import 'package:ioasys_tdd/features/companies/domain/usecases/get_all_enterprises_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockEnterpriseRepository extends Mock implements EnterpriseRespository {}

void main() {
  late GetAllEnterprisesUsecase usecase;
  late MockEnterpriseRepository mockRepository;

  setUp(() {
    mockRepository = MockEnterpriseRepository();
    usecase = GetAllEnterprisesUsecase(mockRepository);
  });

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

  test(
      "shoud return a list enterprises when the call to repository is successful",
      () async {
    //arrange
    when(() => mockRepository.getAll())
        .thenAnswer((invocation) async => Right(enterprises));

    //actual
    final result = await usecase(NoParams());

    //assert
    expect(result, equals(Right(enterprises)));
    verify(() => mockRepository.getAll());
    verifyNoMoreInteractions(mockRepository);
  });

  test(
      'shold be return a [GetAllEnterpriseFailure] when the call to repository fails',
      () async {
    //arrange
    when(() => mockRepository.getAll())
        .thenAnswer((invocation) async => Left(GetAllEnterpriseFailure()));

    //actual
    final result = await usecase(NoParams());

    //assert
    expect(result, equals(Left(GetAllEnterpriseFailure())));
    verify(() => mockRepository.getAll());
    verifyNoMoreInteractions(mockRepository);
  });
}
