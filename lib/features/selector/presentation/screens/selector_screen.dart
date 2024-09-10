import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rate_products/core/shared/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:go_router/go_router.dart';

class SelectorScreen extends StatelessWidget {
  const SelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        print(state.runtimeType);
        return state is AppUserLoggedIn;
      }, 
      builder: (context, isUserLoggedIn) {
        if(isUserLoggedIn) {
          context.go('/home');
        } else {
          context.push('/sign-in');
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}