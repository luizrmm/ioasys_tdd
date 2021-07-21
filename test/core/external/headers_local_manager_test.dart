import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/core/data/models/auth_headers_model.dart';
import 'package:ioasys_tdd/core/external/headers_local_manager.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AuthHeadersManagerImpl authHeadersManager;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    authHeadersManager =
        AuthHeadersManagerImpl(sharedPreferences: mockSharedPreferences);
  });

  group('AuthHeadersManager', () {
    final tAuthHeaders =
        AuthHeadersModel.fromJson(jsonDecode(fixture('auth_headers.json')));
    test('should call to sharedPreferences to cache the data', () async {
      // arrange
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) => Future.value(true));
      final Map<String, String> tHeaders = {
        "uid": "uid",
        "client": "client",
        "access-token": "access-token"
      };

      // actual
      await authHeadersManager.saveHeaders(tHeaders);

      //assert
      verify(
        () => mockSharedPreferences.setString(
            CACHED_HEADERS, jsonEncode(tHeaders)),
      );
    });

    test("should return a AuthHeadersModel from the sharedPreferences", () {
      // arrange
      when(() => mockSharedPreferences.getString(CACHED_HEADERS))
          .thenReturn(fixture('auth_headers.json'));

      //actual
      final result = authHeadersManager.loadHeadersFromStorage();

      //assert
      verify(() => mockSharedPreferences.getString(CACHED_HEADERS));
      expect(result, equals(tAuthHeaders));
    });

    test('should remove data from sharedPreferences with the key passed', () {
      //arrange
      when(() => mockSharedPreferences.remove(any()))
          .thenAnswer((invocation) => Future.value(true));

      //actual
      authHeadersManager.clearHeaders();

      //assert
      verify(() => mockSharedPreferences.remove(CACHED_HEADERS));
    });
  });
}
