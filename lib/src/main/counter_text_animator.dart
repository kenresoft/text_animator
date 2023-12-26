import 'package:flutter/material.dart';
import 'package:text_animator/src/main/text_animator_mixin.dart';

import 'animator_util.dart';

// enum{ counter, marquee, }

/// A Flutter widget that animates a text value from an initial to a final value.
///
/// This widget uses the [TextAnimatorMixin] for handling animations.
class CounterTextAnimator extends StatefulWidget {
  /// Creates a [CounterTextAnimator] widget.
  ///
  /// Parameters:
  /// - [initial]: The initial value for the animation.
  /// - [value]: The target value for the animation.
  /// - [color]: The color of the animated text (optional).
  /// - [initializeToValue]: Flag to initialize the animation to the final value (default is false).
  /// - [builder]: The builder function to create the widget tree based on the animated value.
  /// - [duration]: The duration of the animation.
  const CounterTextAnimator({
    super.key,
    this.initial = 0,
    this.color,
    required this.value,
    this.initializeToValue = false,
    required this.builder,
    required this.duration,
  });

  /// Initial value for the animation.
  final double initial;

  /// Target value for the animation.
  final double value;

  /// Color of the animated text (optional).
  final Color? color;

  /// Flag to initialize the animation to the final value.
  final bool initializeToValue;

  /// Builder function to create the widget tree based on the animated value.
  final ValueBuilder builder;

  /// Duration of the animation.
  final Duration duration;

  @override
  State<CounterTextAnimator> createState() => _CounterTextAnimatorState();
}

/// The state for the [CounterTextAnimator] widget.
class _CounterTextAnimatorState extends State<CounterTextAnimator> with TickerProviderStateMixin, TextAnimatorMixin {
  late double _initial; // Internal variable to store the initial value.
  late double _value; // Internal variable to store the target value.

  @override
  double get initialValue => widget.initial; // Getter for the initial value.

  @override
  double get currentValue => widget.value; // Getter for the target value.

  @override
  double? get finalValue => null; // No final value for this animation.

  @override
  Duration? get duration => widget.duration; // Getter for the animation duration.

  @override
  void initState() {
    // Initialize animation controller with the provided duration.
    animationController = AnimationController(vsync: this, duration: duration);
    _initial = initialValue;
    _value = currentValue;

    // Always load based on the initial value, and update later if necessary.
    load(_initial, _initial);

    // Only update if initializeToValue is true
    if (widget.initializeToValue) {
      load(_initial, _value);
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CounterTextAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the target value changes, update the value for the animation.
    if (oldWidget.value != widget.value) {
      _value = currentValue;
      // TRUE: To ensure that the next animation start from
      // the previous value(final value of the last animation).
      load(_initial, _value, true);
    }

    // If the initial value changes, reset the animation to the new initial value.
    if (oldWidget.initial != widget.initial) {
      _initial = initialValue;
      load(_initial, _initial);
    }

    // If the initializeToValue flag changes, handle animation initialization accordingly.
    if (oldWidget.initializeToValue != widget.initializeToValue) {
      _initial = initialValue;
      _value = currentValue;
      widget.initializeToValue ? load(_initial, _value) : load(_value, _initial);
    }
  }

  @override
  void dispose() {
    // Dispose of the animation controller to avoid memory leaks.
    animationController.dispose();
    super.dispose();
  }

  @override
  load(double start, double finish, [bool init = false]) {
    super.load(start, finish);
    // Create a Tween for the animation.
    final curve = CurvedAnimation(parent: animationController, curve: Curves.ease);
    animation = Tween(begin: start, end: finish).animate(curve);

    // Reset and start the animation.
    animationController.reset();
    animationController.forward();

    // If init is true, update the initial value .
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
