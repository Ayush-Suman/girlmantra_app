import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girlmantra_task/utils/styles/colors.dart';
import 'package:girlmantra_task/utils/styles/textstyles.dart';

class Meditation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [ThemeColors.primary, Colors.white], transform: GradientRotation(336.79*pi/180))
          ),
          child: Center(
            child: Text("Medication", style: TextStyles.body,),
          ),
        )
    );
  }
}