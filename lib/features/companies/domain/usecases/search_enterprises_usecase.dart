import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/core/usecases/usecase.dart';
import 'package:ioasys_tdd/features/companies/domain/entities/enterprise_entity.dart';
import 'package:ioasys_tdd/features/companies/domain/repositories/enterprise_repository.dart';

class SearchEnterprisesUseCase
    implements UseCase<List<EnterpriseEntity>, Params> {
  final EnterpriseRespository respository;

  SearchEnterprisesUseCase(this.respository);

  @override
  Future<Either<Failure, List<EnterpriseEntity>>> call(Params params) async {
    return await this.respository.searchEnterprise(params.enterpriseName);
  }
}

class Params extends Equatable {
  final String enterpriseName;

  Params({required this.enterpriseName});

  @override
  List<Object?> get props => [enterpriseName];
}
