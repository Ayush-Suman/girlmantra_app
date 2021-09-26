import 'package:flutter/material.dart';
import 'package:girlmantra_task/screens/bottomNav.dart';
import 'package:girlmantra_task/resources/resources.dart';
import 'package:girlmantra_task/utils/styles/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Girl Mantra',
      theme: theme,
      home: BottomNav(),
    );
  }
}

ThemeData theme = ThemeData(
  fontFamily: Fonts.helvetica,
  bottomNavigationBarTheme: _bottomNavigationBarTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  bottomSheetTheme: BottomSheetThemeData(
      modalBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)))),
  accentColor: ThemeColors.accent,
  dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      )
  ),
  appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),

  //bottomAppBarTheme: BottomAppBarTheme
);

BottomNavigationBarThemeData _bottomNavigationBarTheme =
BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: ThemeColors.accent),
    selectedItemColor: ThemeColors.accent,
    selectedLabelStyle: TextStyle(fontSize: 11.0, fontFamily: Fonts.lato),
    unselectedLabelStyle: TextStyle(fontSize: 11.0, fontFamily: Fonts.lato),
    unselectedIconTheme: IconThemeData(color: Colors.black),
    unselectedItemColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white);
