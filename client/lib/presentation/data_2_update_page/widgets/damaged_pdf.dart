import 'dart:ui';
import 'damage.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> overlaycardamaged(PdfPage page, int nDamage, List<dynamic> reportDamageData) async {
  for(var i = 0 ; i < nDamage ; i++){
     String type = reportDamageData[i]['class'];
     List<dynamic> points = reportDamageData[i]['points'];
     List<Offset> offsetPoints = points.map<Offset>((point) {
        final x = (point['x'] / 2.4) + 125;
        final y = (point['y'] / 2.4) + 362;
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
Future<void> overlaytextdamage(PdfPage page, int nDamage, List<dynamic> reportDamageData) async {
  PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
  for(var i = 0 ; i < nDamage ; i++){
    String type = reportDamageData[i]['class'];
    double confidence = reportDamageData[i]['confidence'];
    double x = ((reportDamageData[i]['points'][0]['x'] / 2.4 ) + 125)?.toDouble() ?? 0.0;
    double y = ((reportDamageData[i]['points'][0]['y'] / 3 ) + 362)?.toDouble() ?? 0.0;
    Size textSize = font.measureString(
      '$type - ${(confidence * 100).toStringAsFixed(0)}%',
    );
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(31, 0, 0,)),
      bounds: Rect.fromLTWH(x, y, textSize.width, textSize.height)
    );
     page.graphics.drawString(
        '$type - ${(confidence * 100).toStringAsFixed(0)}%',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromPoints(
          Offset(x, y),
          Offset(x + 1000, y + 1000),
        ),
        brush: PdfSolidBrush(PdfColor(255, 255, 255)),
      );
  }
}

