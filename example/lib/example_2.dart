import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:text_animator/text_animator.dart';

class Example2 extends StatefulWidget {
  const Example2({Key? key}) : super(key: key);

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //_animation = Tween<double>(begin: 10, end: cb(context, (x) => x)).animate(_controller);
    final width = MediaQuery.of(context).size.width;

    final color = Theme.of(context).colorScheme;

    log('$width');

    return Scaffold(
      appBar: AppBar(backgroundColor: color.primary),
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TranslationTextAnimator(
              color: color.primary,
              startPosition: 10,
              endPosition: 400,
              initializeToValue: true,
            )
          ],
        ),
      ),
    );
  }
}

/*double cb(BuildContext context, double Function(double value) f) {
  final width = MediaQuery.of(context).size.width;
  return f(2.5);
}*/
