import 'package:flutter/material.dart';

typedef ValueBuilder = Widget Function(BuildContext, String);

class TextAnimator extends StatefulWidget {
  const TextAnimator({
    Key? key,
    this.initial = 2,
    this.color,
    required this.value,
    this.initializeToValue = false,
    required this.builder,
  }) : super(key: key);

  final double initial;
  final double value;
  final Color? color;
  final bool initializeToValue;
  final ValueBuilder builder;

  @override
  State<TextAnimator> createState() => _TextAnimatorState();
}

class _TextAnimatorState extends State<TextAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late double _initial;
  late double _value;

  double get initial => widget.initial;

  double get value => widget.value;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _initial = initial;
    _value = value;
    widget.initializeToValue ? load(_initial, _value) : load(_initial, _initial);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = value;
      load(_initial, _value, true);
    }
    if (oldWidget.initializeToValue != widget.initializeToValue) {
      widget.initializeToValue ? load(_initial, _value) : load(_initial, _initial);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  load(double s, double e, [bool init = false]) {
    _animation = Tween(begin: s, end: e).animate(_animationController);
    _animationController.reset();
    _animationController.forward();
    if (init) {
      _initial = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Material(
          color: Colors.transparent,
          child: widget.builder(context, '${_animation.value.floor()}'),
        );
      },
      animation: _animation,
    );
  }
}
