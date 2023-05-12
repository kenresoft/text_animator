import 'package:flutter/material.dart';
import 'package:text_animator/src/main/text_animator_mixin.dart';

class TranslationTextAnimator extends StatefulWidget {
  const TranslationTextAnimator({
    Key? key,
    this.color,
    required this.startPosition,
    required this.endPosition,
    this.currentPosition,
    this.initializeToValue = false,
  }) : super(key: key);

  final Color? color;
  final double? currentPosition;
  final double startPosition;
  final double endPosition;
  final bool initializeToValue;

  @override
  State<TranslationTextAnimator> createState() => _TranslationTextAnimatorState();
}

class _TranslationTextAnimatorState extends State<TranslationTextAnimator> with SingleTickerProviderStateMixin, TextAnimatorMixin {
  late Animation<double> _animation;
  late double _initial;
  late double _value;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _initial = initialValue;
    _value = finalValue;
    widget.initializeToValue ? load(_initial, _value) : load(_initial, _initial);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TranslationTextAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.startPosition != widget.startPosition || oldWidget.endPosition != widget.endPosition) {
      animationController.reset();
      animationController.forward();
    }
    if (oldWidget.initializeToValue != widget.initializeToValue) {
      _initial = initialValue;
      _value = finalValue;
      widget.initializeToValue ? load(_initial, _value) : load(_initial, _initial);
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  double get initialValue => widget.startPosition;

  @override
  double get currentValue => 50;

  @override
  double get finalValue => widget.endPosition;

  @override
  load(double start, double finish, [bool init = false]) {
    _animation = Tween(begin: start, end: finish).animate(animationController);
    animationController.reset();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final width = constraint.maxWidth;
      return Container(
        alignment: Alignment.centerLeft,
        child: AnimatedBuilder(
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(buildValue(width), 0),
              child: child,
            );
          },
          animation: _animation,
          child: Container(color: widget.color, child: const Text('Hello world')),
        ),
      );
    });
  }

  double buildValue(double width) {
    double value;
    if (_animation.value > width) {
      load(0, 300);
      value = 0;
    } else {
      value = _animation.value;
    }
    return value;
  }
}
