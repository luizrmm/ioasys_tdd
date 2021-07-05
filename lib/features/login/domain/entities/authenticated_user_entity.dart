import 'package:equatable/equatable.dart';

class AuthenticatedUserEntity extends Equatable {
  final int id;
  final String investorName;
  final String email;
  final String city;
  final String country;
  final num balance;

  AuthenticatedUserEntity({
    required this.id,
    required this.investorName,
    required this.email,
    required this.city,
    required this.country,
    required this.balance,
  });

  @override
  List<Object?> get props => [id, investorName, email, city, country, balance];
}
