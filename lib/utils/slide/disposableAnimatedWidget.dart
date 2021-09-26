import 'package:flutter/cupertino.dart';

abstract class DisposableAnimatedWidget extends StatefulWidget {
  /// Creates a widget that rebuilds when the given listenable changes.
  ///
  /// The [listenable] argument is required.
  DisposableAnimatedWidget({
    Key? key,
    required this.listenable,
  }) : super(key: key);

  /// The [Listenable] to which this widget is listening.
  ///
  /// Commonly an [Animation] or a [ChangeNotifier].
  final Listenable listenable;


  Widget build(BuildContext context);

  void dispose();

  /// Subclasses typically do not override this method.
  @override
  _AnimatedState createState() => _AnimatedState();


}

class _AnimatedState extends State<DisposableAnimatedWidget> {
  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(DisposableAnimatedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      widget.listenable.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);
    widget.dispose();
    super.dispose();
  }

  void _handleChange() {
    setState(() {
      // The listenable's state is our build state, and it changed already.
    });
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}