import 'package:email_validator/email_validator.dart';

String? validateEmail(String? value) {
  return EmailValidator.validate(value!) ? null : 'Verifica el correo proporcionado.';
}