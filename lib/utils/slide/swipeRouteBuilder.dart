import 'package:flutter/cupertino.dart';
import 'package:girlmantra_task/utils/slide/directionalSlideTransition.dart';

class SwipeRouteBuilder extends PageRouteBuilder {

  SwipeRouteBuilder(Widget page, {bool fromLeft = false})
      :super(
    pageBuilder: (context, animation, secondaryAnimation) =>
      DirectionalSlideTransition(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          _fromLeft,
          page
      ),
    transitionDuration: Duration(milliseconds: 500),
    reverseTransitionDuration: Duration(milliseconds: 500)
  ) {
    _fromLeft.value = fromLeft;
  }

}

ValueNotifier<bool> _fromLeft = ValueNotifier(true);

