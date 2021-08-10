import 'package:ioasys_tdd/features/companies/data/datasource/enterprise_datasource.dart';
import 'package:ioasys_tdd/features/companies/domain/entities/enterprise_entity.dart';
import 'package:ioasys_tdd/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ioasys_tdd/features/companies/domain/repositories/enterprise_repository.dart';

class EnterpriseRepositoryImpl implements EnterpriseRespository {
  final EnterpriseDataSource datasource;

  EnterpriseRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, List<EnterpriseEntity>>> getAll() async {
    try {
      final enterprises = await this.datasource.getAll();
      return Right(enterprises);
    } catch (e) {
      return Left(GetAllEnterpriseFailure());
    }
  }

  @override
  Future<Either<Failure, List<EnterpriseEntity>>> searchEnterprise(
      String enterpriseName) async {
    try {
      final filteredEnterprises =
          await this.datasource.searchEnterprises(enterpriseName);
      return Right(filteredEnterprises);
    } catch (e) {
      return Left(SearchEnterpriseFailure());
    }
  }
}
