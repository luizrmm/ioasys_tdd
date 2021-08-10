import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/core/external/authenticated_http_client.dart';
import 'package:ioasys_tdd/core/errors/exceptions.dart';

import 'package:ioasys_tdd/features/companies/data/datasource/enterprise_datasource.dart';
import 'package:ioasys_tdd/features/companies/data/models/enterprise_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' show Response;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements AuthenticatedHttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late EnterpriseDataSourceImpl datasource;
  final String enterpriseName = 'teste';

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = EnterpriseDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(
      Uri.parse('https://empresas.ioasys.com.br/api/v1/enterprises'),
    );
    registerFallbackValue(Uri.parse(
        'https://empresas.ioasys.com.br/api/v1/enterprises?name=$enterpriseName'));
  });

  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => Response(fixture('enterprises.json'), 200));
  }

  group('GetAllEnterprises', () {
    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('enterprises.json'));
    final enterprisesList = jsonMap['enterprises'] as List;

    final tEnterprises = enterprisesList
        .map((enterprise) => EnterpriseModel.fromJson(enterprise))
        .toList();
    test('should perform a get request to get all enterprises to enterprises',
        () {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      datasource.getAll();
      // assert
      verify(
        () => mockHttpClient.get(
          Uri.parse('https://empresas.ioasys.com.br/api/v1/enterprises'),
        ),
      );
    });

    test('should return all enterprises when the response code is 200(success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.getAll();

      // assert
      expect(result, equals(tEnterprises));
    });
    test('should throw a GetAllEnterpriseException when request url fails',
        () async {
      // arrange
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response('Something went wrong', 401));
      // act
      final call = datasource.getAll;
      // assert
      expect(
        () => call(),
        throwsA(isA<GetAllEnterpriseException>()),
      );
    });
  });

  group('Search Enterprises', () {
    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('enterprises.json'));
    final enterprisesList = jsonMap['enterprises'] as List;

    final tEnterprises = enterprisesList
        .map((enterprise) => EnterpriseModel.fromJson(enterprise))
        .toList();
    final String tSearchedString = 'teste';

    test('should perform a get request with the searchedString', () {
      setUpMockHttpClientSuccess200();
      // act
      datasource.searchEnterprises(tSearchedString);
      // assert
      verify(
        () => mockHttpClient.get(
          Uri.parse(
              'https://empresas.ioasys.com.br/api/v1/enterprises?name=$enterpriseName'),
        ),
      );
    });

    test('should return enterprises searched when the response code is 200(OK)',
        () async {
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.searchEnterprises(enterpriseName);

      // assert
      expect(result, equals(tEnterprises));
    });

    test('should throw a SearchEnterprisesException when request url fails',
        () async {
      // arrange
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response('Something went wrong', 401));
      // act
      final call = datasource.searchEnterprises(enterpriseName);
      // assert
      expect(
        () => call,
        throwsA(isA<SearchEnterprisesException>()),
      );
    });
  });
}
