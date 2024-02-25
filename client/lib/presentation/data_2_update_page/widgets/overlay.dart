import 'package:flutter/material.dart';

class ImageOverlay extends StatelessWidget {
  final String imageUrl;
  final List<dynamic> data;
  final int nPart;

  const ImageOverlay({
    required this.imageUrl,
    required this.data,
    required this.nPart
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
          width: 273 ,
          height: 180 ,
          child: CustomPaint(
            painter: PolygonPainter(
                          data: data,
                          nPart: nPart
                          ),
          ),
        ),
        ...data.map((partData){
          final double x = partData['x1'];
          final double y = partData['y1'];
          final String partName = partData['class'];
          final double confidence = partData['confidence'];
          return OverlayText(
            partName: partName, 
            confidence: confidence,
            x: x,
            y: y
          );
        }).toList(),
      ],
    );
  }
}

class PolygonPainter extends CustomPainter {
  final List<dynamic> data;
  final int nPart;

  PolygonPainter({
    required this.data,
    required this.nPart,
  });

  @override
  void paint(Canvas canvas, Size size) {

    for (var i = 0; i < nPart; i++) {
      final List<dynamic> points = data[i]['points'];
      final String partName = data[i]['class'];
      final Color partColor = getColor(partName);
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
        ..color = partColor
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
  final String partName;
  final double confidence;
  final double x;
  final double y;

  OverlayText({
    required this.partName,
    required this.confidence,
    required this.x,
    required this.y
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
      top: ((x*1000)/ 2.4),
      left: ((y*1000) / 2.4),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(31, 0, 0, 0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$partName',
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 255, 255, 255),
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
    ));
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
List<String> carPartList = [
  "All",
  "Back-bumper",
  "Back-door",
  "Back-wheel",
  "Back-window",
  "Back-windshield",
  "Fender",
  "Front-bumper",
  "Front-door",
  "Front-wheel",
  "Front-window",
  "Grille",
  "Headlight",
  "Hood",
  "License-plate",
  "Mirror",
  "Quarter-panel",
  "Roof",
  "Rocker-panel",
  "Tail-light",
  "Trunk",
  "Wind-shield"
];
