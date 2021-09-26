import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:girlmantra_task/utils/slide/disposableAnimatedWidget.dart';

class DirectionalSlideTransition extends DisposableAnimatedWidget{
  DirectionalSlideTransition(
      Animation<double> animation,
      this.fromLeft,
      this.child
      ) : super(listenable: animation){

    _forwardOffset = fromLeft.value ? _leftOffsetBuilder : _rightOffsetBuilder;
    _backwardOffset = fromLeft.value ? _rightOffsetBuilder : _leftOffsetBuilder;
    _offsetBuilder = () => _forwardOffset();

    _animationListener = (AnimationStatus status){
      if(status == AnimationStatus.forward){
        _offsetBuilder = () => _forwardOffset();
      }else{
        _offsetBuilder = () => _backwardOffset();
      }
    };

    _fromLeftListener = (){
      if(fromLeft.value){
        _forwardOffset = _leftOffsetBuilder;
        _backwardOffset = _rightOffsetBuilder;
      }else{
        _forwardOffset = _rightOffsetBuilder;
        _backwardOffset = _leftOffsetBuilder;
      }
    };

    this.animation.addStatusListener(_animationListener);

    fromLeft.addListener(_fromLeftListener);

  }

  final ValueNotifier<bool> fromLeft;
  final Widget child;

  late final Function() _fromLeftListener;
  late final Function(AnimationStatus) _animationListener;

  Animation<double> get animation => listenable as Animation<double>;

  Offset _leftOffsetBuilder(){
    return Offset(-1+this.animation.value, 0);
  }

  Offset _rightOffsetBuilder(){
    return Offset(1-this.animation.value, 0);
  }

  late Offset Function() _forwardOffset;
  late Offset Function() _backwardOffset;

  late Offset Function() _offsetBuilder;

  @override
  Widget build(BuildContext context) {
    Offset offset = _offsetBuilder();
    return FractionalTranslation(
      translation: offset,
      child: child,
    );
  }

  @override
  void dispose() {
    fromLeft.removeListener(_fromLeftListener);
    animation.removeStatusListener(_animationListener);
  }

}