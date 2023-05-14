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
              startPosition: 0,
              endPosition: 400,
              duration: const Duration(seconds: 15),
              builder: (BuildContext context, ({int current, int end, int start}) record) {
                return Card(
                  color: color.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    width: 48,
                    padding: const EdgeInsets.all(18),
                    child: Center(
                      child: Text(
                        "${record.current}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
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
