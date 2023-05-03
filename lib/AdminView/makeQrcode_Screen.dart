import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';

class MakeQrScreen extends StatelessWidget {
  const MakeQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Consumer<AdminProvider>(
        builder: (context,value,child) {
          return SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Center(
                    child: Container(
                      height: 40,
                      width: width / 1.1,
                      decoration: BoxDecoration(
                        color: basewhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                          autofocus: false,
                          // obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          controller: value.qrUserNameCT,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding: EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0)),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Container(
                      height: 40,
                      width: width / 1.1,
                      decoration: BoxDecoration(
                        color: basewhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                          autofocus: false,
                          // obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          controller: value.qrPnrCT,
                          decoration: InputDecoration(
                            hintText: 'PNR ID',
                            contentPadding: EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0)),
                          )),
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Consumer<AdminProvider>(
                      builder: (context,value1,child) {
                        return InkWell(
                          onTap: () {

                            value1. generateQrCode(context);
                          },
                          child: Container(
                            height: 48,
                            width: width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Textclr
                            ),
                            child: const Center(child: Text("Generate Qr",
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-SemiBold'),)),
                          ),
                        );
                      }
                    ),
                  ),
                )



              ],
            ),
          );
        }
      ),

    );
  }
}
