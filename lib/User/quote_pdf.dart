import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class QuotePdf {
  static Future<Uint8List> generate({
    required String companyName,
    required String requestId,
    required String date,
    required String quantity,
    required String service,
    required String width,
    required String height,
    required String unit,
    required String installation,
    required double area,
    required double rate,
    required double total,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment:
                pw.CrossAxisAlignment.start,
            children: [
              // HEADER
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(24),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#161616'),
                  borderRadius:
                      pw.BorderRadius.circular(12),
                ),
                child: pw.Column(
                  crossAxisAlignment:
                      pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      companyName,
                      style: pw.TextStyle(
                        color: PdfColor.fromHex(
                          '#E8A93E',
                        ),
                        fontSize: 20,
                        fontWeight:
                            pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      'QUOTATION REQUEST',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 25,
                        fontWeight:
                            pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      'Professional Service Request',
                      style: pw.TextStyle(
                        color: PdfColors.grey400,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 25),

              pw.Row(
                mainAxisAlignment:
                    pw.MainAxisAlignment.spaceBetween,
                children: [
                  _infoItem(
                    'REQUEST ID',
                    requestId,
                  ),
                  _infoItem(
                    'DATE',
                    date,
                  ),
                ],
              ),

              pw.SizedBox(height: 28),

              _sectionTitle('CUSTOMER DETAILS'),

              pw.SizedBox(height: 12),

              _detailRow(
                'Quantity',
                quantity,
              ),

              _detailRow(
                'Requested Service',
                service,
              ),

              pw.SizedBox(height: 25),

              _sectionTitle('SERVICE REQUIREMENTS'),

              pw.SizedBox(height: 12),

              _detailRow(
                'Quantity',
                quantity,
              ),

              _detailRow(
                'Width',
                width,
              ),

              _detailRow(
                'Height',
                height,
              ),

              _detailRow(
                'Measurement Unit',
                unit,
              ),

              _detailRow(
                'Installation',
                installation,
              ),

              pw.SizedBox(height: 25),

              _sectionTitle('PRICE DETAILS'),

              pw.SizedBox(height: 12),

              _detailRow(
                'Area',
                '${area.toStringAsFixed(2)} sq ft',
              ),

              _detailRow(
                'Rate',
                'AED ${rate.toStringAsFixed(2)} / sq ft',
              ),

              _detailRow(
                'Total Price',
                'AED ${total.toStringAsFixed(2)}',
              ),

              pw.SizedBox(height: 30),

              pw.Container(
                width: double.infinity,
                padding:
                    const pw.EdgeInsets.all(18),
                decoration: pw.BoxDecoration(
                  color:
                      PdfColor.fromHex('#F7F7F7'),
                  borderRadius:
                      pw.BorderRadius.circular(10),
                  border: pw.Border.all(
                    color:
                        PdfColor.fromHex('#E8A93E'),
                    width: 1,
                  ),
                ),
                child: pw.Text(
                  'Thank you for your request. Our team '
                  'will review the provided requirements '
                  'and contact you with the quotation '
                  'and further details.',
                  style: pw.TextStyle(
                    color:
                        PdfColor.fromHex('#333333'),
                    fontSize: 11,
                    lineSpacing: 4,
                  ),
                ),
              ),

              pw.Spacer(),

              pw.Divider(
                color:
                    PdfColor.fromHex('#DDDDDD'),
              ),

              pw.SizedBox(height: 10),

              pw.Row(
                mainAxisAlignment:
                    pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    companyName,
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight:
                          pw.FontWeight.bold,
                      color:
                          PdfColor.fromHex(
                        '#333333',
                      ),
                    ),
                  ),
                  pw.Text(
                    'WhatsApp: +92 315 2635232',
                    style: pw.TextStyle(
                      fontSize: 9,
                      color:
                          PdfColor.fromHex(
                        '#666666',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _infoItem(
    String title,
    String value,
  ) {
    return pw.Column(
      crossAxisAlignment:
          pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 8,
            color:
                PdfColor.fromHex('#999999'),
            fontWeight:
                pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight:
                pw.FontWeight.bold,
            color:
                PdfColor.fromHex('#222222'),
          ),
        ),
      ],
    );
  }

  static pw.Widget _sectionTitle(
    String title,
  ) {
    return pw.Container(
      width: double.infinity,
      padding:
          const pw.EdgeInsets.only(bottom: 8),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color:
                PdfColor.fromHex('#E8A93E'),
            width: 1.5,
          ),
        ),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 13,
          fontWeight:
              pw.FontWeight.bold,
          color:
              PdfColor.fromHex('#222222'),
        ),
      ),
    );
  }

  static pw.Widget _detailRow(
    String title,
    String value,
  ) {
    return pw.Container(
      padding:
          const pw.EdgeInsets.symmetric(
        vertical: 9,
      ),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color:
                PdfColor.fromHex('#EEEEEE'),
            width: 0.7,
          ),
        ),
      ),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 150,
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontSize: 10,
                color:
                    PdfColor.fromHex(
                  '#777777',
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value.isEmpty
                  ? 'Not provided'
                  : value,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight:
                    pw.FontWeight.bold,
                color:
                    PdfColor.fromHex(
                  '#222222',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}