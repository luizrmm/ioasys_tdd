import 'dart:convert';

import 'package:ioasys_tdd/core/errors/exceptions.dart';
import 'package:ioasys_tdd/core/external/headers_local_manager.dart';
import 'package:ioasys_tdd/features/login/data/models/authenticated_user_model.dart';
import 'package:http/http.dart' show Client;

abstract class AuthenticationDataSource {
  /// calls the authentication endpoint
  ///
  /// throws a [ServerException] for all error codes.
  Future<AuthenticatedUserModel> authenticate(String email, String password);
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final Client client;
  final AuthHeadersManager headersManager;

  AuthenticationDataSourceImpl(
      {required this.client, required this.headersManager});

  @override
  Future<AuthenticatedUserModel> authenticate(
      String email, String password) async {
    final response = await client.post(
      Uri.parse('https://empresas.ioasys.com.br/api/v1/users/auth/sign_in'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      await headersManager.saveHeaders(response.headers);
      return AuthenticatedUserModel.fromJson(jsonDecode(response.body));
    } else {
      throw AuthenticationException();
    }
  }
}
