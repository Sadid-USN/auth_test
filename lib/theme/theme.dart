import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const mycolor = MaterialColor(
  0xFF1F172E,
  <int, Color>{
    50: Color(0xFFE3E1E9),
    100: Color(0xFFB7B4C8),
    200: Color(0xFF8681A8),
    300: Color(0xFF565187),
    400: Color(0xFF2E2B67),
    500: Color(0xFF1F172E),
    600: Color(0xFF1B132A),
    700: Color(0xFF160F24),
    800: Color(0xFF110A1F),
    900: Color(0xFF0A0513),
  },
);

final appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xffF3F4F6),
  primarySwatch: mycolor,
  dividerColor: Colors.grey,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),

  iconTheme: const IconThemeData(color: Color(0xff000000), size: 200,),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: TextTheme(
    bodyMedium:  const TextStyle(
      color:  Colors.red,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    titleLarge: GoogleFonts.manrope(
      color: const Color(0XFF000000),
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.manrope(
      color: const Color(0XFF000000),
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),

    
    labelMedium: GoogleFonts.manrope(
      color: const Color(0XFF929292),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    labelSmall: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontWeight: FontWeight.w700,
        fontSize: 14,
        height: 1.5),
    headlineMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),
  ),
);
