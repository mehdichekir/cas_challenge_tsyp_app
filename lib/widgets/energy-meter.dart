import 'package:flutter/material.dart';

class DifferenceMeter extends StatelessWidget {
  final double value1;
  final double value2;
  final double maxDifference=300; 
  final String label;

  const DifferenceMeter({
    Key? key,
    required this.value1,
    required this.value2,
    
    this.label = 'Energy',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final difference = value1 - value2;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${difference.toStringAsFixed(1)}kw',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 48,
            child: CustomPaint(
              size: const Size(double.infinity, 48),
              painter: DifferenceMeterPainter(
                difference: difference,
                maxDifference: maxDifference,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '-${maxDifference}kw',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
               Text(
                '0',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              Text(
                '+${maxDifference}kw',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DifferenceMeterPainter extends CustomPainter {
  final double difference;
  final double maxDifference;

  DifferenceMeterPainter({
    required this.difference,
    required this.maxDifference,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    
    final gradient = LinearGradient(
      colors: [
        Colors.red,
        Colors.yellow,  
        Colors.green,
      ],
    );

    paint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    
    final backgroundRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(8),
    );
    canvas.drawRRect(backgroundRRect, paint);
    final position = ((difference + maxDifference) / (2 * maxDifference)) * size.width;
    final clampedPosition = position.clamp(0.0, size.width);

    
    paint
      ..shader = null
      ..color = Colors.white;

    const indicatorWidth = 4.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          clampedPosition - indicatorWidth / 2,
          0,
          indicatorWidth,
          size.height,
        ),
        const Radius.circular(2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}