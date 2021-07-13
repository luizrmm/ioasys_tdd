import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String CACHED_HEADERS = 'auth_headers';

class AuthenticatedHttpClient extends http.BaseClient {
  final SharedPreferences localStorage;

  AuthenticatedHttpClient({required this.localStorage});

  Map<String, String> _headers = {};

  Map<String, String> get headers {
    if (headers.isNotEmpty) return _headers;
    _headers = _loadHeadersFromStorage();
    return headers;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (headers.isNotEmpty) {
      request.headers.addAll(headers);
    }
    return request.send();
  }

  Map<String, String> _loadHeadersFromStorage() {
    Map<String, String> accessHeaders = new Map<String, String>();
    String? cachedHeaders = localStorage.getString(CACHED_HEADERS);

    if (cachedHeaders != null) {
      accessHeaders = jsonDecode(cachedHeaders);
    }
    return accessHeaders;
  }

  void reset() {
    _headers = new Map<String, String>();
  }
}
