import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ImageOverlay extends StatelessWidget {
  final String imageUrl;
  final List<dynamic> data;
  final int nPart;
  final List<dynamic> selectedParts;
  final List<dynamic> size;

  const ImageOverlay({
    required this.imageUrl,
    required this.data,
    required this.nPart,
    required this.selectedParts, 
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 273,
          height: 180,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover
          ),
        ),
        ...data.map((partData) {
          final String partName = partData['namePart'];
          final String className = partData['class'];
          final bool isSelected =
              selectedParts.any((part) => part.name == partName);
          if (isSelected) {
            final List<dynamic> points = partData['points'];
            final int lengthY = size[0] ;
            final int lengthX = size[1] ;
            
            final List<Offset> offsetPoints = points.map<Offset>((point) {
              final x = ( point['x'] * 273 ) / lengthX  ?? 0.0;
              final y = ( point['y'] * 180 ) / lengthY ?? 0.0;
              return Offset(x.toDouble(), y.toDouble());
            }).toList();

            final List xpoints = offsetPoints.map((point) => point.dx).toList();
            final List ypoints = offsetPoints.map((point) => point.dy).toList();
            double sum(List<dynamic> list) {
              double total = 0.0;
              for (double value in list) {
                total += value;
              }
              return total;
            }

            double dxpoint = sum(xpoints) / xpoints.length;
            double dypoint = sum(ypoints) / ypoints.length;

            final path = Path();
            path.moveTo(offsetPoints[0].dx, offsetPoints[0].dy);
            for (var j = 1; j < offsetPoints.length; j++) {
              path.lineTo(offsetPoints[j].dx, offsetPoints[j].dy);
            }
            path.close();
            final paint = Paint()
              ..color = getColor(partName)
              ..strokeWidth = 2
              ..strokeCap = StrokeCap.round;

            return Positioned(
              left: 0 , //-8
              top: 0, //-1.69166666
              child: Center(
                child: SizedBox(
                  width: 273,
                  height: 180,
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: PathPainter(path: path, paintObject: paint),
                      ),
                      OverlayText(
                          damage: className,
                          x: dxpoint,
                          y: dypoint),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        }).toList(),
      ],
    );
  }
}

class PathPainter extends CustomPainter {
  final Path path;
  final Paint paintObject;

  PathPainter({required this.path, required this.paintObject});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path, paintObject);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OverlayText extends StatelessWidget {
  final String damage;
  final double x;
  final double y;

  OverlayText(
      {required this.damage,
      required this.x,
      required this.y});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: y,
      left: x,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(149, 0, 0, 0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$damage',
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const Map<String, Color> carPartColors = {
  "Front-bumper": Color.fromRGBO(251, 171, 171, 0.5),
  "Quarter-panel": Color.fromRGBO(215, 189, 215, 0.502),
  "Tail-light": Color.fromRGBO(217, 112, 145, 0.502),
  "Rocker-panel": Color.fromRGBO(255, 20, 145, 0.502),
  "Front-door": Color.fromRGBO(0, 0, 255, 0.502),
  "Back-wheel": Color.fromRGBO(0, 181, 233, 0.502),
  "Back-bumper": Color.fromRGBO(85, 227, 194, 0.749),
  "Mirror": Color.fromRGBO(0, 255, 255, 0.502),
  "Front-wheel": Color.fromRGBO(159, 82, 44, 0.502),
  "Back-window": Color.fromRGBO(255, 255, 0, 0.502),
  "Fender": Color.fromRGBO(14, 122, 253, 0.502),
  "Trunk": Color.fromRGBO(221, 183, 133, 0.502),
  "Roof": Color.fromRGBO(255, 227, 179, 0.502),
  "Front-window": Color.fromRGBO(128, 128, 0, 0.502),
  "Back-windshield": Color.fromRGBO(255, 0, 255, 0.502),
  "Windshield": Color.fromRGBO(100, 147, 235, 128),
  "Headlight": Color.fromRGBO(137, 0, 137, 128),
  "Grille": Color.fromRGBO(134, 97, 150, 0.786),
  "Hood": Color.fromRGBO(255, 68, 0, 128),
  "License-plate": Color.fromRGBO(147, 99, 108, 0.612),
  "Back-door": Color.fromRGBO(255, 128, 0, 128),
};

Color getColor(String partName) {
  return carPartColors[partName] ?? Colors.red;
}

PdfColor getColorPDF(String partName) {
  Color color = carPartColors[partName] ?? Colors.red;
  return PdfColor(color.red, color.green, color.blue);
}

class CarPart {
  final String name;
  CarPart(this.name);
}

List<String> carPartList = [];
