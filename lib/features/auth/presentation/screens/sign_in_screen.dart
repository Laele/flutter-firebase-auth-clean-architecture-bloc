import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_rate_products/features/auth/presentation/auth_widgets.dart';
import 'package:flutter_rate_products/core/theme/app_pallete.dart';
import 'package:flutter_rate_products/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      child: Text('Ingresar.', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
                    ),
                    
                    const SizedBox(height: 15),
                    
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
                    ),
                
                    const SizedBox(height: 10),
                
                    AuthFilledButton(
                      text: 'Ingresar', 
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          AuthLogin(
                            email:    emailController.text.trim(),
                            password: passwordController.text.trim(), 
                          )
                        );
                      },
                    ),
                
                    const SizedBox(height: 10,),
                
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: (){
                          context.push('/sign-up');
                        },
                        child: RichText(
                          text: TextSpan(
                            text: '¿No tienes una cuenta?  ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Crear una cuenta',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPallete.green1
                                ),
                              ),
                              
                            ]
                          )
                        ),
                      ),
                    ) 
                  ],
                ),
              ),
            ),
            // Sign In Social Methods
            Column(
              children: [
                const Divider(),
                const SizedBox(height: 10,),
                const Text('Ingresar con', style: TextStyle(fontWeight: FontWeight.w600),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    IconButton(
                      onPressed: () { }, 
                      icon: Container(
                        constraints: const BoxConstraints(
                          minHeight: 70,
                          minWidth: 70
                        ),
                        decoration: BoxDecoration(
                          color: AppPallete.greyGradient,
                          borderRadius:BorderRadius.circular(45) 
                        ),
                        child: const Icon(Icons.people_alt)
                      ),
                      iconSize: 45,
                    ),

                    IconButton(
                      onPressed: () { }, 
                      icon: Container(
                        constraints: const BoxConstraints(
                          minHeight: 70,
                          minWidth: 70
                        ),
                        decoration: BoxDecoration(
                          color: AppPallete.greyGradient,
                          borderRadius:BorderRadius.circular(45) 
                        ),
                        child: const Icon(Icons.people_alt)
                      ),
                      iconSize: 45,
                    ),

                    const SizedBox(height: 150)
                  ],
                )
              ],
            )          
          ],
        ),
      ),
    );
  }
}