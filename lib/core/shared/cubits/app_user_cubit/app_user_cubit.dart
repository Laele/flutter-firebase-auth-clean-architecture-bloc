import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(UserEntity? user) {
    if(user == null){
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
