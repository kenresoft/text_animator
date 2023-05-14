import 'package:flutter/material.dart';
import 'package:text_animator/src/main/text_animator_mixin.dart';

import 'animator_util.dart';

class TranslationTextAnimator extends StatefulWidget {
  const TranslationTextAnimator({
    Key? key,
    this.color,
    required this.startPosition,
    required this.endPosition,
    this.currentPosition,
    this.duration = const Duration(seconds: 5),
    required this.builder,
  }) : super(key: key);

  final Color? color;
  final double? currentPosition;
  final double startPosition;
  final double endPosition;
  final RecordBuilder builder;
  final Duration? duration;

  @override
  State<TranslationTextAnimator> createState() => _TranslationTextAnimatorState();
}

base class _TranslationTextAnimatorState extends State<TranslationTextAnimator> with TickerProviderStateMixin, TextAnimatorMixin {
  @override
  double get initialValue => widget.startPosition == double.infinity ? 0 : widget.startPosition;

  @override
  double get currentValue => animation.value;

  @override
  double get finalValue => widget.endPosition == double.infinity ? 0 : widget.endPosition;

  @override
  Duration? get duration => widget.duration;

  @override
  void initState() {
    _updateWidget();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TranslationTextAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateWidget();
  }

  void _updateWidget() {
    animationController = AnimationController(vsync: this, duration: duration);
    load(initialValue, finalValue);
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
              child: widget.builder(context, (start: initialValue.ceil(), current: currentValue.ceil(), end: finalValue.ceil())),
            );
          },
          animation: animation,
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
