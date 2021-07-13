import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ioasys_tdd/features/companies/data/models/enterprise_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  List<EnterpriseModel> enterprises = [
    EnterpriseModel(
      id: 1,
      emailEnterprise: '',
      facebook: '',
      twitter: '',
      linkedin: '',
      phone: '',
      ownEnterprise: false,
      enterpriseName: "Fluoretiq Limited",
      photo: "/uploads/enterprise/photo/1/240.jpeg",
      description:
          "FluoretiQ is a Bristol based medtech start-up developing diagnostic technology to enable bacteria identification within the average consultation window, so that patients can get the right anti-biotics from the start.  ",
      city: "Bristol",
      country: "UK",
      value: 0,
      sharePrice: 5000.0,
      enterpriseType: EnterpriseTypeModel(
        id: 3,
        enterpriseTypeName: "Health",
      ),
      ownShares: 0,
      shares: 0,
    ),
    EnterpriseModel(
      id: 2,
      emailEnterprise: '',
      facebook: '',
      twitter: '',
      linkedin: '',
      phone: '',
      ownEnterprise: false,
      enterpriseName: "Little Bee Community",
      photo: "/uploads/enterprise/photo/2/240.png",
      description: "Service and Product Design, Responsible Business",
      city: "London",
      country: "UK",
      value: 0,
      sharePrice: 5000.0,
      ownShares: 0,
      shares: 0,
      enterpriseType: EnterpriseTypeModel(
        enterpriseTypeName: 'Service',
        id: 12,
      ),
    )
  ];

  group('GetAll Enterprises', () {
    test('should be a list of EnterpriseModel', () {
      //assert
      expect(enterprises, isA<List<EnterpriseModel>>());
    });

    test('should return a valid model when the json is a enterprise', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('enterprises.json'));
      final enterprisesList = jsonMap['enterprises'] as List;

      //actual
      final result = enterprisesList
          .map((enterprise) => EnterpriseModel.fromJson(enterprise))
          .toList();

      //assert
      expect(result, enterprises);
    });
  });

  // todo: test to json
}
