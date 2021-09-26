import 'package:flutter/cupertino.dart';

class BottomMenu{
  final Widget icon;
  final String title;
  final Widget screen;
  final String routeName;

  const BottomMenu({required this.title, required this.icon, required this.routeName, required this.screen});
}