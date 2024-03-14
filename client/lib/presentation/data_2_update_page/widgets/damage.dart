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
    double dxpoint = 0.0;
    double dypoint = 0.0;
    return Stack(
      children: [
        // Display the image
        Image.network(
          imageUrl,
          width: 273,
          height: 180,
          fit: BoxFit.contain,
        ),
        Positioned(
          top: -5,
          left: -2,
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
          for (var i = 0; i < nDamage; i++) {
            final List<dynamic> points = partData['points'];
            final List<Offset> offsetPoints = points.map<Offset>((point) {
              final x = point['x'] / 2.3;
              final y = point['y'] / 2.3;
              return Offset(x.toDouble(), y.toDouble());
            }).toList();
            final List<double> xpoints =
                offsetPoints.map((point) => point.dx).toList();
            final List<double> ypoints =
                offsetPoints.map((point) => point.dy).toList();

            double sum(List<double> list) {
              double total = 0.0;
              for (double value in list) {
                total += value;
              }
              return total;
            }

            dxpoint = sum(xpoints) / xpoints.length;
            dypoint = sum(ypoints) / ypoints.length;
          }

          final double confidence = partData['confidence'];
          final String type = partData['class'];
          print(dxpoint);
          print(dypoint);
          return OverlayText(
            type: type,
            confidence: confidence,
            x: dxpoint,
            y: dypoint,
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
        final x = point['x'] / 2.3;
        final y = point['y'] / 2.3;
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
        top: y / 1.4,
        left: x,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(145, 0, 0, 0),
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
  "car-part-crack": Color.fromRGBO(0, 255, 205, 12),
  "deformation": Color.fromRGBO(255, 68, 0, 128),
  "flat-tire": Color.fromRGBO(255, 128, 0, 128),
  "glass-crack": Color.fromRGBO(255, 20, 145, 0.502),
  "lamp-crack": Color.fromRGBO(0, 0, 255, 0.502),
  "scratch": Color.fromRGBO(197, 251, 0, 128),
  "side-mirror-crack": Color.fromRGBO(85, 227, 194, 0.749),
};

Color getColor(String type) {
  return damageColors[type] ?? Colors.red;
}

PdfColor getColorPDF(String type) {
  Color color = damageColors[type] ?? Colors.red;
  return PdfColor(color.red, color.green, color.blue);
}
