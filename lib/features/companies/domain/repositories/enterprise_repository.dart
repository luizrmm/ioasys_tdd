import 'package:dartz/dartz.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:ioasys_tdd/features/companies/domain/entities/enterprise_entity.dart';

abstract class EnterpriseRespository {
  Future<Either<Failure, List<EnterpriseEntity>>> getAll();
  Future<Either<Failure, List<EnterpriseEntity>>> searchEnterprise(
      String enterpriseName);
}
