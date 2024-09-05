import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_rate_products/core/shared/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:flutter_rate_products/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:flutter_rate_products/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_rate_products/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/create_user_collection_use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/get_current_user_use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/user_login_use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/user_sign_out_use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/user_sign_up_use_case.dart';
import 'package:flutter_rate_products/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_rate_products/firebase_options.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;


Future<void> init_dependencies() async {
  _initAuth();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  serviceLocator.registerLazySingleton(() => firebaseInstance);
  serviceLocator.registerLazySingleton(() => firestoreInstance);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // Data Sources
  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl( serviceLocator(), serviceLocator()));
  
  // Repositories
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl( remoteDataSource: serviceLocator() ));

  // Use Cases
  serviceLocator.registerFactory(() => UserSignUp( authRepository: serviceLocator()) );
  serviceLocator.registerFactory(() => CreateUserCollection( authRepository: serviceLocator()) );
  serviceLocator.registerFactory(() => UserLogin(authRepository:  serviceLocator()) );
  serviceLocator.registerFactory(() => GetCurrentUser(authRepository: serviceLocator()) );
  serviceLocator.registerFactory(() => UserSignOut(authRepository: serviceLocator()) );
  // Blocs
  serviceLocator.registerLazySingleton(() => AuthBloc( 
    userSignUp: serviceLocator(), 
    createUserCollection: serviceLocator(), 
    userLogin: serviceLocator(),
    getCurrentUser: serviceLocator(), 
    appUserCubit: serviceLocator(), 
    userSignOut: serviceLocator(), 
    ),
  );
}
