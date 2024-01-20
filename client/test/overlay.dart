import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async' show Completer, Future;
import 'package:flutter/services.dart' show  rootBundle;
import 'dart:convert';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'pdf.dart';
void main() => runApp(MyApp());
Future<String> getJson(String imagePath) async {
  return await rootBundle.loadString('assets/$imagePath.json');
}
Future<Uint8List> getImage(String imagePath) async {
  try {
    final data = await rootBundle.load('assets/$imagePath.jpg');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  } catch (error) {
    print('Error loading image: $error');
    throw error; 
  }
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
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> carPartList;
  final List<String> selectedFilters;
  final Function(List<String>) onFiltersChanged;
 
  MyAppBar({
    required this.carPartList,
    required this.selectedFilters,
    required this.onFiltersChanged,
   
  });

  @override
  Widget build(BuildContext context) {
    carPartList.sort();
    bool isAllSelected = selectedFilters.contains('All');

    return AppBar(
      actions: [
        Row(
          children: [
            ElevatedButton(
               onPressed: () {
                List<String> newFilters = List.from(selectedFilters);
                if (isAllSelected) {
                  newFilters.remove('All');
                } else {
                  newFilters.add('All');
                }
                onFiltersChanged(newFilters);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isAllSelected ? Colors.grey : Colors.blue,
              ),
              child: Text(isAllSelected ? 'Clear All' : 'All'),
            ),
          ],
        ),
        MultiSelectDialogField(
          buttonText: Text("Filter"),
          title: Text("Select Filters"),
          items: carPartList
              .map((carPart) => MultiSelectItem<String>(
                    carPart,
                    carPart,
                  ))
              .toList(),
          listType: MultiSelectListType.CHIP,
          selectedItemsTextStyle: TextStyle(color: Colors.black),
          selectedColor: Color(0XFF4DC3FF),
          chipDisplay: MultiSelectChipDisplay.none(),
          onConfirm: (values) {
            onFiltersChanged(values.map((e) => e.toString()).toList());
          },
          initialValue: selectedFilters,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> selectedCarParts = [];
  List<String> imagePaths = ["original","img-1","img-2","img-3"];
  List<String> selectedFilters = [];
  List<String> carPartList = [];
  @override
  void initState() {
    super.initState();
    loadCarPartList();
  }

  Future<void> loadCarPartList() async {
    // Load the JSON data for each image and update the carPartList
    for (var imagePath in imagePaths) {
      String jsonContent = await getJson(imagePath);
      Map<String, dynamic> jsonData = json.decode(jsonContent);

      List<Map<dynamic, dynamic>> predictionsList =
          (jsonData['predictions'] as List<dynamic>)
              .cast<Map<dynamic, dynamic>>();

      for (var prediction in predictionsList) {
        String carPart = prediction['class'];
        if (!carPartList.contains(carPart)) {
          carPartList.add(carPart);
        }
      }
    }

    setState(() {
      selectedFilters = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Image Demo"),
      ),
      body: Column(
        children: [
          MyAppBar(
            carPartList: carPartList,
            selectedFilters: selectedFilters,
            onFiltersChanged: (List<String> newFilters) {
              setState(() {
                    selectedCarParts = newFilters;
              });
            },
          ),
          Expanded(
            child: ImageWithSquare(
              selectedCarParts: selectedCarParts,
              imagePaths: imagePaths,
            ),
          ),
          PDFProvider(
            imagePaths: imagePaths, 
            selectedCarParts: ["All"],),
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
class PDFProvider extends StatelessWidget {
  final List<String> imagePaths;
  final List<String> selectedCarParts;

  PDFProvider({
    required this.imagePaths,
    required this.selectedCarParts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Container(
        child: Center(
          child: ElevatedButton(
            child: Text("Create PDF"),
            onPressed: _createPDF,
          ),
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    PdfPage page = document.pages.add();
    for (var imagePath in imagePaths) {
      
      Uint8List imageData = await getImage(imagePath);
      PdfBitmap baseImage = PdfBitmap(imageData);
      page.graphics.drawImage(
        baseImage,
        Rect.fromLTWH(0, 0, 0, 0),
      );
    }
    List<int> bytes = document.saveSync();
    document.dispose();
    saveAndLaunchFile(bytes, "Output.pdf");
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
Color getColor(String path) {
  return carPartColors[path] ?? Colors.red;
}
List<String> carPartList = [
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