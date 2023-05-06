import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import '../Providers/pnr_provider.dart';
import '../constant/colors.dart';

class MakeQrScreen extends StatelessWidget {
   MakeQrScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
     PnrProvider pnrValue = Provider.of<PnrProvider>(context, listen: false);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AdminProvider>(
          builder: (context,values,child) {
            return Column(
              children: [
                Consumer<AdminProvider>(builder: (context, value1, child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 40,left: 25,right: 25),
                    child: DropdownButtonFormField(
                      hint: const Text(
                        "Flight",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      value: value1.flightName,
                      iconSize: 30,
                      isExpanded: true,
                      decoration:  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.grey
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:  const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        isCollapsed: true,
                        helperText: '',
                        contentPadding: const EdgeInsets.all(11),
                        // filled: true,
                        // fillColor: Colors.white,
                      ),
                      onChanged: (newValue) {
                        value1.flightName = newValue.toString();
                        print("rftgyhjuio" + value1.toString());
                      },
                      validator: (value) {
                        if (value == 'Select') {
                          return 'Flight is required';
                        }
                      },
                      items:value1. flightNameList.map((item1) {
                        return DropdownMenuItem(
                            value: item1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(item1,style: TextStyle(color: fontColor),),
                            ));
                      }).toList(),
                    ),
                  );
                }),

                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25),
                  child: TextFormField(
                    // autofocus: false,
                    // obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    controller: values.qrUserNameCT,
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
                    // autofocus: false,
                    // obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    controller: values.qrPnrCT,
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


                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25),
                  child: SizedBox(
                    width: width-50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width-150,
                          child: TextFormField(
                            // autofocus: false,
                            // obscureText: _obscureText,
                            keyboardType: TextInputType.text,
                            controller: values.ticketPassengersController,
                            decoration: InputDecoration(
                              hintText: 'Add Passengers Name',
                              helperText: '',
                              contentPadding: const EdgeInsets.all(11),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0)),
                            ),
                            validator: (value3) {
                              if (value3!.trim().isEmpty) {
                                return "Enter Passenger Name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              if(values.ticketPassengersController.text.trim().isNotEmpty) {
                                values.addPassengersName(values.ticketPassengersController.text,context);
                              }
                            },
                            child: Container(
                                width: 90,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                                  color: Textclr,
                                ),
                                child: const Center(
                                  child: Text('Add',
                                    style: TextStyle(
                                      fontFamily: 'BarlowCondensed',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,),
                                ))),
                      ],
                    ),
                  ),
                ),

                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: values.ticketNameList.length,
                    itemBuilder: (BuildContext context,
                        int index) {
                      final data =
                      values.ticketNameList[index];
                      return Padding(
                        padding:
                        const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            //  color: Colors.red,
                            // height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (values.ticketNameList.isNotEmpty && index == 0)
                                  Center(child: Padding(
                                    padding: const EdgeInsets.only(bottom: 30.0,top: 20),
                                    child: Text(' Passengers List (${values.ticketNameList.length})',
                                        style: const TextStyle(fontWeight: FontWeight.w600,
                                          fontSize: 18,)),
                                  )) else const SizedBox(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '  ${index + 1} -   ${values.ticketNameList[index]}',
                                        style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18,)
                                    ),
                                    InkWell(
                                        onTap: (){
                                          values.ticketNameList.removeAt(index);
                                          values.notifyListeners();
                                        },
                                        child: const Icon(Icons.delete))
                                  ],
                                ),
                                const Divider(color: cGrey,)
                              ],
                            )),
                      );
                    }),




                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Consumer<AdminProvider>(
                        builder: (context,value1,child) {
                          return InkWell(
                            onTap: () {
                              var form = _formKey.currentState;
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
                )        ],
            );
          }
        ),
      ),

    );
  }
}
