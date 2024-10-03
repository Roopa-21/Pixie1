import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _textController;
  late String _displayText;
  final String _fullText = 'Build Your Story with Us...';

  @override
  void initState() {
    super.initState();

    // Page flip animation
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    // Typing effect animation
    _displayText = '';
    _textController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000))
      ..addListener(() {
        setState(() {
          _displayText = _fullText.substring(
              0, (_textController.value * _fullText.length).toInt());
        });
      });
    _textController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Background "book"
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.brown[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
              ),
              // Animated page flip
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.rotationY(_animation.value * 3.14),
                    alignment: Alignment.center,
                    child: Container(
                      width: 60,
                      height: 90,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          '📖',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.brown[700],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Typing animated text
          Text(
            _displayText,
            style: TextStyle(
              fontSize: 18,
              color: Colors.brown[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
