import 'package:flutter/material.dart';
import 'package:number_animator_example/main.dart';

class AnimatorInheritedWidget extends InheritedWidget {
  const AnimatorInheritedWidget({
    Key? key,
    required this.object,
    required Widget child,
  }) : super(key: key, child: child);

  final ExampleState object;

  static AnimatorInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AnimatorInheritedWidget>();
  }

  static AnimatorInheritedWidget of(BuildContext context) {
    final AnimatorInheritedWidget? animatorInheritedWidget = AnimatorInheritedWidget.maybeOf(context);
    assert(animatorInheritedWidget != null);
    return animatorInheritedWidget!;
  }

  @override
  bool updateShouldNotify(AnimatorInheritedWidget oldWidget) {
    return object != oldWidget.object;
  }
}
