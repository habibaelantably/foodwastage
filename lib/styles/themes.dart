import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodwastage/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart'; 

ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
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
        elevation: 20.0,
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
ThemeData darkTheme = ThemeData(
    hintColor: Colors.white,
    canvasColor: Colors.grey[800],
    primaryTextTheme: Typography(platform: TargetPlatform.android).white,
    textTheme: Typography(platform: TargetPlatform.android).white,
    primaryColor: Colors.red,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black54,
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[100]!)),
        labelStyle: TextStyle(color: Colors.white),
        prefixIconColor: Colors.white),
    timePickerTheme: TimePickerThemeData(
        dialTextColor: Colors.white,
        dialBackgroundColor: Colors.black38,
        dayPeriodTextColor: Colors.white,
        hourMinuteTextColor: Colors.white,
        entryModeIconColor: Colors.white,
        backgroundColor: Colors.grey[900]),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light),
        color: Colors.black,
        titleTextStyle: TextStyle(
            color: Colors.blue,
            fontFamily: "Urial",
            fontSize: 22.0,
            fontWeight: FontWeight.w800),
        iconTheme: IconThemeData(color: Colors.blue),
        actionsIconTheme: IconThemeData(color: Colors.blue)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[800],
        elevation: 50.0,
        selectedIconTheme: IconThemeData(size: 32.0),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        selectedLabelStyle: TextStyle(
          fontFamily: "Urial",
          fontSize: 18.0,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: "Urial",
        ),
        unselectedItemColor: Colors.white),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[900],
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey[700],
    ),
    iconTheme: IconThemeData(color: Colors.white));
