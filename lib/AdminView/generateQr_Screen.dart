import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

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


    GridView.builder(
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount:qrData ,
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
    childAspectRatio: 1.1,
    crossAxisSpacing: 2,
    crossAxisCount: 2),
    itemBuilder: (context, index) {
      return Container(
        height: 200,
        child: SfBarcodeGenerator(
          value: (index+1).toString(),
          symbology: QRCode(),
          showValue: true,
        ),
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
