import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

final ThemeData themeDataDark = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.redAccent,
  cursorColor: Colors.redAccent,
  // colorScheme: Colors.redAccent,
  textSelectionColor: Colors.redAccent,
  textSelectionHandleColor: Colors.redAccent,
  hoverColor: Colors.redAccent,
  splashColor: Colors.redAccent,
  cardColor: Colors.black54,
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.redAccent,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 16, color: Colors.white),
  ),
  primaryTextTheme: const TextTheme(
    button: TextStyle(color: Colors.black),
  ),
  accentTextTheme: const TextTheme(
    button: TextStyle(color: Colors.black),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.dark(),
    buttonColor: Colors.redAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
);
final ThemeData themeDataLight = ThemeData(
  primaryColor: Colors.blue,
  accentColor: Color(0xff2071AB),
  canvasColor: Colors.white,
  hoverColor: Color(0xff20C9B4),
  scaffoldBackgroundColor: Color(0xffF7F7F9),
  // unselectedWidgetColor: Colors.white,
  cursorColor: Colors.blue[600],
  colorScheme: ColorScheme.light(primary: Colors.blue[600]),
  textSelectionColor: Colors.blue[200],
  textSelectionHandleColor: Colors.blue,
  cardColor: Colors.white70,
  buttonColor: Color(0xff9F9E9E),
  inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(backgroundColor: Colors.transparent)),
  iconTheme: const IconThemeData(color: Colors.black54),
  splashColor: Colors.blue[300],
  textTheme: TextTheme(
      // headline1: GoogleFonts.cairo(
      //   fontSize: 20.0,
      //   color: Colors.black,
      //   fontWeight: FontWeight.w700,
      // ),
      // headline2: GoogleFonts.cairo(
      //   fontSize: 24.0,
      //   color: const Color(0xFF2071AB),
      // ),
      // subtitle1: GoogleFonts.cairo(
      //   fontSize: 14.0,
      //   color: const Color(0xFF9F9E9E),
      //   fontWeight: FontWeight.w700,
      // ),
      // subtitle2: GoogleFonts.cairo(
      //   fontSize: 14.0,
      //   color: Colors.black.withOpacity(0.60),
      //   fontWeight: FontWeight.normal,
      // ),
      // bodyText1: GoogleFonts.cairo(
      //   fontSize: 16.0,
      //   color: Colors.black.withOpacity(0.64),
      // ),
      // bodyText2: GoogleFonts.cairo(
      //   fontSize: 12.0,
      //   color: Color(0xff2071AB),
      //   fontWeight: FontWeight.w700,
      // ),
      // caption: GoogleFonts.cairo(
      //   fontSize: 14.0,
      //   color: Colors.white,
      // ),
      ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Colors.redAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.redAccent,
    elevation: 0,
  ),
);
const TextStyle headerTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.2,
);
const TextStyle bodyTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w300,
);
