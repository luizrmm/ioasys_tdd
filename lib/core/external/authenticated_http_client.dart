import 'package:http/http.dart' as http;
import 'package:ioasys_tdd/core/data/models/auth_headers_model.dart';
import 'package:ioasys_tdd/core/external/headers_local_manager.dart';

class AuthenticatedHttpClient extends http.BaseClient {
  final AuthHeadersManager headersManager;

  AuthenticatedHttpClient({required this.headersManager});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final AuthHeadersModel headersModel =
        headersManager.loadHeadersFromStorage();
    request.headers.addAll({'uid': headersModel.uid});
    request.headers.addAll({'client': headersModel.client});
    request.headers.addAll({'access-token': headersModel.accessToken});
    return request.send();
  }
}
