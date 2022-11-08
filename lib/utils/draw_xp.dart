import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class drawXp extends CustomPainter {
  drawXp(this.xpPercentage, this.coaColor);

  double xpPercentage;
  dynamic coaColor;

  void _drawArcWithCenter(
    Canvas canvas,
    Paint paint, {
    Offset? center,
    double? radius,
    startRadian = 0.0,
    sweepRadian = pi,
  }) {
    canvas.drawArc(
      Rect.fromCircle(center: center!, radius: radius!),
      startRadian,
      sweepRadian,
      true,
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = coaColor
      ..strokeWidth = 10.0;
    _drawArcWithCenter(canvas, paint,
        center: Offset(0, 0),
        radius: 70,
        startRadian: -pi / 2,
        sweepRadian: xpPercentage * 3.6 * pi / 180);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
