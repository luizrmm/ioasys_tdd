import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationFailure extends Failure {}

class GetAllEnterpriseFailure extends Failure {}
