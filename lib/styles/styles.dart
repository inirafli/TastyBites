import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xFFFFDE03);
const secondaryColor = Color(0xFF0336FF);
const onPrimaryColor = Colors.black;
const onSecondaryColor = Colors.white;

final TextTheme appTextTheme = TextTheme(
  displayLarge: GoogleFonts.rubik(
      fontSize: 96, fontWeight: FontWeight.w700, letterSpacing: -1.5),
  displayMedium: GoogleFonts.rubik(
      fontSize: 60, fontWeight: FontWeight.w700, letterSpacing: -0.5),
  displaySmall: GoogleFonts.rubik(fontSize: 48, fontWeight: FontWeight.w700),
  headlineMedium: GoogleFonts.rubik(
      fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.rubik(fontSize: 24, fontWeight: FontWeight.w700),
  titleLarge: GoogleFonts.rubik(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.rubik(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleSmall: GoogleFonts.rubik(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.rubik(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.rubik(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.rubik(
      fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.25),
  bodySmall: GoogleFonts.rubik(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.rubik(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
