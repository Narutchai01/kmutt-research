import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:polygon/polygon.dart';

void main() => runApp(MyApp());

Future<String> getJson() async {
  return await rootBundle.loadString('assets/message.json');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<dynamic, dynamic>> predictionsList = [];
  List<List<Offset>> pointspolyList = [];

  @override
  void initState() {
    super.initState();
    // Call the function to load and overlay predictions when the widget is initialized
    overlayPoints();
  }

  void overlayPoints() async {
    String jsonContent = await getJson();

    // Parse the JSON string
    Map<String, dynamic> jsonData = json.decode(jsonContent);

    predictionsList = (jsonData['predictions'] as List<dynamic>)
        .cast<Map<dynamic, dynamic>>();

    // Iterate over predictionsList to get points from each prediction
    for (var prediction in predictionsList) {
      List<Offset> pointsList =
          (prediction['points'] as List<dynamic>).map((pointObj) {
        double x = pointObj['x']?.toDouble() / 1.4 ?? 0.0;
        double y = pointObj['y']?.toDouble() / 1.4 ?? 0.0;
        return Offset(x, y);
      }).toList();
      pointspolyList.add(pointsList);
    }
    // print(pointspolyList);

    // Update the state to trigger a rebuild
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Image Demo'),
      ),
      body: ImageWithSquare(
        predictionsList: predictionsList,
        pointspolyList: pointspolyList,
      ),
    );
  }
}

class ImageWithSquare extends StatelessWidget {
  final List<Map<dynamic, dynamic>> predictionsList;
  final List<List<Offset>> pointspolyList;

  ImageWithSquare({
    required this.predictionsList,
    required this.pointspolyList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/original.jpg'),
          for (var i = 0; i < predictionsList.length; i++)
            Positioned(
              top: -3,
              left: -3, // Adjust this value for the desired left margin
              child: CustomPaint(
                painter: PolygonPainter(
                  points: pointspolyList[i],
                  color: getColor(predictionsList[i]['class']),
                ),
              ),
            ),
          for (var i = 0; i < predictionsList.length; i++)
            OverlayText(
              x: predictionsList[i]['x']?.toDouble() ?? 0.0,
              y: predictionsList[i]['y']?.toDouble() ?? 0.0,
              width: predictionsList[i]['width']?.toDouble() ?? 0.0,
              height: predictionsList[i]['width']?.toDouble() ?? 0.0,
              predictionClass: predictionsList[i]['class'],
            ),
        ],
      ),
    );
  }
}

class OverlayText extends StatelessWidget {
  final double x;
  final double y;
  final double width;
  final double height;
  final String predictionClass;

  OverlayText({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.predictionClass,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: y - 50,
      left: x - 80,
      child: Container(
        padding: EdgeInsets.all(8.0), // Adjust padding as needed
        decoration: BoxDecoration(
          color: getColor(predictionClass),
          borderRadius:
              BorderRadius.circular(8.0), // Adjust border radius as needed
          border: Border.all(
            color: const Color.fromARGB(60, 0, 0, 0),
            width: 1.0,
          ),
        ),
        child: Text(
          '$predictionClass',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}

class PolygonPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;

  PolygonPainter({
    required this.points,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    path.close();

    canvas.drawPath(
      path,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Color getColor(String path) {
  if (path == "Front-bumper") {
    return Color.fromRGBO(85, 227, 194, 0.749);
  } else if (path == "Quarter-panel") {
    return Color.fromRGBO(215, 189, 215, 0.502);
  } else if (path == "Tail-light") {
    return Color.fromRGBO(217, 112, 145, 0.502);
  } else if (path == "Rocker-panel") {
    return Color.fromRGBO(255, 20, 145, 0.502);
  } else if (path == "Front-door") {
    return Color.fromRGBO(0, 0, 255, 0.502);
  } else if (path == "Back-wheel") {
    return Color.fromRGBO(0, 181, 233, 0.502);
  } else if (path == "Back-bumper") {
    return Color.fromRGBO(85, 227, 194, 0.749);
  } else if (path == "Mirror") {
    return Color.fromRGBO(0, 255, 255, 0.502);
  } else if (path == "Front-wheel") {
    return Color.fromRGBO(159, 82, 44, 0.502);
  } else if (path == "Back-window") {
    return Color.fromRGBO(255, 255, 0, 0.502);
  } else if (path == "Fender") {
    return Color.fromRGBO(14, 122, 253, 0.502);
  } else if (path == "Trunk") {
    return Color.fromRGBO(221, 183, 133, 0.502);
  } else if (path == "Roof") {
    return Color.fromRGBO(255, 227, 179, 0.502);
  } else if (path == "Front-window") {
    return Color.fromRGBO(128, 128, 0, 0.502);
  } else if (path == "Tail-light") {
    return Color.fromRGBO(217, 112, 145, 0.502);
  } else if (path == "Back-windshield") {
    return Color.fromRGBO(255, 0, 255, 0.502);
  }

  return Colors.red;
}
