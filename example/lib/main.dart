import 'package:flutter/material.dart';
import 'package:text_animator/text_animator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pinkAccent,
            brightness: Brightness.light,
          )),
      home: const Example(),
    );
  }
}

// -------------------------------------------------------------------------------------------------

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  double _data = 11;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(backgroundColor: color.primary),
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        width: double.infinity,
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            buildMaterialButton(color.primaryContainer, 100),
            buildMaterialButton(color.tertiaryContainer, 2000),
            buildMaterialButton(color.inversePrimary, 40000),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: TextAnimator(
              initial: 50,
              value: _data,
              initializeToValue: false,
              duration: const Duration(seconds: 5),
              builder: (BuildContext context, value) {
                return Text(
                  value,
                  style: const TextStyle(
                    backgroundColor: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }

  MaterialButton buildMaterialButton(Color color, double num) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: color,
      onPressed: () => setState(() {
        _data = num;
      }),
      child: Text('$num'),
    );
  }
}

// -------------------------------------------------------------------------------------------------
