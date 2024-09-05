import 'package:flutter_rate_products/core/error/failures.dart';
import 'package:flutter_rate_products/core/use_cases/use_case.dart';
import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';
import 'package:flutter_rate_products/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<UserEntity, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(UserLoginParams params) async {
    return authRepository.logInWithEmailPassword(
      email: params.email, 
      password: params.password
    );
  }
  
}

class UserLoginParams {
   final String email;
   final String password;

  UserLoginParams({required this.email, required this.password});
}