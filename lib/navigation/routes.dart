import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_rate_products/core/shared/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:flutter_rate_products/features/auth/presentation/auth_screens.dart';
import 'package:flutter_rate_products/features/home/presentation/home_screens.dart';

final router = GoRouter(
  routes: [

    //GoRoute(path: '/', builder: (context, state) => const SignInScreen()),
    GoRoute(path: '/', builder: (context, state) {
      return BlocSelector<AppUserCubit,AppUserState,bool>(
        selector: (state){
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn){
          if(isLoggedIn){
            return const HomeScreen();
          }
          return const SignInScreen();
        }
      );
      }
    ),
    
    GoRoute(path: '/sign-up', //builder: (context, state) => const SignUpScreen(), 
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const SignUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child, 
            );
          },
        );
      },
    ),

  ]
);