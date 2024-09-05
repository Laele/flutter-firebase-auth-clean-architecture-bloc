import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rate_products/core/theme/app_pallete.dart';

class AppTheme {

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.white,
    primaryColor: AppPallete.green1,

    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppPallete.blue,
      suffixIconColor: AppPallete.grey,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppPallete.green1,
          width: 2
        ),
        borderRadius: BorderRadius.circular(45.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppPallete.blue,
          width: 2
        ),
        borderRadius: BorderRadius.circular(45.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppPallete.red,
          width: 2
        ),
        borderRadius: BorderRadius.circular(45.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppPallete.red,
          width: 2
        ),
        borderRadius: BorderRadius.circular(45.0),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppPallete.green1),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(45))
        )
      )
    ),


  );

}