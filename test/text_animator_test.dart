import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_animator/text_animator.dart';

void main() {
  testWidgets('CounterTextAnimator Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CounterTextAnimator(
            initial: 0,
            value: 100,
            initializeToValue: true,
            builder: (context, value) => Text(value),
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
    );

    // You can add test cases based on your specific requirements
    // For example, you might want to check if the widget renders correctly,
    // if the animation starts and stops as expected, etc.

    // Example: Check if the widget displays the correct initial value
    expect(find.text('0'), findsOneWidget);

    // Trigger animation
    await tester.pumpAndSettle();

    // Example: Check if the widget displays the correct final value after animation
    expect(find.text('100'), findsOneWidget);

    // Rebuild widget with a different initial value and a different target value
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CounterTextAnimator(
            initial: 50,
            // New initial value
            value: 100,
            // New target value
            builder: (context, value) => Text(value),
            duration: const Duration(seconds: 1),
            initializeToValue: true, // Set to true for this scenario
          ),
        ),
      ),
    );

    // Check if the widget displays the correct initial value
    expect(find.text('50'), findsOneWidget);

    // Trigger animation
    await tester.pumpAndSettle();

    // Check if the widget displays the correct final value after animation
    expect(find.text('50'), findsOneWidget);

  });
}
