import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'carpart_pdf.dart';
import 'damaged_pdf.dart';

class PDFProvider extends StatelessWidget {
  final List<dynamic> imageUrl;
  final Map<String, dynamic> report;

  const PDFProvider({
    required this.imageUrl,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        generateAndSavePdf(context); 
      },
      child: Text('Export to PDF'),
    );
  }

  Future<void> generateAndSavePdf(BuildContext context) async {
    PdfDocument document = PdfDocument();
    for(var i = 0; i < imageUrl.length; i++){
      int nPart = report['report'][0][report['report'][0].keys.toList()[i]]["image_meta_data"]["n_car_parts"];
      int nDamage = report['report'][0][report['report'][0].keys.toList()[i]]["image_meta_data"]["n_car_damages"];
      List<dynamic> reportData = report['report'][0][report['report'][0].keys.toList()[i]]['car_part_results'];
      List<dynamic> reportDamageData = report['report'][0][report['report'][0].keys.toList()[i]]['car_damage_results'];
      Uint8List imageData = await _getImageData(imageUrl[i]["Image_link"]);
      PdfBitmap image = PdfBitmap(imageData);
      PdfPage page = document.pages.add();
      page.graphics.drawImage(
        image,
        Rect.fromLTWH(125, 0, 273, 180),
      );
      page.graphics.drawImage(
        image,
        Rect.fromLTWH(125, 200, 273, 180),
      );
      overlaycarPart(page, nPart,reportData);
      overlaytextcarpart(page, nPart, reportData);
      page.graphics.drawImage(
        image,
        Rect.fromLTWH(125, 400, 273, 180),
      );
      overlaycardamaged(page, nDamage, reportDamageData);
      overlaytextdamage(page, nDamage, reportDamageData);
    }
    List<int> bytes = document.saveSync();
    saveAndLaunchFile(bytes, "Example.pdf");
  }
  Future<Uint8List> _getImageData(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Failed to fetch image: $e');
    }
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    try {
      final path = (await getExternalStorageDirectory())?.path;
      final file = File('$path/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(file.path);
    } catch (e) {
      print('Error saving or opening file: $e');
    }
  }
}
