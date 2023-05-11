import 'package:flutter/material.dart';
import 'package:text_animator/text_animator.dart';

part 'example_1.dart';


class _AnimatorInheritedWidget extends InheritedWidget {
  const _AnimatorInheritedWidget({
    Key? key,
    required this.exampleState,
    required Widget child,
  }) : super(key: key, child: child);

  final _ExampleState exampleState;

  static _AnimatorInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_AnimatorInheritedWidget>();
  }

  static _AnimatorInheritedWidget of(BuildContext context) {
    final _AnimatorInheritedWidget? animatorInheritedWidget = _AnimatorInheritedWidget.maybeOf(context);
    assert(animatorInheritedWidget != null);
    return animatorInheritedWidget!;
  }

  @override
  bool updateShouldNotify(_AnimatorInheritedWidget oldWidget) {
    return exampleState != oldWidget.exampleState;
  }
}
