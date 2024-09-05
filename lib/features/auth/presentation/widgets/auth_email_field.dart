import 'package:flutter/material.dart';
import 'package:flutter_rate_products/core/validators/validator_email.dart';

class AuthEmailField extends StatelessWidget {

  final String hintText;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final bool isObscureText;

  const AuthEmailField({
    this.suffixIcon, 
    this.prefixIcon, 
    super.key, 
    this.isObscureText = false,
    required this.hintText, 
    required this.controller
    }
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        //suffix: IconButton(onPressed: () { }, icon: const Icon(Icons.remove_red_eye,)),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      obscureText: isObscureText,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validateEmail
      
    );
  }
}