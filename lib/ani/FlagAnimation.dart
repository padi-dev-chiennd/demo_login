import 'dart:math';
import 'package:demologin/ani/FlagPainter.dart';
import 'package:flutter/material.dart';
class FlagAnimation extends StatefulWidget {
  @override
  _FlagAnimationState createState() => _FlagAnimationState();
}

class _FlagAnimationState extends State<FlagAnimation>
    with TickerProviderStateMixin {
  late AnimationController _drawController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _drawController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();  // Bắt đầu hiệu ứng xuất hiện ban đầu

    _drawController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _waveController.forward();  // Bắt đầu hiệu ứng sóng khi hiệu ứng xuất hiện kết thúc
      }
    });

    _waveController = AnimationController(
      duration: const Duration(milliseconds: 500),  // Giảm thời gian để sóng nhanh hơn
      vsync: this,
    )..repeat();  // Lặp vô hạn để tạo hiệu ứng sóng
  }

  @override
  void dispose() {
    _drawController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: AnimatedBuilder(
        animation: Listenable.merge([_drawController, _waveController]),
        builder: (context, child) {
          return CustomPaint(
            painter: FlagPainter(
              _drawController.value,       // Tiến trình vẽ cờ dần dần
              _waveController.value * 2 * pi,  // Pha sóng
            ),
          );
        },
      ),
    );
  }
}


