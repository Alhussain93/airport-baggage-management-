import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import 'package:intl/intl.dart';

import '../constant/my_functions.dart';

class MissingLuggage extends StatelessWidget {
  MissingLuggage({Key? key}) : super(key: key);
  String datee = '';

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 15),
              child: Text(
                "Missing Luggage",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins-SemiBold'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SizedBox(
                height: 40,
                width: width / 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Container(
                        height: 40,
                        width: width / 2.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButtonFormField(
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black),
                            hint: const Text(
                              "Flight",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: value1.flightName,
                            iconSize: 30,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              isCollapsed: true,
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (newValue) {
                              value1.flightName = newValue.toString();
                              value1.sortMissingLuggageFlightBase(
                                  newValue.toString());
                            },
                            items: value1.flightNameList.map((item1) {
                              return DropdownMenuItem(
                                  value: item1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      item1,
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ),
                      );
                    }),
                    InkWell(
                      onTap: () {
                        adminProvider.showCalendarDialog(context);
                      },
                      child: Container(
                        height: 35,
                        width: width / 4,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: "Poppins-SemiBold"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){

                        adminProvider.fetchMissingLuggage();
                      },
                      child: Container(

                        height: 35,
                        width: width / 7,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(

                            border: Border.all(
                                width: 1, color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Icon(Icons.refresh),
                      ),
                    )

                  ],
                ),
              ),
            ),
            Consumer<AdminProvider>(builder: (context, value1, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: value1.missingLuggageList.isNotEmpty
                    ? Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              itemCount: value1.missingLuggageList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = value1.missingLuggageList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, bottom: 7),
                                  child: Container(
                                      height: height / 5.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0,
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            bottom: 10,
                                            top: 10,
                                            right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.id,
                                                style: const TextStyle(
                                                    fontFamily:
                                                    "Poppins-SemiBold",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            const Text(
                                              "Last Scanned On :",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              item.missingPlace,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              item.flightName,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              item.status,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: txtred),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  uploadDatee(item.scannedDate),
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                                item.issueReported=="YES"? InkWell(
                                                    onTap: (){
                                                      _showMyDialog(context,item.name,item.phone,item.missingPlace,item.status,);
                                                    },
                                                    child: Text("Reported",style: TextStyle(color:Colors.blue,fontSize: 18,fontWeight: FontWeight.w600,decoration: TextDecoration.underline),)):SizedBox()
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              }),
                        ],
                      )
                    : const SizedBox(
                        height: 300,
                        child: Center(
                            child: Text(
                          " No Missing Report so far !!!",
                          style: TextStyle(fontSize: 15),
                        )),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context,String name,String phone,String missingPlace,String status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reported passenger ",),
          content: Container(
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(text: TextSpan(text:"Name :  ",  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),
                    children:[TextSpan( text: name, style: DefaultTextStyle.of(context).style,
                    )]

                ),),
                RichText(text: TextSpan(text:"Mobile number :  ",  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),
                  children:[TextSpan( text: phone, style: DefaultTextStyle.of(context).style,
                  )]

                ),),

                RichText(text: TextSpan(text:"Missing Airport :  ",  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),
                  children:[TextSpan( text: missingPlace, style: DefaultTextStyle.of(context).style,
                  )]

                ),),
                RichText(text: TextSpan(text:"Department :  ",  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),
                  children:[TextSpan( text: status, style: DefaultTextStyle.of(context).style,
                  )]

                ),),


              ],
            ),
          ),
          actions: [
            Container(
              height: 38,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Textclr,
              ),
              child: TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.black ,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  finish(context);
                  // callNextReplacement(StaffHomeScreen(designation: staffDes, stfAirport: stsAirport, addedBy: '', stfName: staffName, staffId: stfId, phone: phone), context);

                },
              ),
            )
                    ],
        );
      },
    );
  }

  String uploadDatee(String date) {
    var startdate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    datee = DateFormat("dd-MM-yy hh:mm a").format(startdate);
    return datee;
  }
}
