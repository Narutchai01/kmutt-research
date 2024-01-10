import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() => runApp(MyApp());

Future<String> getJson(String imagePath) async {
  return await rootBundle.loadString('assets/$imagePath.json');
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
  List<String> selectedCarParts = ["All"];
  List<String> imagePaths = ["original", "img-2","img-1"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Image Demo"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carPartList.length,
              itemBuilder: (context, index) {
                final carPart = carPartList[index];
                return CheckboxListTile(
                  title: Text(carPart),
                  value: selectedCarParts.contains(carPart),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        if (value) {
                          selectedCarParts.add(carPart);
                        } else {
                          selectedCarParts.remove(carPart);
                        }
                      }
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ImageWithSquare(selectedCarParts: selectedCarParts, imagePaths: imagePaths),
          ),
        ],
      ),
    );
  }
}

class ImageWithSquare extends StatelessWidget {
  final List<String> selectedCarParts;
  final List<String> imagePaths;
  ImageWithSquare({required this.selectedCarParts, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: imagePaths.length,
      itemBuilder: (context, index){
      return 
       FutureBuilder(
        future: getJson(imagePaths[index]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String jsonContent = snapshot.data.toString();
            Map<String, dynamic> jsonData = json.decode(jsonContent);

            List<Map<dynamic, dynamic>> predictionsList =
                (jsonData['predictions'] as List<dynamic>)
                    .cast<Map<dynamic, dynamic>>();

            List<List<Offset>> pointspolyList = [];
            for (var prediction in predictionsList) {
              List<Offset> pointsList =
                  (prediction['points'] as List<dynamic>).map((pointObj) {
                double x = pointObj['x']?.toDouble() / 1.4 ?? 0.0;
                double y = pointObj['y']?.toDouble() / 1.4 ?? 0.0;
                return Offset(x, y);
              }).toList();
              pointspolyList.add(pointsList);
            }

            List<Map<dynamic, dynamic>> filteredPredictionsList = predictionsList
                .where((prediction) =>
                    selectedCarParts.contains("All") ||
                    selectedCarParts.contains(prediction['class']))
                .toList();

            List<List<Offset>> filteredPointspolyList = [];

            pointspolyList.asMap().forEach((i, points) {
              if (selectedCarParts.contains("All") ||
                selectedCarParts.contains(predictionsList[i]['class'])) {
              filteredPointspolyList.add(points);
              }
            });

            return Stack(
              alignment: Alignment.center,
              children: [
              Container(
                width: 390,
                height: 350,
                child: Image.asset(
                  'assets/${imagePaths[index]}.jpg',
                fit: BoxFit.fitWidth,
                ),
              ),
                for (var i = 0; i < filteredPredictionsList.length; i++)
                  if (selectedCarParts.contains("All") ||
                      selectedCarParts.contains(filteredPredictionsList[i]['class']))
                    Positioned(
                      top: 22,
                      left: -5,
                      child: CustomPaint(
                        painter: PolygonPainter(
                          points: filteredPointspolyList[i],
                          color: getColor(filteredPredictionsList[i]['class']),
                        ),
                      ),
                    ),
                for (var i = 0; i < filteredPredictionsList.length; i++)
                  if (selectedCarParts.contains("All") ||
                      selectedCarParts.contains(filteredPredictionsList[i]['class']))
                    OverlayText(
                      x: filteredPredictionsList[i]['x']?.toDouble() ?? 0.0,
                      y: filteredPredictionsList[i]['y']?.toDouble() ?? 0.0,
                      width: filteredPredictionsList[i]['width']?.toDouble() ?? 0.0,
                      height: filteredPredictionsList[i]['width']?.toDouble() ?? 0.0,
                      predictionClass: filteredPredictionsList[i]['class'],
                      confidence: filteredPredictionsList[i]['confidence']?.toDouble() ?? 0.0,
                ),
              ],
            );
          }
        },
       );
      },
    );
  }
}

class OverlayText extends StatelessWidget {
  final double x;
  final double y;
  final double width;
  final double height;
  final String predictionClass;
  final double confidence;

  OverlayText({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.predictionClass,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (y/1.15),
      left: (x/1.65)-20,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(31, 0, 0, 0),
          
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$predictionClass',
              style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            Text(
              '  ${(confidence * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
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

List<String> carPartList = [
  "All",
  "Front-bumper",
  "Quarter-panel",
  "Tail-light",
  "Rocker-panel",
  "Front-door",
  "Back-wheel",
  "Mirror",
  "Front-wheel",
  "Back-window",
  "Fender",
  "Trunk",
  "Roof",
  "Front-window",
  "Back-windshield",
  "Back-bumper",
];