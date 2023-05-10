import 'package:flutter/material.dart';

class Example2 extends StatefulWidget {
  const Example2({Key? key}) : super(key: key);

  @override
  _Example2State createState() => _Example2State();
}

class _Example2State extends State<Example2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animation = _controller;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Example2 oldWidget) {
    _animation = Tween<double>(begin: 0, end: cb(context, (x) => x)).animate(_controller);
    _controller.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animation = Tween<double>(begin: 10, end: cb(context, (x) => x)).animate(_controller);
    _controller.forward();
    final width = MediaQuery.of(context).size.width;
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
                return FractionalTranslation(
                  translation: Offset(_animation.value, 0),
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

double cb(BuildContext context, double Function(double value) f) {
  final width = MediaQuery.of(context).size.width;
  return f(2.5);
}
