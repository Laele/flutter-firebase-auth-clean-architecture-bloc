import 'package:flutter_rate_products/core/error/failures.dart';
import 'package:flutter_rate_products/core/use_cases/use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements UseCase<Unit, NoParams> {

  final AuthRepository authRepository;
  UserSignOut({required this.authRepository});
  
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await authRepository.signOutUser();
  }
  
}