import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ModuleBackground extends StatelessWidget {
  final String moduleId;
  final Widget child;

  const ModuleBackground({
    super.key,
    required this.moduleId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ModuleBackgroundPainter(),
      child: child,
    );
  }
}

class _ModuleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    
    // Use consistent gradient colors for all cards
    final colors = [
      AppColors.appBarBg,
      AppColors.appBarBg.withOpacity(0.7),
    ];
    
    // Create gradient
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );
    
    paint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
    
    // Draw minimalistic pattern
    _drawPattern(canvas, size);
  }

  void _drawPattern(Canvas canvas, Size size) {
    final patternPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    // Draw circles pattern
    final radius = size.width * 0.15;
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      radius,
      patternPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.8),
      radius * 0.7,
      patternPaint,
    );
    
    // Draw lines pattern
    final linePaint = Paint()
      ..color = AppColors.primary.withOpacity(0.1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.3),
      Offset(size.width * 0.4, size.height * 0.3),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.7),
      Offset(size.width * 0.9, size.height * 0.7),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

