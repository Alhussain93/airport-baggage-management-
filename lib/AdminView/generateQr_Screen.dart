import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Providers/admin_provider.dart';
import '../constant/colors.dart';

class GenerateQrScreen extends StatelessWidget {
  String qrData;
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
SizedBox(height: height*.3,),
                Center(
                  child: Container(
                    height: 290,
                    width: 290,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(45),
                      child: QrImage(
                        data: value.encrypt(qrData),
                        version: QrVersions.auto,
                        // size: 200,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

}
