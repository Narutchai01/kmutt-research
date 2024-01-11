import 'package:flutter/material.dart';
import 'dart:async' show Completer, Future;
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
  List<String> imagePaths = ["original", "img-2", "img-1", "img-3"];
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
            child: ImageWithSquare(
              selectedCarParts: selectedCarParts,
              imagePaths: imagePaths,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWithSquare extends StatelessWidget {
  final List<String> selectedCarParts;
  final List<String> imagePaths;

  ImageWithSquare({
    required this.selectedCarParts,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
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

              List<Map<dynamic, dynamic>> filteredPredictionsList =
                  predictionsList
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

              return FutureBuilder<ImageInfo>(
                future: getImageSize(imagePaths[index]),
                builder: (context, imageSizeSnapshot) {
                  if (imageSizeSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (imageSizeSnapshot.hasError) {
                    return Text(
                        'Error getting image size: ${imageSizeSnapshot.error}');
                  } else {
                    ImageInfo imageInfo = imageSizeSnapshot.data!;
                    Size imageSize = Size(imageInfo.image.width.toDouble(),
                        imageInfo.image.height.toDouble());
                    print('Image size: $imageSize');

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Positioned widget with an Image
                        Positioned(
                          top: 0,
                          width: imageSize.width / 1.4,
                          height: imageSize.height / 1.4,
                          child: Image.asset(
                            'assets/${imagePaths[index]}.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Loop through filteredPredictionsList and add Positioned widgets for polygons
                        for (var i = 0; i < filteredPredictionsList.length; i++)
                          if (selectedCarParts.contains("All") ||
                              selectedCarParts.contains(
                                  filteredPredictionsList[i]['class']))
                            Positioned(
                              top: 0,
                              width: imageSize.width / 1.4,
                              height: imageSize.height / 1.4,
                              child: CustomPaint(
                                painter: PolygonPainter(
                                  points: filteredPointspolyList[i],
                                  color: getColor(
                                      filteredPredictionsList[i]['class']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        Stack(
                          children: [
                            Positioned(
                              width: imageSize.width,
                              height: imageSize.height,
                              left: -imageSize.width / 10,
                              top: -imageSize.height / 20,
                              child: Container(
                                child: Stack(
                                  children: [
                                    for (var i = 0;
                                        i < filteredPredictionsList.length;
                                        i++)
                                      if (selectedCarParts.contains("All") ||
                                          selectedCarParts.contains(
                                              filteredPredictionsList[i]
                                                  ['class']))
                                        OverlayText(
                                          imageSize: imageSize,
                                          x: filteredPredictionsList[i]['x']
                                                  ?.toDouble() ??
                                              0.0,
                                          y: filteredPredictionsList[i]['y']
                                                  ?.toDouble() ??
                                              0.0,
                                          width: filteredPredictionsList[i]
                                                      ['width']
                                                  ?.toDouble() ??
                                              0.0,
                                          height: filteredPredictionsList[i]
                                                      ['height']
                                                  ?.toDouble() ??
                                              0.0,
                                          predictionClass:
                                              filteredPredictionsList[i]
                                                  ['class'],
                                          confidence: filteredPredictionsList[i]
                                                      ['confidence']
                                                  ?.toDouble() ??
                                              0.0,
                                        ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              );
            }
          },
        );
      },
    );
  }

  Future<ImageInfo> getImageSize(String imagePath) async {
    final Completer<ImageInfo> completer = Completer<ImageInfo>();
    final ImageStream stream =
        AssetImage('assets/$imagePath.jpg').resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener(
      (ImageInfo imageInfo, bool synchronousCall) {
        if (!completer.isCompleted) {
          completer.complete(imageInfo);
        }
      },
      onError: (dynamic exception, StackTrace? stackTrace) {
        if (!completer.isCompleted) {
          completer.completeError(exception, stackTrace);
        }
      },
    );
    stream.addListener(listener);
    completer.future.then((_) {
      stream.removeListener(listener);
    });
    return completer.future;
  }
}

class OverlayText extends StatelessWidget {
  final double x;
  final double y;
  final double width;
  final double height;
  final String predictionClass;
  final double confidence;
  final Size imageSize;

  OverlayText({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.predictionClass,
    required this.confidence,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Positioned(
      top: (y / 1.4),
      left: (x / 1.4),
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

class PolygonPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;

  PolygonPainter({
    required this.points,
    required this.color,
    required BoxFit fit,
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
    return Color.fromRGBO(251, 171, 171, 0.5);
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
  } else if (path == "Windshield") {
    return Color.fromRGBO(100, 147, 235, 128);
  } else if (path == "Headlight") {
    return Color.fromRGBO(137, 0, 137, 128);
  } else if (path == "Grille") {
    return Color.fromRGBO(134, 97, 150, 0.786);
  } else if (path == "Hood") {
    return Color.fromRGBO(255, 68, 0, 128);
  } else if (path == "License-plate") {
    return Color.fromRGBO(147, 99, 108, 0.612);
  } else if (path == "Back-door") {
    return Color.fromRGBO(255, 128, 0, 128);
  }

  return Colors.red;
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
