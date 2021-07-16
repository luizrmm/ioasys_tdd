import 'dart:convert';

import 'package:ioasys_tdd/core/errors/exceptions.dart';
import 'package:ioasys_tdd/data/authenticated_http_client.dart';
import 'package:ioasys_tdd/features/companies/data/models/enterprise_model.dart';

abstract class EnterpriseDataSource {
  /// calls the enterprises endpoint
  ///
  /// throws a [ServerException] for all error codes.
  Future<List<EnterpriseModel>> getAll();
}

class EnterpriseDataSourceImpl extends EnterpriseDataSource {
  final AuthenticatedHttpClient client;

  EnterpriseDataSourceImpl({required this.client});
  @override
  Future<List<EnterpriseModel>> getAll() async {
    final response = await client
        .get(Uri.parse('https://empresas.ioasys.com.br/api/v1/enterprises'));
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final enterprises = jsonMap['enterprises'] as List;
      return enterprises
          .map((enterprise) => EnterpriseModel.fromJson(enterprise))
          .toList();
    } else {
      throw GetAllEnterpriseException();
    }
  }
}
