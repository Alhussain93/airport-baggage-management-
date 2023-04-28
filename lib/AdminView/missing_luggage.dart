import 'package:flutter/material.dart';

import '../constant/colors.dart';

class MisingLaggage extends StatelessWidget {
  const MisingLaggage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height / 3.4,
              width: width,
              color: themecolor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          "LOGO",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontWeight: FontWeight.w600,
                              fontSize: 36,
                              color: Textclr),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.menu_outlined,
                                color: basewhite,
                                size: 34,
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27),
                    child: Container(
                      height: 40,
                      width: width / 1.2,
                      decoration: BoxDecoration(
                          color: basewhite,
                          borderRadius: BorderRadius.circular(32.0)),
                      child: TextFormField(
                          autofocus: false,
                          // obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 19),
                    child: SizedBox(
                      height: 40,
                      width: width / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Textclr,
                            ),
                            child: const Center(
                                child: Text(
                                  "Add Costumer",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.w600),
                                )),
                          ),
                          Container(
                            width: 100,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Textclr,
                            ),
                            child: const Center(
                                child: Text(
                                  "Update Status",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.w600),
                                )),
                          ),
                          Container(
                            width: 100,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Textclr,
                            ),
                            child: const Center(
                                child: Text(
                                  "Staff",
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.w600),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                width: width / 1.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 35,
                      width: width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Flight",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  fontFamily: "Poppins-SemiBold"),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_drop_down))
                        ],
                      ),
                    ),
                    Container(
                      height: 35,
                      width: width / 4.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  fontFamily: "Poppins-SemiBold"),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_drop_down))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: height,
                width: width,
                child: ListView.builder(
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
                                  const Row(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
