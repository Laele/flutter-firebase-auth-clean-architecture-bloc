import 'package:flutter/material.dart';

class AuthUsernameField extends StatelessWidget {

  final String hintText;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController controller;

  const AuthUsernameField({
    this.suffixIcon, 
    this.prefixIcon, 
    super.key, 
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        return value!.length >= 4 && value.isNotEmpty ? null : 'El nombre de usuario debe tener mínimo 4 carácteres.';
      },
      
    );
  }
}