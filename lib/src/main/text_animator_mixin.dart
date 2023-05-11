import 'package:flutter/widgets.dart';

mixin TextAnimatorMixin<T extends StatefulWidget> on State<T> {
  late AnimationController _controller;

  /// AnimationController
  AnimationController get animationController => _controller;

  set animationController(AnimationController value) => _controller = value;

  /// Initial
  double get initialValue;

  /// Value
  double get currentValue;

  /// Final
  double? get finalValue;

  /// Load
  load(double start, double finish, [bool init = false]) {}
}
