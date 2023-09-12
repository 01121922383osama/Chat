import 'dart:math';

import 'package:flutter/material.dart';

class OtherStatus extends StatelessWidget {
  const OtherStatus(
      {super.key, this.name, this.imageName, this.isSean, this.statusNum});
  final String? name;
  final String? imageName;
  final bool? isSean;
  final int? statusNum;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(isSean: isSean, statusNum: statusNum),
        child: CircleAvatar(
          radius: 26,
          backgroundImage: AssetImage('assets/images/$imageName'),
        ),
      ),
      title: Text(
        name!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        'Tody now',
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}

degreeToAngle(
  double degree,
) {
  return degree * pi / 180;
}

class StatusPainter extends CustomPainter {
  final bool? isSean;
  final int? statusNum;

  StatusPainter({this.isSean, this.statusNum});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 5.0
      ..color = isSean! ? const Color(0xff21bfa6) : Colors.grey
      ..style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    if (statusNum == 1) {
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        degreeToAngle(0),
        degreeToAngle(360),
        false,
        paint,
      );
    } else {
      double degree = -90;
      double arc = 360 / statusNum!;
      for (int i = 0; i < statusNum!; i++) {
        canvas.drawArc(
          Rect.fromLTWH(0, 0, size.width, size.height),
          degreeToAngle(degree + 4),
          degreeToAngle(arc - 8),
          false,
          paint,
        );
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
