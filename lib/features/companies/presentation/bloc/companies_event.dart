part of 'companies_bloc.dart';

abstract class CompaniesEvent extends Equatable {
  const CompaniesEvent();

  @override
  List<Object> get props => [];
}

class GetAllEnterprisesEvent extends CompaniesEvent {
  const GetAllEnterprisesEvent();

  @override
  List<Object> get props => [];
}
