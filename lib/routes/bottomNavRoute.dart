import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as S;
import 'package:girlmantra_task/resources/resources.dart';
import 'package:girlmantra_task/screens/challenges.dart';
import 'package:girlmantra_task/screens/home.dart';
import 'package:girlmantra_task/screens/meditation.dart';
import 'package:girlmantra_task/screens/nutrition.dart';
import 'package:girlmantra_task/screens/workout.dart';
import 'package:girlmantra_task/utils/bottomMenu.dart';
import 'package:girlmantra_task/utils/slide/swipeRouteBuilder.dart';
import 'package:stateful_nav/stateful_nav.dart';


class BottomNavRoute extends NavHandler {

  /// Ordered List of ScreenName in the order of bottom nav icons
  late final List<BottomMenu> menu = [
    BottomMenu(title: 'Home', icon: ImageIcon(S.Svg(Svg.home)), routeName: '/', screen: Home()),
    BottomMenu(title: 'Meditation', icon: ImageIcon(S.Svg(Svg.meditation)), routeName: '/meditation', screen: Meditation()),
    BottomMenu(title: 'Workout', icon: ImageIcon(S.Svg(Svg.workout)), routeName: '/workout', screen: Workout()),
    BottomMenu(title: 'Nutrition', icon: ImageIcon(S.Svg(Svg.nutrition)), routeName: '/nutrition', screen: Nutrition()),
    BottomMenu(title: 'Challenges', icon: ImageIcon(AssetImage(Images.challenges)), routeName: '/challenges', screen: Challenges()),
  ];

  /// Stores current screen to be used when changing screen
  int currentIndex = 0;

  BottomNavRoute(String label) : super(label);


  Route<dynamic> generateRoute(RouteSettings settings){
    print(settings.name);
    int newIndex = menu.indexWhere((element) => element.routeName == settings.name);
    if(newIndex==-1){
      throw Exception('No such route in the bottom nav (main) navigator');
    }
    /// Check from which direction to swipe to
    bool fromLeft = currentIndex > newIndex;
    currentIndex = newIndex;

    return SwipeRouteBuilder(menu[newIndex].screen, fromLeft: fromLeft);
  }

}