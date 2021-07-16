import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/companies/domain/entities/enterprise_entity.dart';
import 'package:ioasys_tdd/features/companies/domain/usecases/get_all_enterprises_usecase.dart';

part 'companies_event.dart';
part 'companies_state.dart';

const String ERROR_GET_ALL_ENTERPRISES = 'Falha ao carregar empresas';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  GetAllEnterprisesUsecase allEnterprisesUsecase;
  CompaniesBloc({required this.allEnterprisesUsecase})
      : super(CompaniesInitial());

  @override
  Stream<CompaniesState> mapEventToState(
    CompaniesEvent event,
  ) async* {
    yield CompaniesLoading();
    if (event is GetAllEnterprisesEvent) {
      final failureOrEnterprises = await allEnterprisesUsecase(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrEnterprises);
    }
  }

  Stream<CompaniesState> _eitherLoadedOrErrorState(
      Either<Failure, List<EnterpriseEntity>> failureOrEnterprises) async* {
    yield failureOrEnterprises.fold(
        (Failure failure) => CompaniesError(
              message: _mapFailureToMessage(failure),
            ),
        (List<EnterpriseEntity> enterprises) =>
            CompaniesLoaded(enterprises: enterprises));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case GetAllEnterpriseFailure:
        return ERROR_GET_ALL_ENTERPRISES;
      default:
        return 'Unexpected error';
    }
  }
}
