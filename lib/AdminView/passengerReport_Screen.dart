import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import '../constant/colors.dart';

class PassengerReportScreen extends StatelessWidget {
   PassengerReportScreen({Key? key}) : super(key: key);

  @override
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
                "Missing Reported",
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
                              value1.filterMissingReportedFlightBase(
                                  newValue.toString());
                            },
                            items: value1.flightNames.map((item1) {
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
                        adminProvider.showCalendarDialog(context,"REPORT");
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

                        adminProvider.fetchMissingReported();
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
                child: value1.missingReportedList.isNotEmpty
                    ? Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemCount: value1.missingReportedList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = value1.missingReportedList[index];
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
                        " No Missing Reported so far !!!",
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
  String uploadDatee(String date) {
    var startdate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    datee = DateFormat("dd-MM-yy hh:mm a").format(startdate);
    return datee;
  }
}
