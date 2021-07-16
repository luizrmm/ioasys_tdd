part of 'companies_bloc.dart';

abstract class CompaniesState extends Equatable {
  const CompaniesState();

  @override
  List<Object> get props => [];
}

class CompaniesInitial extends CompaniesState {
  const CompaniesInitial();
  @override
  List<Object> get props => [];
}

class CompaniesLoading extends CompaniesState {
  const CompaniesLoading();
  @override
  List<Object> get props => [];
}

class CompaniesLoaded extends CompaniesState {
  final List<EnterpriseEntity> enterprises;

  CompaniesLoaded({required this.enterprises});

  @override
  List<Object> get props => [enterprises];
}

class CompaniesError extends CompaniesState {
  final String message;

  CompaniesError({required this.message});
  @override
  List<Object> get props => [message];
}
