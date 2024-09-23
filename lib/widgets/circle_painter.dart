import 'package:flutter/material.dart';
import '../gen/colors.gen.dart';

class HalfCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorName.white
      ..style = PaintingStyle.fill;

    // Define the radius of each half-circle
    double radius = 8.0;
    double spacing = 3.0; // Spacing between each circle
    double offsetY = size.height + radius * 1.1; // Adjust Y position to bottom of container

    for (double x = 0; x < size.width; x += radius * 2 + spacing) {
      // Draw semi-circles
      canvas.drawCircle(
        Offset(x + radius, offsetY),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No repainting needed for this static design
  }
}
