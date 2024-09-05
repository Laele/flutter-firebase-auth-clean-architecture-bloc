import 'package:flutter/material.dart';

class AuthPasswordField extends StatefulWidget {

  final String hintText;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final TextEditingController? passwordController;

  const AuthPasswordField({
    this.suffixIcon, 
    this.prefixIcon, 
    super.key, 
    required this.hintText, 
    required this.controller, 
    this.passwordController
    }
  );

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        
        //suffix: IconButton(onPressed: () { }, icon: const Icon(Icons.remove_red_eye,)),
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: isObscureText ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off), 
          onPressed: () {
            isObscureText = !isObscureText;
            setState(() {
              
            });
          },
        ),
        prefixIcon: widget.prefixIcon,
        
      ),
      obscureText: isObscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        if(widget.passwordController != null){
          if(value!.length < 6){
            return 'La contraseña debe tener 6 carácteres como mínimo.';
          } else if(widget.passwordController!.value.text != value){
            
            return 'Las contraseñas no coinciden.';
          }
          return null;
        }
        return null;

        /*if(widget.passwordController.value != value!){
          return value!.length >= 6 ? null : 'Las contraseñas no coinciden.';
        }
        return value!.length >= 6 ? null : 'La contraseña debe tener 6 carácteres como mínimo.';*/
      },
      
    );
  }
}