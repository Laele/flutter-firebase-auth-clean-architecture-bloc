import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rate_products/core/shared/widgets/loader.dart';
import 'package:flutter_rate_products/core/utils/show_snackbar.dart';
import 'package:flutter_rate_products/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:flutter_rate_products/features/auth/presentation/auth_widgets.dart';
import 'package:flutter_rate_products/core/theme/app_pallete.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  @override
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppPallete.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Registrate.',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          AuthUsernameField(
                            prefixIcon: const Icon(Icons.person),
                            hintText: 'Nombre de Usuario',
                            controller: usernameController,
                          ),
                          const SizedBox(height: 10),
                          AuthEmailField(
                            prefixIcon: const Icon(Icons.alternate_email),
                            hintText: 'Correo',
                            controller: emailController,
                          ),
                          const SizedBox(height: 10),
                          AuthPasswordField(
                            hintText: 'Contraseña',
                            controller: passwordController,
                            prefixIcon: const Icon(Icons.key),
                            passwordController: confirmPasswordController,
                          ),
                          const SizedBox(height: 10),
                          AuthPasswordField(
                            hintText: 'Confirmar Contraseña',
                            controller: confirmPasswordController,
                            prefixIcon: const Icon(Icons.key),
                            passwordController: passwordController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if(state is AuthFailure){
                            showSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                        
                          if(state is AuthLoading){
                            return AuthFilledButton(
                              onPressed: () { },
                              child: const Loader(),
                            );
                          }

                          return AuthFilledButton(
                            text: 'Registrar',
                            onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthSignUp(
                                email:    emailController.text.trim(), 
                                password: passwordController.text.trim(), 
                                username: usernameController.text.trim(),
                              ));
                            },
                          );
                        },

                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            context.goNamed('sign-in');
                          },
                          child: RichText(
                              text: TextSpan(
                                  text: '¿Ya tienes una cuenta?  ',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  children: [
                                TextSpan(
                                  text: 'Ingresar',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: AppPallete.green1),
                                )
                              ])),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // Sign Un Social Methods
              Column(
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Registrar con',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                            constraints: const BoxConstraints(
                                minHeight: 70, minWidth: 70),
                            decoration: BoxDecoration(
                                color: AppPallete.greyGradient,
                                borderRadius: BorderRadius.circular(45)),
                            child: const Icon(Icons.people_alt)),
                        iconSize: 45,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                            constraints: const BoxConstraints(
                                minHeight: 70, minWidth: 70),
                            decoration: BoxDecoration(
                                color: AppPallete.greyGradient,
                                borderRadius: BorderRadius.circular(45)),
                            child: const Icon(Icons.people_alt)),
                        iconSize: 45,
                      ),
                      const SizedBox(height: 150)
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
