import 'package:equatable/equatable.dart';

class EnterpriseEntity extends Equatable {
  final int id;
  final String enterpriseName;
  final String description;
  final String emailEnterprise;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String phone;
  final bool ownEnterprise;
  final String photo;
  final num value;
  final int shares;
  final num sharePrice;
  final int ownShares;
  final String city;
  final String country;
  final EnterpriseType enterpriseType;

  EnterpriseEntity({
    required this.id,
    required this.enterpriseName,
    required this.description,
    required this.emailEnterprise,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.phone,
    required this.ownEnterprise,
    required this.photo,
    required this.value,
    required this.shares,
    required this.sharePrice,
    required this.ownShares,
    required this.city,
    required this.country,
    required this.enterpriseType,
  });

  @override
  List<Object?> get props => [
        id,
        enterpriseName,
        description,
        emailEnterprise,
        facebook,
        twitter,
        linkedin,
        phone,
        ownEnterprise,
        photo,
        value,
        shares,
        sharePrice,
        ownShares,
        city,
        country,
        enterpriseType,
      ];
}

class EnterpriseType extends Equatable {
  final int id;
  final String enterpriseTypeName;

  EnterpriseType({required this.id, required this.enterpriseTypeName});

  @override
  List<Object?> get props => [id, enterpriseTypeName];
}
