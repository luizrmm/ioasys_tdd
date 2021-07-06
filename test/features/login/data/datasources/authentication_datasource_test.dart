import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:ioasys_tdd/core/errors/exceptions.dart';
import 'package:ioasys_tdd/features/login/data/datasources/authentication_datasource.dart';
import 'package:ioasys_tdd/features/login/data/models/authenticated_user_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late AuthenticationDataSourceImpl datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = AuthenticationDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(
      Uri.parse('https://empresas.ioasys.com.br/api/v1/users/auth/sign_in'),
    );
  });
  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient.post(any(),
            headers: any(named: 'headers'), body: any(named: 'body')))
        .thenAnswer(
            (_) async => Response(fixture('authenticated_user.json'), 200));
  }

  group('AuthenticateUser', () {
    final String tEmail = 'testeapple@ioasys.com.br';
    final String tPassword = '12341234';

    final tAuthenticatedUserModel = AuthenticatedUserModel.fromJson(
        jsonDecode(fixture('authenticated_user.json')));
    test(
        'should perform a post resquest on a url with the credentials to endpoint',
        () {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      datasource.authenticate(tEmail, tPassword);
      // assert
      verify(
        () => mockHttpClient.post(
          Uri.parse('https://empresas.ioasys.com.br/api/v1/users/auth/sign_in'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {"email": "testeapple@ioasys.com.br", "password": "12341234"}),
        ),
      );
    });

    test(
        'should return a AuthenticatedUser when the response code is 200(success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.authenticate(tEmail, tPassword);
      print(result.toJson());
      // assert
      expect(result, equals(tAuthenticatedUserModel));
    });
    test('should throw a AuthenticationException when request url fails',
        () async {
      // arrange
      when(() => mockHttpClient.post(any(),
              headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => Response('Something went wrong', 401));
      // act
      final call = datasource.authenticate;
      // assert
      expect(
        () => call(tEmail, tPassword),
        throwsA(isA<AuthenticationException>()),
      );
    });
  });
}
