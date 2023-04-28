import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scanbkgrnd,
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
                              color: themecolor,
                            ),
                            child: const Center(
                                child: Text(
                                  "Scan",
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
            Container(
              height: 70,
              width: width,
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.only(top: 33, left: 20),
                child: Text(
                  "Leading Department",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: height/2.7,
                  width: width/2,
                  child: Image.asset("assets/scan.png"),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: 48,
                  width: width/1.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Textclr
                  ),
                  child: Center(child: Text("Submit",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'Poppins-SemiBold'),)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
