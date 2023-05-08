import 'dart:io';

import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../Providers/admin_provider.dart';
import 'home_screen.dart';

class QrScanner extends StatefulWidget {
  String designation;
  QrScanner({Key? key,required this.designation}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    controller!.resumeCamera();
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 180.0
        : 300.0;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            ),
          ),

        ],
      ),
    );
  }
  void _onQRViewCreated(QRViewController controller) {

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
      String luggageId = adminProvider.decrypt(result!.code.toString());
      print(luggageId.length.toString()+'FFFFFFFFFFFFF');
      print(luggageId.toString()+'WWWWWWWWWWWWWWWq');
      print(widget.designation.toString()+'dfghtujkytjrhegsf');

      if(luggageId.length == 17 ){
        adminProvider.statusUpdateQrData(luggageId,widget.designation,context);
        // callNextReplacement(HomeScreen(), context);
        // callNextReplacement( MainHomeBottom(pName: widget.userName, pId: widget.userId, phone: widget.userPhone,), context);
        controller.pauseCamera();
        // dispose();
        // adminProvider.call=false;
      }else{
        const snackBar = SnackBar(
            backgroundColor:Colors.red ,
            duration: Duration(milliseconds: 3000),
            content: Text("Invalid", textAlign: TextAlign.center,softWrap: true, style: TextStyle(color: Colors.white),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        controller.pauseCamera();
      }

    });
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}