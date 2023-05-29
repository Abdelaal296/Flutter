import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkMode =ThemeData(
  primarySwatch: Colors.blue,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.white ,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 30.0,
    ),

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type:BottomNavigationBarType.fixed ,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    elevation: 25.0,
    backgroundColor: HexColor('333739'),
  ),
  backgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      color: Colors.white,
    ),
  ),
);

ThemeData lightMode =ThemeData(
  primarySwatch: Colors.blue,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.black ,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type:BottomNavigationBarType.fixed ,
    selectedItemColor: Colors.blue,
    elevation: 25.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      color: Colors.black,
    ),
  ),

);