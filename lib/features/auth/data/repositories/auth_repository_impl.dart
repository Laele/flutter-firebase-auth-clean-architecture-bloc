import 'package:flutter_rate_products/core/error/exceptions.dart';
import 'package:flutter_rate_products/core/error/failures.dart';
import 'package:flutter_rate_products/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';
import 'package:flutter_rate_products/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> logInWithEmailPassword({required String email, required String password}) async {
    try {
      final user = await remoteDataSource.logInWithEmailPassword(
        email: email, 
        password: password
      );

      return right(user);
    } on ServerException catch(e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({required String username, required String email, required String password}) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        username: username, 
        email: email, 
        password: password
      );

      return right(user);

    } on ServerException catch(e){ 
      return left(Failure(message: e.message));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> createUserCollection({required String email, required String username}) async {
    try {
      final user = await remoteDataSource.createUserCollection(email: email, username: username);
      
      if(user == null){
        return left(Failure(message: "User couldn't be added."));
      }
      return right(user);
    } on ServerException catch(e) {
      
      return left(Failure(message: e.message));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if(user == null){
        return left(Failure(message: 'User not logged in.'));
      }
      return right(user);
    } on ServerException catch(e) {
      return left(Failure(message: e.message));
    }
  }
  
  @override
  Future<Either<Failure, Unit>> signOutUser() async {
    try{
      await remoteDataSource.signOutUser();
      return right(unit);
    } on ServerException catch(e){
      return left(Failure(message: e.message));
    }
  } 


}