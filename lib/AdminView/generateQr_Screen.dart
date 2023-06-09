import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:qr_widget/qr_widget.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';

class GenerateQrScreen extends StatelessWidget {
  List qrDatasList;
  String qrId;
  String fromPlace;
  String toPlace;

  GenerateQrScreen(
      {Key? key,
      required this.qrDatasList,
      required this.qrId,
      required this.fromPlace,
      required this.toPlace,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: scanbkgrnd,
      appBar: AppBar(
        backgroundColor: themecolor,
        title: const Text(
          "Qr Codes",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                generatePDF(qrDatasList, fromPlace, toPlace);
              },
              child: Container(
                alignment: Alignment.center,
                width: 90,
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Download",
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                    Icon(
                      Icons.download_outlined,
                      color: Colors.red,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<AdminProvider>(builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .04,
              ),
              GridView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(left: 10,right: 10,),

                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: qrDatasList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final qrCodeValue = qrDatasList[index];
                    return Column(
                      children: [
                        Text(
                          (index + 1).toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 8,) ,
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsetsDirectional.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white60,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          height: 180,

                          child: QrImageView(
                            data: value.encrypt(qrCodeValue),
                            version: QrVersions.auto,
                          ),
                        ),
                        SizedBox(height: 5,) ,

                        Text(
                          qrId,
                          style: const TextStyle(fontSize: 13),
                        ),
                        // RichText(text: TextSpan(text:toPlace,  style: DefaultTextStyle.of(context).style,
                        //     children:[
                        //       TextSpan( text: "  to  ", style: DefaultTextStyle.of(context).style,
                        //     ), TextSpan( text: fromPlace, style: DefaultTextStyle.of(context).style,
                        //     )
                        //     ]
                        //
                        // ),),
                      ],
                    );
                  }),
            ],
          );
        }),
      ),
    );
  }

  Future generatePDF(List qrDataLists,String fromPlace,String toPlace) async {
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
                      pw.Container(

                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black),
                          borderRadius: pw.BorderRadius.all(pw.Radius.circular(12,),
                          ),

                        ),
                        child: pw.Column(
                          children: [
                            pw.SizedBox(height: 25),
                            pw.Text('QR code for $qrCodeValue'),
                            pw.SizedBox(height: 20),
                            pw.Center(
                              child: pw.Container(
                                width: 250,
                                height: 250,
                                child: pw.BarcodeWidget(
                                    data: qrCodeValue,
                                    barcode: pw.Barcode.qrCode(),
                                    width: 200,
                                    height: 200),
                              ),
                            ),

                            pw.SizedBox(height: 15),
                            pw.RichText(text: pw.TextSpan(text:toPlace,
                                children:[
                                  pw.TextSpan( text: "  to  ",
                                  ), pw.TextSpan( text: fromPlace,
                                  )
                                ]

                            ),),

                            pw.SizedBox(height: 30),
                          ]

                        )

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
    File file = File("$documentPath/Qrcode.pdf");
    return await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
