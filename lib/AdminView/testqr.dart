import 'dart:io';

import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:file_picker/file_picker.dart';

class DownloadQRCodePDF extends StatefulWidget {
  const DownloadQRCodePDF({Key? key}) : super(key: key);

  @override
  _DownloadQRCodePDFState createState() => _DownloadQRCodePDFState();
}

class _DownloadQRCodePDFState extends State<DownloadQRCodePDF> {
  String? _filePath;
  final file = File('qr_code.pdf');

  Future<void> _downloadPDF() async {
    final pdf = pdfWidgets.Document();
    final qrCodeNew = Consumer<AdminProvider>(
      builder: (context,value,child) {
        return QrImage(
          data: value.encrypt(value.qrData),
          version: QrVersions.auto,
          size: 200.0,
        );
      }
    );

    pdf.addPage(
      pdfWidgets.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pdfWidgets.BarcodeWidget(
              data: qrCodeNew.toString(),
              barcode: pdfWidgets.Barcode.qrCode(),
              width: 100,
              height: 50
          );
        },
      ),
    );



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download QR Code as PDF'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _downloadPDF,
          child: Text('Download QR Code PDF'),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
//
// class PDFDownloader extends StatefulWidget {
//   final String pdfUrl;
//
//   PDFDownloader({required this.pdfUrl});
//
//   @override
//   _PDFDownloaderState createState() => _PDFDownloaderState();
// }
//
// class _PDFDownloaderState extends State<PDFDownloader> {
//   bool downloading = false;
//   String? progressMessage;
//   late String _fileName;
//   late String _localPath;
//
//   Future<void> downloadFile(String url, String fileName) async {
//     setState(() {
//       downloading = true;
//       progressMessage = 'Downloading file...';
//     });
//
//     final response = await http.get(Uri.parse(url));
//     final documentDirectory = await getApplicationDocumentsDirectory();
//
//     _localPath = documentDirectory.path;
//     _fileName = fileName;
//
//     final file = File('$_localPath/$_fileName');
//     await file.writeAsBytes(response.bodyBytes);
//
//     setState(() {
//       downloading = false;
//       progressMessage = 'Download completed.';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Downloader'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(downloading ? progressMessage! : 'Click the button to download the PDF file.'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Download PDF'),
//               onPressed: () {
//                 downloadFile(widget.pdfUrl, 'my_file.pdf');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
