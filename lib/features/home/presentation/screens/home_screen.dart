import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rate_products/core/shared/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_rate_products/features/auth/presentation/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if(state is AppUserInitial){
          context.goNamed('selector');
        }
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: Shimmer.fromColors(
                    baseColor: Colors.green,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: const LoadingContainer(
                      height: 130,
                    )),
              );
            } else if (state is AuthSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          minRadius: 30,
                          maxRadius: 45,
                          //radius: 145,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/premium-photo/3d-avatar-cartoon-character_113255-91638.jpg'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Hola!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(color: Colors.green),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      state.user.username,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge,
                                    ),
                                  ],
                                ),
                                Text(state.user.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FilledButton(
                                          onPressed: () {
                                            context
                                                .read<AuthBloc>()
                                                .add(AuthSignOut());
                                          },
                                          child: const Text('Cerrar Sesión')),
                                    ])
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Column(
                children: [
                  /*FilledButton(onPressed: (){
                      context.pushReplacement('/');
                    }, 
                    child: const Text('reintentar')),*/
                  Text(
                    'Ocurrió un Error...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
