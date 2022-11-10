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
    var paint = Paint()..color = coaColor;
    _drawArcWithCenter(canvas, paint,
        center: const Offset(0, 0),
        radius: 73,
        startRadian: -pi / 2,
        sweepRadian: xpPercentage * 3.6 * pi / 180);
    var paint2 = Paint()
      ..color = coaColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawArc(
      Rect.fromCircle(center: const Offset(0, 0), radius: 73),
      0,
      2 * pi,
      false,
      paint2,
    );
    canvas.drawArc(
      Rect.fromCircle(center: const Offset(0, 0), radius: 66),
      0,
      2 * pi,
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
