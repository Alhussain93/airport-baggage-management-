import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import 'add_tickets.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';
import '../AdminView/addCustomer_screen.dart';
import '../AdminView/add_staff.dart';

class TicketList extends StatelessWidget {
  const TicketList({Key? key}) : super(key: key);

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
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Tickets",
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
                  itemCount: value2.filterTicketLIst.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = value2.filterTicketLIst[index];
                    return Container(
                        margin:const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
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
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                             "PNR ID : ${item.pnrId}",
                              style: const TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Flight Name : ${item.flightName}",
                              style: const TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Arrival Time : ${item.arrivalTime}",
                              style: const TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Departure Time : ${item.departureTime}",
                              style: const TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),

                          ],
                        ),

                    );
                  });
            })
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
                    value3.clearTicketControllers();
                    callNext(
                        AddTickets(),

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
