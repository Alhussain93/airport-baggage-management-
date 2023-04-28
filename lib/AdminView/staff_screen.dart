import 'package:flutter/material.dart';

import '../constant/colors.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                              color: themecolor,
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
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: width / 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "All Staff",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Poppins-SemiBold'),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 26,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 1.0, // soften the shadow
                              spreadRadius: 1.0, //extend the shadow
                              // offset: Offset(
                              //   1.0, // Move to right 5  horizontally
                              //   1.0, // Move to bottom 5 Vertically
                              // ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Add Staff",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: 'Poppins-SemiBold'),
                              ),
                              Icon(
                                Icons.add,
                                size: 14,
                                color: blck,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: height,
              width: width,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8,bottom: 2),
                      child: Container(
                        height: 85,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                  AssetImage("assets/girl.png")),
                            ),
                            SizedBox(
                              height: 60,
                              width: width / 1.3,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Steffi",
                                        style: TextStyle(
                                            fontFamily: "Poppins-SemiBold",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text("ID : 5363683523236",style: TextStyle( fontFamily: "Poppins-SemiBold",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),)
                                    ],
                                  ),
                                  IconButton(onPressed: (){},icon: Icon(Icons.edit_calendar_outlined,size: 10.5,))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
