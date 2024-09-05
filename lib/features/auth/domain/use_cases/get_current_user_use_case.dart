import 'package:flutter_rate_products/core/error/failures.dart';
import 'package:flutter_rate_products/core/use_cases/use_case.dart';
import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';
import 'package:flutter_rate_products/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements UseCase<UserEntity, NoParams> {

  final AuthRepository authRepository;
  GetCurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }

}

