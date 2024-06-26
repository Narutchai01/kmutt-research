import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'carpart_pdf.dart';
import 'package:client/presentation/status_update_screen/status_update_screen.dart';

class PDFProvider extends StatelessWidget {
  final List<dynamic> imageUrl;
  final List<dynamic> report;
  final List<dynamic> datatable;
  const PDFProvider(
      {required this.imageUrl, required this.report, required this.datatable});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        fixedSize: const Size(200, 40),
      ),
      onPressed: () {
        generateAndSavePdf(context);
      },
      child: Text('Export to PDF'),
    );
  }
  Future<void> generateAndSavePdf(BuildContext context) async {
    PdfDocument document = PdfDocument();
    PdfPage page = document.pages.add();
    page.graphics.drawString('Car Damaged Report : ',
        PdfStandardFont(PdfFontFamily.helvetica, 30, style: PdfFontStyle.bold));
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 3);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Car Part';
    header.cells[0].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 20),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
        ),
        backgroundBrush: PdfSolidBrush(PdfColor(169, 169, 169)));
    header.cells[1].value = 'Damage Type';
    header.cells[1].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 20),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
        ),
        backgroundBrush: PdfSolidBrush(PdfColor(169, 169, 169)));
    header.cells[2].value = 'Damage Severity';
    header.cells[2].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 20),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
        ),
        backgroundBrush: PdfSolidBrush(PdfColor(169, 169, 169)));
    for (var i = 0; i < datatable.length; i++) {
      if(datatable[i]['Damage_type'] != "None" || datatable[i]['Damage_severity'] != "None"){
        PdfGridRow row = grid.rows.add();
        row.cells[0].value = datatable[i]['Car_part'];
        row.cells[0].style = PdfGridCellStyle(
          font: PdfStandardFont(PdfFontFamily.timesRoman, 20),
          format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
          ),
        );
        row.cells[1].value = datatable[i]['Damage_type'];
        row.cells[1].style = PdfGridCellStyle(
          font: PdfStandardFont(PdfFontFamily.timesRoman, 20),
          format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
          ),
        );
        row.cells[2].value = datatable[i]['Damage_severity'];
        row.cells[2].style = PdfGridCellStyle(
          font: PdfStandardFont(PdfFontFamily.timesRoman, 20),
          format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
          ),
        );
      }
    }
    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 50, 0, 0));
    page.graphics.drawLine(
        PdfPen(PdfColor(0, 0, 0)),
        Offset(0, page.getClientSize().height - 50),
        Offset(page.getClientSize().width, page.getClientSize().height - 50));
    page.graphics.drawString(
      'Report Date : ' + extractDate(caseInfo.Date_opened),
      PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(0, 720, page.getClientSize().width, 0),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.right,
      ),
    );
    for (var i = 0; i < report.length; i++) {
      List<dynamic> imagesize = report[i][report[i].keys.toList()[0]]
          ["image_meta_data"]["orig_shape"];
      int nPart = report[i][report[i].keys.toList()[0]]
          ['car_part_results'].length;
      List<dynamic> reportData = report[i]
          [report[i].keys.toList()[0]]['car_part_results'];
      var imageData = await _getImageData(imageUrl[i]["Image_link"]);
      PdfBitmap image = PdfBitmap(imageData);

      PdfPage page = document.pages.add();
      page.graphics.drawString(
          'Car Damage Picture(s) : ',
          PdfStandardFont(PdfFontFamily.helvetica, 30,
              style: PdfFontStyle.bold));
      page.graphics.drawString(
          'Car Picture : ', PdfStandardFont(PdfFontFamily.helvetica, 18),
          bounds: Rect.fromLTWH(0, 100, 0, 0));
      page.graphics.drawString(
          'Car Damaged : ', PdfStandardFont(PdfFontFamily.helvetica, 18),
          bounds: Rect.fromLTWH(0, 400, 0, 0));
      page.graphics.drawImage(
        image,
        Rect.fromLTWH(125, 105, 273, 180),
      );
      page.graphics.drawImage(
        image,
        Rect.fromLTWH(125, 405, 273, 180),
      );
      overlaycarPart(page, nPart, reportData , imagesize);
      overlaytextcarpart(page, nPart, reportData , imagesize);
      page.graphics.drawLine(
          PdfPen(PdfColor(0, 0, 0)),
          Offset(0, page.getClientSize().height - 50),
          Offset(page.getClientSize().width, page.getClientSize().height - 50));
      page.graphics.drawString(
        'Report Date : ' + extractDate(caseInfo.Date_opened),
        PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(0, 720, page.getClientSize().width, 0),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
        ),
      );
    }
    List<int> bytes = document.saveSync();
    saveAndLaunchFile(bytes, caseInfo.CarID + " " + caseInfo.Province + ".pdf");
  }

  Future<Uint8List> _getImageData(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final imageData = response.bodyBytes;
        print('Image data length: ${imageData.length}');
        final image = img.decodeImage(imageData);
        final pngData = img.encodePng(image!);
        return pngData;
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch image: $e');
    }
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    try {
      if (Platform.isAndroid) {
        final path = (await getExternalStorageDirectory())?.path;
        final file = File('$path/$fileName');
        await file.writeAsBytes(bytes, flush: true);
        OpenFile.open(file.path);
      }
      if (Platform.isIOS) {
        final path = (await getApplicationDocumentsDirectory()).path;
        final file = File('$path/$fileName');
        await file.writeAsBytes(bytes, flush: true);
        OpenFile.open(file.path);
      }
    } catch (e) {
      print('Error saving or opening file: $e');
    }
  }
}

String extractDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}
