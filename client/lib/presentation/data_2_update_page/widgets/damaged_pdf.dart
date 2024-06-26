import 'dart:ui';
import 'damage.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> overlaycardamaged(
    PdfPage page, int nDamage, List<dynamic> reportDamageData , List<dynamic> imagesize) async {
  for (var i = 0; i < nDamage; i++) {
    String type = reportDamageData[i]['class'];
    List<dynamic> points = reportDamageData[i]['points'];
    List<Offset> offsetPoints = points.map<Offset>((point) {
      final x = (point['x'] * 273 / imagesize[1]) + 125;
      final y = (point['y'] * 180 / imagesize[0]) + 458;
      return Offset(x.toDouble(), y.toDouble());
    }).toList();
    final path = Path();
    path.moveTo(offsetPoints[0].dx, offsetPoints[0].dy);
    for (var j = 1; j < offsetPoints.length; j++) {
      path.lineTo(offsetPoints[j].dx, offsetPoints[j].dy);
    }
    path.close();
    page.graphics.drawPolygon(
      offsetPoints,
      brush: PdfSolidBrush(getColorPDF(type)),
    );
  }
}

Future<void> overlaytextdamage(
    PdfPage page, int nDamage, List<dynamic> reportDamageData , List<dynamic> imagesize) async {
  PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
  for (var i = 0; i < nDamage; i++) {
    String type = reportDamageData[i]['class'];
    double confidence = reportDamageData[i]['confidence'];
    List<dynamic> points = reportDamageData[i]['points'];
    List<Offset> offsetPoints = points.map<Offset>((point) {
      final x = (point['x'] * 273 / imagesize[1]) + 223;
      final y = (point['y'] * 180 / imagesize[0]) + 455;
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
    print(dxpoint);
    print(dypoint);

    double x = dxpoint / 1.4;
    double y = dypoint;
    Size textSize = font.measureString(
      '$type - ${(confidence * 100).toStringAsFixed(0)}%',
    );
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(
          31,
          0,
          0,
        )),
        bounds: Rect.fromLTWH(x, y, textSize.width, textSize.height));
    page.graphics.drawString(
      '$type - ${(confidence * 100).toStringAsFixed(0)}%',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromPoints(
        Offset(x, y),
        Offset(x, y + 1000),
      ),
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
    );
  }
}
