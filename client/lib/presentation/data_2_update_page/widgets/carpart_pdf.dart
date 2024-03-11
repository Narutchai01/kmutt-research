import 'dart:ui';
import 'overlay.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> overlaycarPart(
    PdfPage page, int nPart, List<dynamic> reportData) async {
  for (var i = 0; i < nPart; i++) {
    String partName = reportData[i]['class'];
    List<dynamic> points = reportData[i]['points'];
    List<Offset> offsetPoints = points.map<Offset>((point) {
      final x = (point['x'] / 2.4) + 125;
      final y = (point['y'] / 2.4) + 217;
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
      brush: PdfSolidBrush(getColorPDF(partName)),
    );
  }
}

Future<void> overlaytextcarpart(
    PdfPage page, int nPart, List<dynamic> reportData) async {
  PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
  for (var i = 0; i < nPart; i++) {
    String partName = reportData[i]['class'];
    double confidence = reportData[i]['confidence'];
    List<dynamic> points = reportData[i]['points'];
    List<Offset> offsetPoints = points.map<Offset>((point) {
      final x = (point['x'] / 2.4) + 125;
      final y = (point['y'] / 2.4) + 217;
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

    double x = dxpoint;
    double y = dypoint;
    Size textSize = font.measureString(
      '$partName - ${(confidence * 100).toStringAsFixed(0)}%',
    );
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(
          31,
          0,
          0,
        )),
        bounds: Rect.fromLTWH(x, y, textSize.width, textSize.height));
    page.graphics.drawString(
      '$partName - ${(confidence * 100).toStringAsFixed(0)}%',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromPoints(
        Offset(x, y),
        Offset(x + 1000, y + 1000),
      ),
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
    );
  }
}
