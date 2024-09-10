import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rate_products/core/shared/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:flutter_rate_products/core/use_cases/use_case.dart';
import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';

import 'package:flutter_rate_products/features/auth/domain/use_cases/create_user_collection_use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/get_current_user_use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/user_login_use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/user_sign_out_use_case.dart';
import 'package:flutter_rate_products/features/auth/domain/use_cases/user_sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AppUserCubit _appUserCubit;

  // Use Cases
  final UserSignUp _userSignUp;
  final UserSignOut _userSignOut;
  final UserLogin _userLogin;
  final CreateUserCollection _createUserCollection;
  final GetCurrentUser _getCurrentUser;


  AuthBloc({
    required AppUserCubit appUserCubit,
    required GetCurrentUser getCurrentUser,
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required UserSignOut userSignOut,
    required CreateUserCollection createUserCollection,
  }) : _userSignUp = userSignUp,
    _userSignOut = userSignOut,
    _createUserCollection = createUserCollection,
    _userLogin = userLogin,
    _getCurrentUser = getCurrentUser,
    _appUserCubit = appUserCubit,
    super(AuthInitial()) {

    // on Events
    on<AuthSignUp>(_authSignUp);
    on<AuthSignOut>(_authSignOut);
    on<AuthLogin>(_authLogin);
    on<AuthIsUserLoggedIn>(_authIsUserLoggedIn);

  }

  FutureOr<void> _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userSignUp(
       UserSignUpParams(
        email: event.email, 
        password: event.password, 
        username: event.username
      ));

      await res.fold(
        (failure)  async => emit(AuthFailure(message: failure.message)), 
        (user)  async {
          _emitAuthSucces(user, emit);
          await _createUserCollectionBloc(event, emit, user);
        }
          
      );
  }

  FutureOr<void> _createUserCollectionBloc(AuthSignUp event, Emitter<AuthState> emit, UserEntity user) async {
    final res2 = await _createUserCollection(
      CreateUserCollectionParams(
        email: event.email, 
        username: event.username
      )
    ); 

    res2.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (success) => _emitAuthSucces(user, emit)
    );
  }

  FutureOr<void> _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userLogin(UserLoginParams(
      email: event.email, 
      password: event.password)
    );

    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (success) => _emitAuthSucces(success, emit),
    );
  }

  FutureOr<void> _authIsUserLoggedIn(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _getCurrentUser(NoParams());
    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (success) => _emitAuthSucces(success, emit)
    );
  }
 
  FutureOr<void> _authSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    final res = await _userSignOut(NoParams());
    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (success) => _appUserCubit.updateUser(null)
    );
  }

  void _emitAuthSucces(UserEntity user, Emitter<AuthState> emit,) {
    print(user.email);
    print(user.username);
    print(user.uid);
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }

}
