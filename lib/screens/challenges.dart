import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:girlmantra_task/utils/styles/colors.dart';
import 'package:girlmantra_task/utils/styles/textstyles.dart';

class Challenges extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChallengesState();
  }
}

class ChallengesState extends State<Challenges> with TickerProviderStateMixin {

  late final TabController tabController;
  late final PageController pageController;
  late final AnimationController animationController;

  late final ValueNotifier<bool> sideNavOpened;

  @override
  void initState() {
    sideNavOpened = ValueNotifier(false);
    animationController = AnimationController(vsync: this,
        duration: kThemeAnimationDuration,
        reverseDuration: kThemeAnimationDuration);
    tabController = TabController(length: 4, vsync: this);
    pageController = PageController(initialPage: tabController.index);
    tabController.addListener(() {
      pageController.animateToPage(
          tabController.index, duration: kThemeAnimationDuration,
          curve: Curves.easeInOut);
    });
    sideNavOpened.addListener(() {
      setState(() {});
      sideNavOpened.value ? animationController.forward() : animationController
          .reverse();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(() {
      pageController.animateToPage(
          tabController.index, duration: kThemeAnimationDuration,
          curve: Curves.easeInOut);
    });
    sideNavOpened.removeListener(() {
      setState(() {});
      sideNavOpened.value ? animationController.forward() : animationController
          .reverse();
    });
    animationController.dispose();
    tabController.dispose();
    pageController.dispose();
    sideNavOpened.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery
        .of(context)
        .padding
        .top;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        body: Stack(children: [
          AnimatedPositioned(
              curve: Curves.easeInOut,
              top: 0,
              bottom: 0,
              duration: kThemeAnimationDuration,
              right: sideNavOpened.value ? 0 : -screenWidth * 0.7,
              width: screenWidth * 0.7,
              child: Container(color: ThemeColors.primaryDark)),
          AnimatedPositioned(
              curve: Curves.easeInOut,
              top: 0,
              bottom: 0,
              width: screenWidth,
              duration: kThemeAnimationDuration,
              right: sideNavOpened.value ? screenWidth * 0.7 : 0,
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ThemeColors.primary, Colors.white],
                          transform: GradientRotation(336.79 * pi / 180)
                      )
                  ),
                  child: Padding(padding: EdgeInsets.only(
                      top: topPadding + 40, right: 30, left: 30), child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Challenges', style: TextStyles.heading,),
                            InkWell(
                              child: AnimatedIcon(
                                  icon: AnimatedIcons.menu_close,
                                  progress: animationController
                              ),
                              onTap: () {
                                sideNavOpened.value = !sideNavOpened.value;
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 7,),
                        Align(child: Text("Build healthy habits daily",
                          style: TextStyles.subHeading,),
                          alignment: Alignment.centerLeft,),
                        SizedBox(height: 20,),
                        Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ThemeColors.primaryDark
                            ),
                            child: TabBar(
                              controller: tabController,
                              indicatorPadding: EdgeInsets.all(6),
                              indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14)
                              ),
                              tabs: [
                                Tab(
                                  child: Text("All", style: TextStyles.body),
                                ),
                                Tab(
                                  child: FittedBox(child: Text(
                                      "Medication", style: TextStyles.body)),
                                ),
                                Tab(
                                  child: FittedBox(child: Text(
                                      "Workout", style: TextStyles.body)),
                                ),
                                Tab(
                                  child: FittedBox(child: Text(
                                      "Nutrition", style: TextStyles.body)),
                                ),
                              ],
                            )
                        ),
                        Flexible(child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: PageView(
                              onPageChanged: (index){
                                tabController.animateTo(index);
                              },
                              controller: pageController,
                              children: [
                                Container(color: ThemeColors.primary),
                                Container(color: ThemeColors.accent),
                                Container(color: ThemeColors.primaryDark),
                                Container(color: Colors.white),
                              ],
                            )))
                      ])
                  )))
        ])
    );
  }
}
