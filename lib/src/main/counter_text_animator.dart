import 'package:flutter/material.dart';
import 'package:text_animator/src/main/text_animator_mixin.dart';

import 'animator_util.dart';

// enum{ counter, marquee, }

class CounterTextAnimator extends StatefulWidget {
  const CounterTextAnimator({
    Key? key,
    this.initial = 0,
    this.color,
    required this.value,
    this.initializeToValue = false,
    required this.builder,
    required this.duration,
  }) : super(key: key);

  final double initial;
  final double value;
  final Color? color;
  final bool initializeToValue;
  final ValueBuilder builder;
  final Duration duration;

  @override
  State<CounterTextAnimator> createState() => _CounterTextAnimatorState();
}

base class _CounterTextAnimatorState extends State<CounterTextAnimator> with TickerProviderStateMixin, TextAnimatorMixin {
  late double _initial;
  late double _value;

  @override
  double get initialValue => widget.initial;

  @override
  double get currentValue => widget.value;

  @override
  double? get finalValue => null;

  @override
  Duration? get duration => widget.duration;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    _initial = initialValue;
    _value = currentValue;
    widget.initializeToValue ? load(_initial, _value) : load(_initial, _initial);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CounterTextAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = currentValue;
      load(_initial, _value, true);
    }
    if (oldWidget.initial != widget.initial) {
      _initial = initialValue;
      load(_initial, _initial);
    }
    if (oldWidget.initializeToValue != widget.initializeToValue) {
      _initial = initialValue;
      _value = currentValue;
      widget.initializeToValue ? load(_initial, _value) : load(_initial, _initial);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  load(double start, double finish, [bool init = false]) {
    animation = Tween(begin: start, end: finish).animate(animationController);
    animationController.reset();
    animationController.forward();
    if (init) {
      _initial = finish;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Material(
          color: Colors.transparent,
          child: widget.builder(context, '${animation.value.floor()}'),
        );
      },
      animation: animation,
    );
  }
}
