import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import '../constant/colors.dart';

class MisingLaggage extends StatelessWidget {
   MisingLaggage({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: 40,
                width: width / 1.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //   height: 35,
                    //   width: width / 2,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: Colors.white),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Padding(
                    //         padding: EdgeInsets.only(left: 10),
                    //         child: Text(
                    //           "Flight",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w400,
                    //               fontSize: 11,
                    //               fontFamily: "Poppins-SemiBold"),
                    //         ),
                    //       ),
                    //       IconButton(
                    //           onPressed: () {},
                    //           icon: const Icon(Icons.arrow_drop_down))
                    //     ],
                    //   ),
                    // ),

                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Container(
                        height: 40,
                        width: width / 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                              print("rftgyhjuio" + value1.toString());
                            },
                            items:value1.flightNameList.map((item1) {
                              return DropdownMenuItem(
                                  value: item1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(item1,style: TextStyle(fontSize: 11),),
                                  ));
                            }).toList(),
                          ),
                        ),
                      );
                    }),
                    InkWell(
                      onTap: (){

                        adminProvider.selectDOB(context);

                      },
                      child: Container(
                        height: 35,
                        width: width / 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: "Poppins-SemiBold"),
                              ),
                            ),
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.arrow_drop_down))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                      const EdgeInsets.only(left: 8, right: 8, bottom: 7),
                      child: Container(
                          height: height / 4.5,
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
                            padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10,right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Steffy",
                                  style: TextStyle(
                                      fontFamily: "Poppins-SemiBold",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "PNR : 45367288376",
                                  style: TextStyle(
                                      fontFamily: "Poppins-SemiBold",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: txtgry),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Last Scanned On :",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                const Text(
                                  "DXB to LHR",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Screening",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: txtred),
                                ),
                                 Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "20/3/2023",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "23.50",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
