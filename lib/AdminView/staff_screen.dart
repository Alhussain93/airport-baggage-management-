import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';

import '../constant/colors.dart';
import 'add_staff.dart';

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
                          child: InkWell(
                            onTap: (){
                              callNext(AddStaff(), context);
                            },
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
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
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
                                 Column(
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
                })
          ],
        ),
      ),
    );
  }
}
