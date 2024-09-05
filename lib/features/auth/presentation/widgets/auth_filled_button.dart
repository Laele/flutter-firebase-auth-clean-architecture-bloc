import 'package:flutter/material.dart';

class AuthFilledButton extends StatelessWidget {

  final Widget? child;
  final String? text;
  final VoidCallback onPressed;

  const AuthFilledButton({super.key, this.text, required this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),

      ),
      child: child ?? Text(text ?? '', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
    );
  }
}