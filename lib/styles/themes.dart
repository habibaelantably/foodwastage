import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodwastage/styles/colors.dart'; //

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black)),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: defaultColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        backgroundColor: Colors.white),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black),
      caption: TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        height: 1.3,
      ),
    ));
