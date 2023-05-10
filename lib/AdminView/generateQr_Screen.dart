import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
class GenerateQrScreen extends StatelessWidget {
  int qrData;
   GenerateQrScreen({Key? key,required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scanbkgrnd,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<AdminProvider>(
          builder: (context,value,child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height*.05,),

Consumer<AdminProvider>(
  builder: (context,value,child) {
    return     InkWell(
      onTap: (){
        final rand = Random().nextInt(10000000);
        String fileName =
            value.newPath+ "File$rand.pdf";
        value.saveFile(context,value.qrData,fileName);
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            backgroundColor:
            Colors.black,
            duration:
            const Duration(
                milliseconds:
                5000),
            content: Text(
              ' successfully downloaded to '+value.pdfPath,
              style: const TextStyle(
                  color: Colors
                      .white),
            ),
          ),
        );
      },
      child:   Container(
        height: 40,
        width: 100,
        color: Colors.yellowAccent,

      ),
    );
  }
),

    GridView.builder(
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount:qrData,
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
    childAspectRatio: 0.9,
    crossAxisSpacing: 2,
    crossAxisCount: 2),
    itemBuilder: (context, index) {
      return Column(
        children: [
          Text((index+1).toString(),style: TextStyle(fontSize: 12),),
          Container(
            height: 180,
            child: QrImage(
              data: value.encrypt(value.qrData),
              version: QrVersions.auto,
              // size: 200,
            ),
          ),
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

}
