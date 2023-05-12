import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';
import 'addPassenger_screen.dart';
import 'add_staff.dart';

class CustomersListScreen extends StatelessWidget {
  String addedby;
   CustomersListScreen({Key? key,required this.addedby}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
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
                  children: const [
                    Text(
                      "Passengers",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Poppins-SemiBold'),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<AdminProvider>(builder: (context, value2, child) {
              return ListView.builder(
                  itemCount: value2.filterCustomersList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = value2.filterCustomersList[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 2),
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: item.profileImage != ""
                                  ? CircleAvatar(
                                      backgroundColor: cWhite,
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(item.profileImage))
                                  : CircleAvatar(
                                      backgroundColor: cWhite,
                                      radius: 25,
                                      backgroundImage:
                                          const AssetImage("assets/user.png"),
                                    ),
                            ),
                            SizedBox(
                              //height: 60,
                              width: width / 1.3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                            fontFamily: "Poppins-SemiBold",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        item.phone,
                                        style: const TextStyle(
                                            fontFamily: "Poppins-SemiBold",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        item.passengerStatus,
                                        style:  TextStyle(
                                            fontFamily: "Poppins-SemiBold",
                                            fontSize: 12,
                                            color: item.passengerStatus=="BLOCKED"?Colors.red:Colors.green,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        value2.fetchCustomersForEdit(item.id);
                                        callNext(
                                            AddCustomerScreen(
                                              userId: item.id,
                                              from: 'EDIT',
                                              passengerStatus:item.passengerStatus, addedBy: addedby,
                                            ),
                                            context);
                                      },
                                      icon: const Icon(
                                        Icons.edit_calendar_outlined,
                                        size: 25,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }),
            const SizedBox(height: 50,)
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 22, bottom: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Consumer<AdminProvider>(builder: (context, value3, child) {
                return FloatingActionButton(
                  tooltip: "df",
                  backgroundColor: themecolor,
                  onPressed: () {
                    value3.clearUserControllers();
                    callNext(
                        AddCustomerScreen(
                          userId: '',
                          from: '', passengerStatus: 'ACTIVE', addedBy: addedby,
                        ),
                        context);
                  },
                  child: const Icon(Icons.add),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
