import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class DamageOverlay extends StatelessWidget {
  final String imageUrl;
  final List<dynamic> data;
  final int nDamage;

  const DamageOverlay({
    required this.imageUrl,
    required this.data,
    required this.nDamage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display the image
        Image.network(
          imageUrl,
          width: 273,
          height: 180,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: -45,
          left: 3,
          width: 273,
          height: 180,
          child: CustomPaint(
            painter: PolygonPainter(
              data: data,
              nDamage: nDamage,
            ),
          ),
        ),
         ...data.map((partData) {
            final double x = partData['x1'];
            final double y = partData['y1'];
            final double confidence = partData['confidence'];
            final String type = partData['class'];
            return OverlayText(
              type: type,
              confidence: confidence,
              x: x,
              y: y,
            );
        }).toList(),
      ],
    );
  }
}

class PolygonPainter extends CustomPainter {
  final List<dynamic> data;
  final int nDamage;
  PolygonPainter({
    required this.data,
    required this.nDamage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < nDamage; i++) {
      final List<dynamic> points = data[i]['points'];
      final String type = data[i]['class'];
      final Color typeColor = getColor(type);
      final List<Offset> offsetPoints = points.map<Offset>((point) {
        final x = point['x'] / 2.4;
        final y = point['y'] / 2.4;
        return Offset(x.toDouble(), y.toDouble());
      }).toList();

      final path = Path();
      path.moveTo(offsetPoints[0].dx, offsetPoints[0].dy);
      for (var j = 1; j < offsetPoints.length; j++) {
        path.lineTo(offsetPoints[j].dx, offsetPoints[j].dy);
      }
      path.close();
      final paint = Paint()
        ..color = typeColor
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OverlayText extends StatelessWidget {
  final String type;
  final double confidence;
  final double x;
  final double y;

  OverlayText({
    required this.type,
    required this.confidence,
    required this.x,
    required this.y,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        top: ((x * 100) / 2.4),
        left: ((y * 100) / 2.4),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(31, 0, 0, 0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$type',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              Text(
                '  ${(confidence * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const Map<String, Color> damageColors = {
  "car-part-crack": Color.fromRGBO(0,255,205,12),
  "deformation": Color.fromRGBO(255, 68, 0, 128),
  "flat-tire": Color.fromRGBO(255,128,0,128),
  "glass-crack": Color.fromRGBO(255, 20, 145, 0.502),
  "lamp-crack": Color.fromRGBO(0, 0, 255, 0.502),
  "scratch": Color.fromRGBO(197,251,0,128),
  "side-mirror-crack": Color.fromRGBO(85, 227, 194, 0.749),
};

Color getColor(String type) {
  return damageColors[type] ?? Colors.red;
}
PdfColor getColorPDF(String type) {
  Color color = damageColors[type] ?? Colors.red;
  return PdfColor(color.red, color.green, color.blue);
}

