import 'package:ioasys_tdd/features/login/domain/entities/authenticated_user_entity.dart';

class AuthenticatedUserModel extends AuthenticatedUserEntity {
  AuthenticatedUserModel(
      {required int id,
      required String investorName,
      required String email,
      required String city,
      required String country,
      required num balance})
      : super(
          id: id,
          investorName: investorName,
          email: email,
          city: city,
          country: country,
          balance: balance,
        );
  factory AuthenticatedUserModel.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUserModel(
        id: json['investor']['id'],
        investorName: json['investor']['investor_name'],
        email: json['investor']['email'],
        city: json['investor']['city'],
        country: json['investor']['country'],
        balance: json['investor']['balance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['investor_name'] = this.investorName;
    data['email'] = this.email;
    data['city'] = this.city;
    data['country'] = this.country;
    data['balance'] = this.balance;
    return data;
  }
}
