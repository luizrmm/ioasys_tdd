part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();

  @override
  List<Object> get props => [];
}

class AuthenticationLoaded extends AuthenticationState {
  final AuthenticatedUserEntity authenticatedUser;

  const AuthenticationLoaded({required this.authenticatedUser});
  @override
  List<Object> get props => [authenticatedUser];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError({required this.message});
  @override
  List<Object> get props => [message];
}
