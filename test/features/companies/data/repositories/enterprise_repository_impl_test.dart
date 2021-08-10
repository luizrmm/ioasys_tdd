import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/core/errors/exceptions.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/companies/data/datasource/enterprise_datasource.dart';
import 'package:ioasys_tdd/features/companies/data/models/enterprise_model.dart';
import 'package:ioasys_tdd/features/companies/data/repositories/enterprise_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockEnterpriseDataSource extends Mock implements EnterpriseDataSource {}

void main() {
  late MockEnterpriseDataSource mockEnterpriseDataSource;
  late EnterpriseRepositoryImpl repositoryImpl;

  setUp(() {
    mockEnterpriseDataSource = MockEnterpriseDataSource();
    repositoryImpl =
        EnterpriseRepositoryImpl(datasource: mockEnterpriseDataSource);
  });

  List<EnterpriseModel> enterprises = [
    EnterpriseModel(
      id: 1,
      emailEnterprise: '',
      facebook: '',
      twitter: '',
      linkedin: '',
      phone: '',
      ownEnterprise: false,
      enterpriseName: "Fluoretiq Limited",
      photo: "/uploads/enterprise/photo/1/240.jpeg",
      description:
          "FluoretiQ is a Bristol based medtech start-up developing diagnostic technology to enable bacteria identification within the average consultation window, so that patients can get the right anti-biotics from the start.  ",
      city: "Bristol",
      country: "UK",
      value: 0,
      sharePrice: 5000.0,
      enterpriseType: EnterpriseTypeModel(
        id: 3,
        enterpriseTypeName: "Health",
      ),
      ownShares: 0,
      shares: 0,
    ),
    EnterpriseModel(
      id: 2,
      emailEnterprise: '',
      facebook: '',
      twitter: '',
      linkedin: '',
      phone: '',
      ownEnterprise: false,
      enterpriseName: "Little Bee Community",
      photo: "/uploads/enterprise/photo/2/240.png",
      description: "Service and Product Design, Responsible Business",
      city: "London",
      country: "UK",
      value: 0,
      sharePrice: 5000.0,
      ownShares: 0,
      shares: 0,
      enterpriseType: EnterpriseTypeModel(
        enterpriseTypeName: 'Service',
        id: 12,
      ),
    )
  ];

  group('Get All Enterprises', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockEnterpriseDataSource.getAll())
          .thenAnswer((invocation) async => enterprises);

      // actual
      final result = await repositoryImpl.getAll();

      //assert
      verify(() => mockEnterpriseDataSource.getAll());
      expect(result, equals(Right(enterprises)));
      verifyNoMoreInteractions(mockEnterpriseDataSource);
    });

    test(
        'should return a GetAllEnterpriseFailure when the call to remote data source is unuccessful',
        () async {
      //arrange
      when(() => mockEnterpriseDataSource.getAll())
          .thenThrow(GetAllEnterpriseException());

      // actual
      final result = await repositoryImpl.getAll();

      // assert
      verify(() => mockEnterpriseDataSource.getAll());
      expect(result, equals(Left(GetAllEnterpriseFailure())));
      verifyNoMoreInteractions(mockEnterpriseDataSource);
    });
  });

  group('Search Enterprises', () {
    final String tEnterpriseName = "Little";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockEnterpriseDataSource.searchEnterprises(tEnterpriseName))
          .thenAnswer((invocation) async => enterprises);

      // actual
      final result = await repositoryImpl.searchEnterprise(tEnterpriseName);

      //assert
      verify(() => mockEnterpriseDataSource.searchEnterprises(tEnterpriseName));
      expect(result, equals(Right(enterprises)));
      verifyNoMoreInteractions(mockEnterpriseDataSource);
    });

    test(
        'should return a SearchEnterprisesFailure when the call to remote data source is unuccessful',
        () async {
      //arrange
      when(() => mockEnterpriseDataSource.searchEnterprises(tEnterpriseName))
          .thenThrow(SearchEnterprisesException());

      // actual
      final result = await repositoryImpl.searchEnterprise(tEnterpriseName);

      // assert
      verify(() => mockEnterpriseDataSource.searchEnterprises(tEnterpriseName));
      expect(result, equals(Left(SearchEnterpriseFailure())));
      verifyNoMoreInteractions(mockEnterpriseDataSource);
    });
  });
}
