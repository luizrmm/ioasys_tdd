import 'package:ioasys_tdd/features/companies/domain/entities/enterprise_entity.dart';

class EnterpriseModel extends EnterpriseEntity {
  EnterpriseModel({
    required int id,
    required String enterpriseName,
    required String description,
    required String emailEnterprise,
    required String facebook,
    required String twitter,
    required String linkedin,
    required String phone,
    required bool ownEnterprise,
    required String photo,
    required num value,
    required int shares,
    required num sharePrice,
    required int ownShares,
    required String city,
    required String country,
    required EnterpriseType enterpriseType,
  }) : super(
          id: id,
          enterpriseName: enterpriseName,
          description: description,
          emailEnterprise: emailEnterprise,
          facebook: facebook,
          twitter: twitter,
          linkedin: linkedin,
          phone: phone,
          ownEnterprise: ownEnterprise,
          photo: photo,
          value: value,
          shares: shares,
          sharePrice: sharePrice,
          ownShares: ownShares,
          city: city,
          country: country,
          enterpriseType: enterpriseType,
        );

  factory EnterpriseModel.fromJson(Map<String, dynamic> json) {
    return EnterpriseModel(
      id: json['id'],
      enterpriseName: json['enterprise_name'],
      description: json['description'],
      emailEnterprise: json['email_enterprise'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      linkedin: json['linkedin'],
      phone: json['phone'],
      ownEnterprise: json['own_enterprise'],
      photo: json['photo'],
      value: json['value'],
      shares: json['shares'],
      sharePrice: json['share_price'],
      ownShares: json['own_shares'],
      city: json['city'],
      country: json['country'],
      enterpriseType: EnterpriseTypeModel.fromJson(json['enterprise_type']),
    );
  }

  Map<String, dynamic> toJson({EnterpriseTypeModel? enterpriseTypeModel}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enterprise_name'] = this.enterpriseName;
    data['description'] = this.description;
    data['email_enterprise'] = this.emailEnterprise;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['phone'] = this.phone;
    data['own_enterprise'] = this.ownEnterprise;
    data['photo'] = this.photo;
    data['value'] = this.value;
    data['shares'] = this.shares;
    data['share_price'] = this.sharePrice;
    data['own_shares'] = this.ownShares;
    data['city'] = this.city;
    data['country'] = this.country;
    data['enterprise_type'] = enterpriseTypeModel!.toJson();
    return data;
  }
}

class EnterpriseTypeModel extends EnterpriseType {
  EnterpriseTypeModel({
    required int id,
    required String enterpriseTypeName,
  }) : super(
          id: id,
          enterpriseTypeName: enterpriseTypeName,
        );
  factory EnterpriseTypeModel.fromJson(Map<String, dynamic> json) {
    return EnterpriseTypeModel(
      id: json['id'],
      enterpriseTypeName: json['enterprise_type_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enterprise_type_name'] = this.enterpriseTypeName;
    return data;
  }
}
