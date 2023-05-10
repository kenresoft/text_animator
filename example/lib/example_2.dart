import 'package:flutter/material.dart';

class Example2 extends StatefulWidget {
  const Example2({Key? key}) : super(key: key);

  @override
  _Example2State createState() => _Example2State();
}

class _Example2State extends State<Example2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(backgroundColor: color.primary),
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        width: double.infinity,
        child: Column(
          children: [
            AnimatedBuilder(
              builder: (context, child) {
                return Transform.translate(
                  offset: const Offset(20, 0),
                  child: child,
                );
              },
              animation: _controller,
              child: Container(color: color.tertiary, child: const Text('Hello world')),
            ),
          ],
        ),
      ),
    );
  }
}
