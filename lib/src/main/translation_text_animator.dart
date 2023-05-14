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
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  final Color? color;
  final double? currentPosition;
  final double startPosition;
  final double endPosition;
  final Duration? duration;
  final bool initializeToValue;

  @override
  State<TranslationTextAnimator> createState() => _TranslationTextAnimatorState();
}

base class _TranslationTextAnimatorState extends State<TranslationTextAnimator> with SingleTickerProviderStateMixin, TextAnimatorMixin {
  late double _initial;
  late double _final;

  @override
  double get initialValue => widget.startPosition;

  @override
  double get currentValue => animation.value;

  @override
  double get finalValue => widget.endPosition;

  @override
  Duration? get duration => widget.duration;

  @override
  void initState() {
    //_updateWidget();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TranslationTextAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    /*if (oldWidget.startPosition != widget.startPosition || oldWidget.endPosition != widget.endPosition) {
      animationController = AnimationController(vsync: this, duration: duration);
      animationController.reset();
      animationController.forward();
    }
    if (oldWidget.initializeToValue != widget.initializeToValue) {
      _updateWidget();
    }
    if (oldWidget.duration!.compareTo(duration!) < 0) {
      _updateWidget();
    }*/
    _updateWidget();
  }

  void _updateWidget() {
    animationController = AnimationController(vsync: this, duration: duration);
    _initial = initialValue;
    _final = finalValue;
    widget.initializeToValue ? load(_initial, _final) : load(_initial, _initial);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  load(double start, double finish, [bool init = false]) {
    animation = Tween(begin: start, end: finish).animate(animationController);
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
              offset: Offset(_buildValue(width), 0),
              child: child,
            );
          },
          animation: animation,
          child: Container(color: widget.color, child: const Text('Hello world')),
        ),
      );
    });
  }

  double _buildValue(double width) {
    double value;
    if (currentValue > width || currentValue >= finalValue) {
      load(initialValue, finalValue);
      value = initialValue;
    } else {
      value = currentValue;
    }
    return value;
  }
}
