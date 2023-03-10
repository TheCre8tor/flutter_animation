import 'dart:math' show pi;

import 'package:flutter/material.dart';

// 1. Loan
// 2. Card
// 3. Repayment via card - Follow up with Kola
// 4. Approval of loan - Follow up with Kola
// 5. Card images

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  /*
  Useful subjects:
  1. Trigonometry
  2. Algebra

  AnimationController | Animation
  * 0.0                 0 degrees     - 0.0 * 360 = 0 degrees
  * 0.5                 180 degrees   - 0.5 * 360 = 180 degrees
  * 1.0                 360 degrees   - 1.0 * 360 = 360 degrees

  1. read about vsync
  2. explore SingleTickerProviderStateMixin code base
  3. What is the differences between SingleTickerProviderStateMixin and TickerProvider
  * */

  late AnimationController _controller;

  // Animation is an object that is linked controller ->
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      // Tween means - between
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);

    // repeat method play's the animation continuously ->
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
