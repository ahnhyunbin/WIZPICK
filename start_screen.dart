import 'package:cdsf/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<CircleData> circles = List.generate(11, (index) => CircleData());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          for (var circle in circles) {
            circle.move();
          }
        });
      })
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'WIZPICK',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
// Background Animation
          Container(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: MultipleCirclesPainter(circles: circles),
                  child: child,
                );
              },
            ),
          ),
// Rest of the UI
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: const Color.fromARGB(255, 82, 98, 185),
                      width: 2.0,
                    ),
                  ),
                  primary: Colors.white,
                  onPrimary: Colors.indigo,
                  minimumSize: Size(150, 60),
                ),
                child: Container(
                  width: 170,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'STARTED!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CircleData {
  Offset position;
  double speed;
  double direction;
  double radius;
  double radiusChange;

  CircleData()
      : position = Offset(
          Random().nextDouble() * 200,
          Random().nextDouble() * 400,
        ),
        speed = Random().nextDouble() * 1 + 0.6,
        direction = Random().nextDouble() * 2 * pi,
        radius = Random().nextDouble() * 5 + 15, // 원의 초기 크기
        radiusChange = (Random().nextBool() ? 1 : -1) * 0; // 원의 크기 변화
  Color color = [
    Color.fromARGB(255, 255, 172, 117),
    Color.fromARGB(255, 249, 137, 129),
    Color.fromARGB(242, 231, 177, 204),
    const Color.fromARGB(255, 255, 255, 158),
    Color.fromARGB(255, 206, 171, 255),
    Color.fromARGB(255, 175, 255, 163)
  ][Random().nextInt(6)];
  move() {
    position = Offset(
      position.dx + speed * cos(direction),
      position.dy + speed * sin(direction),
    );

    radius += radiusChange; // 원의 크기 조절
    if (radius < 15 || radius > 20) {
      radiusChange = -radiusChange;
    }

    if (position.dx - radius < 0 || position.dx + radius > 400) {
      direction = pi - direction;
    }
    if (position.dy - radius < 0 || position.dy + radius > 800) {
      direction = 2 * pi - direction;
    }
  }
}

class MultipleCirclesPainter extends CustomPainter {
  final List<CircleData> circles;

  MultipleCirclesPainter({required this.circles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    for (var circle in circles) {
      paint.color = circle.color;
      canvas.drawCircle(circle.position, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
