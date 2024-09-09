import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

import 'package:flutter_rate_products/core/error/failures.dart';

abstract interface class AuthRepository {

  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String username,
    required String email,
    required String password
  });

  Future<Either<Failure, UserEntity>> logInWithEmailPassword({
    required String email,
    required String password
  });

  Future<Either<Failure, Unit>> createUserCollection({
    required String email,
    required String username
  });

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, Unit>> signOutUser();

}