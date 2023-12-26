import 'package:flutter/widgets.dart';

 mixin TextAnimatorMixin<T extends StatefulWidget> on State<T> {
  /// A mixin for handling text animations.
  ///
  /// This mixin provides the necessary properties and methods for handling
  /// animations in widgets.
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

  /// Duration
  Duration? get duration;

  /// Load
  load(double start, double finish, [bool init = false]) {}
}

