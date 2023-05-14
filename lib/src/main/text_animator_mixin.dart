import 'package:flutter/widgets.dart';

base mixin TextAnimatorMixin<T extends StatefulWidget> on State<T> {
  late AnimationController _controller;
  late Animation<double> _animation;

  /// AnimationController
  AnimationController get animationController => _controller;

  set animationController(AnimationController value) => _controller = value;

  /// Animation
  Animation<double> get animation => _animation;

  set animation(Animation<double> value) => _animation = value;

  get anim => ();

  /// Initial
  double get initialValue;

  /// Value
  double get currentValue;

  /// Final
  double? get finalValue;

  Duration? get duration;

  /// Load
  load(double start, double finish, [bool init = false]) {}
}
