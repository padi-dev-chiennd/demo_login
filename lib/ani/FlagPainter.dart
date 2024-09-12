import 'dart:math';
import 'package:flutter/material.dart';

class FlagPainter extends CustomPainter {
  final double drawProgress;
  final double wavePhase;

  FlagPainter(this.drawProgress, this.wavePhase);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Vẽ nền đỏ với hiệu ứng sóng ngang sau khi hoàn thành vẽ cờ
    paint.color = Colors.red;

    Path flagPath = Path();
    for (double x = 0; x <= size.width; x += 1) {
      double waveOffset = 0;
      if (drawProgress >= 1.0) {
        waveOffset = sin((x / size.width * 2 * pi) + wavePhase) * 10;
      }
      if (x == 0) {
        flagPath.moveTo(x, waveOffset);
      } else {
        flagPath.lineTo(x, waveOffset);
      }
    }
    flagPath.lineTo(size.width, size.height);
    flagPath.lineTo(0, size.height);
    flagPath.close();

    canvas.drawPath(flagPath, paint);

    // Vẽ ngôi sao vàng dần dần với hiệu ứng sóng ngang
    paint.color = Colors.yellow;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double outerRadius = size.width * 0.15 * drawProgress;  // Dần dần xuất hiện ngôi sao
    double innerRadius = outerRadius * 0.382;

    if (outerRadius > 0) {
      Path starPath = Path();

      for (int i = 0; i < 5; i++) {
        double outerAngle = (72 * i - 90) * (pi / 180);
        double innerAngle = (72 * i + 36 - 90) * (pi / 180);

        Offset outerPoint = Offset(
          centerX + outerRadius * cos(outerAngle) +
              (drawProgress >= 1.0
                  ? sin((centerX / size.width * 2 * pi) + wavePhase) * 10
                  : 0),
          centerY + outerRadius * sin(outerAngle),
        );
        Offset innerPoint = Offset(
          centerX + innerRadius * cos(innerAngle) +
              (drawProgress >= 1.0
                  ? sin((centerX / size.width * 2 * pi) + wavePhase) * 10
                  : 0),
          centerY + innerRadius * sin(innerAngle),
        );

        if (i == 0) {
          starPath.moveTo(outerPoint.dx, outerPoint.dy);
        } else {
          starPath.lineTo(outerPoint.dx, outerPoint.dy);
        }
        starPath.lineTo(innerPoint.dx, innerPoint.dy);
      }

      starPath.close();
      canvas.drawPath(starPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
