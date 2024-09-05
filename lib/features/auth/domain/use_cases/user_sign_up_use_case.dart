import 'package:flutter_rate_products/core/error/failures.dart';
import 'package:flutter_rate_products/core/use_cases/use_case.dart';
import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';
import 'package:flutter_rate_products/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<UserEntity, UserSignUpParams> {

  final AuthRepository authRepository;
  UserSignUp({required this.authRepository});
  
  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async {
      return await authRepository.signUpWithEmailPassword(
        username: params.username, 
        email: params.email, 
        password: params.password
      );
  }
  

}

class UserSignUpParams {

  final String email;
  final String password;
  final String username;

  UserSignUpParams({
    required this.email, 
    required this.password, 
    required this.username}
  );

}