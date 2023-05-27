import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import '../constant/colors.dart';

class MakeQrScreen extends StatelessWidget {
  String stfAirport, stfName;

  MakeQrScreen({Key? key, required this.stfAirport, required this.stfName})
      : super(key: key);
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AdminProvider>(builder: (context, values, child) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25,top: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: values.qrPnrCT,
                    decoration: InputDecoration(
                      hintText: 'PNR Number',
                      helperText: '',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter PNR Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [LengthLimitingTextInputFormatter(2)],
                    controller: values.qrLuggageCountCT,
                    decoration: InputDecoration(
                      hintText: 'Luggage count',
                      helperText: '',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Luggage count";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Consumer<AdminProvider>(
                        builder: (context, value1, child) {
                      return InkWell(
                        onTap: () async {
                          var form = _formKey.currentState;
                          if (form!.validate()) {
                            adminProvider.checkPnrIDExist(
                                adminProvider.qrPnrCT.text,
                                context,
                                stfAirport,
                                stfName);
                          }
                        },
                        child: Container(
                          height: 48,
                          width: width / 1.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Textclr),
                          child: const Center(
                              child: Text(
                            "Generate Qr",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins-SemiBold'),
                          )),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
