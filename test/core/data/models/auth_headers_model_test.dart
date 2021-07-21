import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/core/data/models/auth_headers_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final mockHeaders = AuthHeadersModel(
    uid: 'uid',
    client: 'client',
    accessToken: 'access-token',
  );

  group("AuthHeaders Model", () {
    test('should return a valid model when the json is a header', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('auth_headers.json'));
      print(jsonMap);
      // act
      final result = AuthHeadersModel.fromJson(jsonMap);
      // assert
      expect(result, mockHeaders);
    });

    test('should return a JSON map containing the proper data', () {
      // act
      final result = mockHeaders.toJson();
      // assert
      final expectedMap = {
        "uid": "uid",
        "client": "client",
        "access-token": "access-token"
      };
      expect(result, expectedMap);
    });
  });
}
