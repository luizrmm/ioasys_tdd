import 'package:equatable/equatable.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ioasys_tdd/core/usecases/usecase.dart';
import 'package:ioasys_tdd/features/companies/domain/entities/enterprise_entity.dart';
import 'package:ioasys_tdd/features/companies/domain/repositories/enterprise_repository.dart';

class GetAllEnterprisesUsecase
    implements UseCase<List<EnterpriseEntity>, NoParams> {
  final EnterpriseRespository respository;

  GetAllEnterprisesUsecase(this.respository);
  @override
  Future<Either<Failure, List<EnterpriseEntity>>> call(NoParams params) async {
    return await this.respository.getAll();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
