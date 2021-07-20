import 'dart:convert';

import 'package:ioasys_tdd/core/data/models/auth_headers_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthHeadersManager {
  AuthHeadersModel loadHeadersFromStorage();
  Future<void> saveHeaders(Map<String, String> headers);
  Future<void> clearHeaders();
}

const String CACHED_HEADERS = 'auth_headers';

class AuthHeadersManagerImpl implements AuthHeadersManager {
  final SharedPreferences sharedPreferences;

  AuthHeadersManagerImpl({required this.sharedPreferences});
  @override
  Future<void> clearHeaders() async {
    await sharedPreferences.remove(CACHED_HEADERS);
  }

  @override
  AuthHeadersModel loadHeadersFromStorage() {
    AuthHeadersModel authHeadersModel =
        new AuthHeadersModel(uid: '', client: '', accessToken: '');
    final String? headersCredentials =
        sharedPreferences.getString(CACHED_HEADERS);
    if (headersCredentials != null) {
      authHeadersModel = AuthHeadersModel.fromJson(
        jsonDecode(headersCredentials),
      );
    }
    return authHeadersModel;
  }

  @override
  Future<void> saveHeaders(Map<String, String> headers) async {
    Map<String, String> credentials = new Map();
    credentials = {
      "uid": headers['uid'] ?? '',
      "client": headers['client'] ?? '',
      "access-token": headers['access-token'] ?? ''
    };
    await sharedPreferences.setString(CACHED_HEADERS, jsonEncode(credentials));
  }
}
