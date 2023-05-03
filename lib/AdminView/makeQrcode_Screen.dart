import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';

class MakeQrScreen extends StatelessWidget {
   MakeQrScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

             Consumer<AdminProvider>(
               builder: (context,values,child) {
                 return Form(
                   key:formKey ,
                   child: Column(
                     children: [

                       Padding(
                         padding: const EdgeInsets.only(top: 70,left: 25,right: 25),
                         child: TextFormField(
                             autofocus: false,
                             // obscureText: _obscureText,
                             keyboardType: TextInputType.text,
                             controller: value.qrUserNameCT,
                             decoration: InputDecoration(
                               hintText: 'Name',
                               helperText: '',
                               contentPadding: const EdgeInsets.all(11),
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(
                                       15.0)),
                             ),
                           validator: (value) {
                             if (value!.trim().isEmpty) {
                               return "Enter Name";
                             } else {
                               return null;
                             }
                           },
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 25,right: 25),
                         child: TextFormField(
                             autofocus: false,
                             // obscureText: _obscureText,
                             keyboardType: TextInputType.text,
                             controller: value.qrPnrCT,
                             decoration: InputDecoration(
                               hintText: 'PNR ID',
helperText: '',
                               contentPadding: const EdgeInsets.all(11),

                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(
                                       15.0)),
                             ),
                           validator: (value) {
                             if (value!.trim().isEmpty) {
                               return "Enter PNR ID";
                             } else {
                               return null;
                             }
                           },
                         ),
                       ),

                     ],
                   ),
                 );
               }
             ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Consumer<AdminProvider>(
                      builder: (context,value1,child) {
                        return InkWell(
                          onTap: () {
    var form = formKey.currentState;
    if (form!.validate()) {
      value1.generateQrCode(context);
    }
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
