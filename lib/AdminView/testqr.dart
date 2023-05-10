// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:qr_flutter/qr_flutter.dart';
//
// class QRCodePDFGenerator extends StatefulWidget {
//   final String qrData;
//
//   QRCodePDFGenerator({required this.qrData});
//
//   @override
//   _QRCodePDFGeneratorState createState() => _QRCodePDFGeneratorState();
// }
//
// class _QRCodePDFGeneratorState extends State<QRCodePDFGenerator> {
//   late String _fileName;
//   late String _localPath;
//
//   Future<void> generatePDF() async {
//     final pdf = pw.Document();
//     final qrImage = await QrPainter(
//       data: widget.qrData,
//       version: QrVersions.auto,
//       gapless: false,
//       color: Color(0xFF000000),
//       emptyColor: Color(0xFFFFFFFF),
//     ).toImageData(200.0);
//
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Center(
//             child: pw.Image(
//             ),
//           );
//         },
//       ),
//     );
//
//     final bytes = await pdf.save();
//     final file = File('$_localPath/$_fileName');
//     await file.writeAsBytes(bytes);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code PDF Generator'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Click the button to generate and download the QR code as a PDF.'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Generate PDF'),
//               onPressed: () async {
//                 final directory = await getApplicationDocumentsDirectory();
//                 _localPath = directory.path;
//                 _fileName = 'qr_code.pdf';
//                 await generatePDF();
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF saved to $_localPath/$_fileName')));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
