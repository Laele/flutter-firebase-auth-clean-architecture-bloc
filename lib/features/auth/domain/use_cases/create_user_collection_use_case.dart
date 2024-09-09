import 'package:flutter_rate_products/core/error/failures.dart';
import 'package:flutter_rate_products/core/use_cases/use_case.dart';
import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';
import 'package:flutter_rate_products/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateUserCollection implements UseCase<Unit, CreateUserCollectionParams> {

  final AuthRepository authRepository;
  CreateUserCollection ({required this.authRepository});
  
  @override
  Future<Either<Failure, Unit>> call(CreateUserCollectionParams params) async {
      return await authRepository.createUserCollection(
        username: params.username, 
        email: params.email, 
      );
  }
}

class CreateUserCollectionParams {

  final String email;
  final String username;

  CreateUserCollectionParams({
    required this.email, 
    required this.username}
  );

}