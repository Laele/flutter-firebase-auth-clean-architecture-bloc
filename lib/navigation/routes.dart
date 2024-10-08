import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_rate_products/core/shared/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:flutter_rate_products/features/auth/presentation/auth_screens.dart';
import 'package:flutter_rate_products/features/home/presentation/home_screens.dart';
import 'package:flutter_rate_products/features/selector/presentation/screens/selector_Screen.dart';

abstract class AppRouter {
  
  static final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final authState = context.read<AppUserCubit>().state;

      /*if(authState is AppUserInitial){
        return '/sign-in';
      }*/

      return null;
    },
    routes: [
      GoRoute(path: '/',name: 'selector' ,builder: (context, state) => const SelectorScreen()),    

      GoRoute(path: '/sign-in', name: 'sign-in',
      routes: [

        GoRoute(path: 'sign-up', name: 'sign-up',
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
          }
        ),   

      ],
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SignInScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child, 
              );
            },
          );
        }
      ),    
      
      /*GoRoute(path: '/sign-up', name: 'sign-up',
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
        }
      ), */ 
      
      GoRoute(path: '/home',name: 'home' ,builder: (context, state) => const HomeScreen()),    
    ]
  );

  final routerUser = GoRouter(
    initialLocation: '/home',

    routes: [

      GoRoute(path: '/home',name: 'home' ,builder: (context, state) => const HomeScreen()),    

    ]
  );
}