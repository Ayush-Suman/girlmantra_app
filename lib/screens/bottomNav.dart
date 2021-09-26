import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girlmantra_task/di/navContainer.dart';
import 'package:girlmantra_task/routes/bottomNavRoute.dart';
import 'package:stateful_nav/stateful_nav.dart' as StatefulNav;

class BottomNav extends StatelessWidget {
  final _bottomNavConsumer = _BottomNavConsumer();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          switch (NavContainer.bottomNavRoute
              .menu[NavContainer.bottomNavRoute.currentIndex].title) {
            // case "Symptoms":
            //   return (await NavContainer.sympNavHandler.maybePop())
            //       ? false
            //       : await willPop(_bottomNavConsumer._history,
            //       _bottomNavConsumer._currentIndex);
            default:
              return await willPop(_bottomNavConsumer._history,
                  _bottomNavConsumer._currentIndex);
          }
        },
        child: _bottomNavConsumer);
  }

  /// If bottom nav screen has any history to go back to, it will navigate there.
  /// Otherwise, it will navigate back from the main screen.
  Future<bool> willPop(List history, currentIndex) async {
    _bottomNavConsumer._history.removeLast();
    if (_bottomNavConsumer._history.isNotEmpty) {
      _bottomNavConsumer._currentIndex.value = _bottomNavConsumer._history.last;
      print(_bottomNavConsumer._currentIndex.value);
      return false;
    } else {
      return true;
    }
  }
}




class _BottomNavConsumer extends StatefulWidget{

  /// Maintains a history of bottom nav screens visited.
  final List<int> _history = [0];

  final BottomNavRoute _mainNavContainer = NavContainer.bottomNavRoute;

  late final _navigator = StatefulNav.ZENavigator(
    navHandler: _mainNavContainer,
    initialRoute: _mainNavContainer.menu[0].routeName,
  );

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  State<StatefulWidget> createState() {
    return _BottomNavConsumerState();
  }
}



class _BottomNavConsumerState extends State<_BottomNavConsumer> {

  late final Function() _listener;

  @override
  void initState() {
    _listener = (){
      /// setState marks the UI dirty and forces it to rebuild
      setState(() {});
      /// Ensure UI is rebuilt before changing screens to prevent bugs
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        widget._mainNavContainer.navigatorState!.popAndPushNamed(
            widget._mainNavContainer.menu[widget._currentIndex.value].routeName);
      });
    };

    widget._currentIndex.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    //widget._currentIndex.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: widget._navigator,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(1,1),
                color: Colors.black
              )
            ],
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
            child: BottomNavigationBar(
              elevation: 0,
                currentIndex: widget._currentIndex.value,
                type: BottomNavigationBarType.fixed,
                onTap: (i) {
                  if (widget._currentIndex.value != i) {
                    widget._currentIndex.value = i;
                    if (widget._history.contains(i)) {
                      widget._history.remove(i);
                    }
                    widget._history.add(i);
                  }
                },
                items: widget._mainNavContainer.menu
                    .map((menu) =>
                    BottomNavigationBarItem(
                      icon: menu.icon,
                      label: menu.title,
                    ))
                    .toList()
            )
        )
    );
  }
}
