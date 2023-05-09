import 'package:flutter/material.dart';
import 'package:number_animator_example/main.dart';

class Sample extends InheritedWidget {
  const Sample({
    Key? key,
    required this.object,
    required Widget child,
  }) : super(key: key, child: child);

  final ExampleState object;

  static Sample? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Sample>();
  }

  @override
  bool updateShouldNotify(Sample oldWidget) {
    return object != oldWidget.object;
  }
}
