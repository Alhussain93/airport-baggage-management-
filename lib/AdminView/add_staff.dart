import 'package:flutter/material.dart';

import '../constant/colors.dart';

class AddStaff extends StatelessWidget {
  const AddStaff({Key? key}) : super(key: key);

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
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 15),
              child: const Text(
                "Add New Staff",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: "Poppins-SemiBold"),
              ),
            ),
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
                      decoration: InputDecoration(
                        hintText: 'Name',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
                      decoration: InputDecoration(
                        hintText: 'Staff ID',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
