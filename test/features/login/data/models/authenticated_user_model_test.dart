import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/features/login/data/models/authenticated_user_model.dart';
import 'package:ioasys_tdd/features/login/domain/entities/authenticated_user_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tAuthenticatedModel = AuthenticatedUserModel(
    id: 1,
    investorName: 'test name',
    email: 'test@email.com',
    city: "testcity",
    country: "testcountry",
    balance: 1000.0,
  );

  test('should be a subclass of AuthenticatedUser Entity', () {
    // assert
    expect(tAuthenticatedModel, isA<AuthenticatedUserEntity>());
  });
  group('fromJson', () {
    test('should return a valid model when the json is a user', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('authenticated_user.json'));
      // act
      final result = AuthenticatedUserModel.fromJson(jsonMap);
      // assert
      expect(result, tAuthenticatedModel);
    });
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () {
        // act
        final result = tAuthenticatedModel.toJson();
        // assert
        final expectedMap = {
          "id": 1,
          "investor_name": 'test name',
          "email": 'test@email.com',
          "city": "testcity",
          "country": "testcountry",
          "balance": 1000.0
        };
        expect(result, expectedMap);
      },
    );
  });
}
