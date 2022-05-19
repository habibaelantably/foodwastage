import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodwastage/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  primaryTextTheme: Typography(platform: TargetPlatform.android).black,
  textTheme: Typography(platform: TargetPlatform.android).black,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: IconThemeData(color: Colors.black)),
  iconTheme: const IconThemeData(color: Colors.black),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(size: 28.0, color: defaultColor),
      selectedLabelStyle: TextStyle(fontSize: 16.0, color: defaultColor),
      unselectedItemColor: Colors.black45,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed),

  listTileTheme: const ListTileThemeData(iconColor: Colors.black, textColor: Colors.black),
);

ThemeData darkTheme = ThemeData(
  hintColor: Colors.grey[500],
  canvasColor: Colors.grey[800],
  primaryTextTheme: Typography(platform: TargetPlatform.android).white,
  textTheme: Typography(platform: TargetPlatform.android).white,
  primaryColor: Colors.red,
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.black54,
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith ((states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.white;
      }else{
        return defaultColor;
      }
    })
  ),
  cardTheme: CardTheme(
    color: Colors.grey[700],

  ),
  popupMenuTheme: PopupMenuThemeData(
      color: Colors.grey[800], textStyle: const TextStyle(color: Colors.white)),
  inputDecorationTheme: InputDecorationTheme(
    disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[100]!)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[100]!)),
      labelStyle: const TextStyle(color: Colors.white),
      prefixIconColor: Colors.white),
  appBarTheme: const AppBarTheme(
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light),
      color: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w800),
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(size: 28.0, color: defaultColor),
      selectedLabelStyle: TextStyle(fontSize: 16.0, color: defaultColor),
      unselectedItemColor: Colors.white,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey[900],
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey[700],
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white, textColor: Colors.white),
);
