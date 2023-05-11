import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:qr_widget/qr_widget.dart';
import 'package:qr_widget/qr_widget.dart';
import 'package:qr_widget/qr_widget.dart';
import 'package:qr_widget/qr_widget.dart';
import 'package:qr_widget/qr_widget.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
class GenerateQrScreen extends StatelessWidget {
  List qrDatasList;
  String qrId,name;

   GenerateQrScreen({Key? key,required this.qrDatasList,required this.qrId,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("QQQQQQQQQq"+qrDatasList.toString());
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scanbkgrnd,
      appBar: AppBar(
        backgroundColor: themecolor,
        title: const Text(
          "Qr Codes",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              generatePDF(qrDatasList,name);

            },
            child: Container(
              alignment: Alignment.center,
              width: 90,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)

              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Download",style: TextStyle(color: Colors.red,fontSize: 13),),
                  Icon(Icons.download_outlined,color: Colors.red,size: 20,)
                ],
              ),
            ),
          ),
        )],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<AdminProvider>(
          builder: (context,value,child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height*.05,),

    GridView.builder(
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount:qrDatasList.length,
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
    childAspectRatio: 0.75,
    crossAxisSpacing: 2,
    crossAxisCount: 2),
    itemBuilder: (context, index) {
      final qrCodeValue = qrDatasList[index];
      return Column(
        children: [
          Text((index+1).toString(),style: TextStyle(fontSize: 12),),
          Container(
            height: 180,
            child: QrImageView(
              data: value.encrypt(qrCodeValue),
              version: QrVersions.auto,
              // size: 200,
            ),
          ),
          Text(""+qrId,style: TextStyle(fontSize: 13),),
        ],
      );

    }),



              ],
            );
          }
        ),
      ),
    );
  }


  Future generatePDF(List qrDataLists,String name) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {

          List<pw.Widget> listWidgets = [];
          for (final qrCodeValue in qrDatasList) {
            // Create a new page for each QR code
            pdf.addPage(
              pw.Page(
                build: (context) {
                  return pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.SizedBox(height: 20),
                      pw.Text(name,style: pw.TextStyle(fontSize: 25,fontWeight:pw.FontWeight.bold)),
                      pw.SizedBox(height: 20),

                      pw.Text('QR code for $qrCodeValue'),
                      pw.SizedBox(height: 20),
                      pw.Center(
                        child: pw.Container(
                          width: 250,
                          height: 250,
                          child:pw.BarcodeWidget(
                              data:qrCodeValue,
                              barcode: pw.Barcode.qrCode(),
                              width: 200,
                              height: 200
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return listWidgets;


        },
      ),
    );

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    print(documentPath.toString() + "bbbbbbbbbbbbbbbbb");
    File file = File("$documentPath/Qrcode.pdf");
    print(file.toString() + "vvvvvvvvv");
    return await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());

  }



}
