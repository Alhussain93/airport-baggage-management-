import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/admin_provider.dart';
import 'add_tickets.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';

class TicketList extends StatelessWidget {
  String addedBy;

  TicketList({Key? key, required this.addedBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              return value2.filterTicketLIst.isNotEmpty? ListView.builder(
                  itemCount: value2.filterTicketLIst.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var ID = value2.filterTicketLIst[index];
                    var item = value2.filterTicketLIst[index];
                    return Consumer<AdminProvider>(
                        builder: (context, value, child) {
                      return InkWell(
                        onLongPress: () {
                          deleteStaff(context, ID.id);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                              Column(
                                children: [
                                  Consumer<AdminProvider>(
                                      builder: (context, value2, child) {
                                    return IconButton(
                                        onPressed: () {
                                          value2.editTickets(context, ID.id);
                                        },
                                        icon: const Icon(
                                          Icons.edit_calendar,
                                          size: 20,
                                        ));
                                  })
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  }):const SizedBox(
                height: 300,
                child: Center(
                    child: Text(
                      " No Tickets Found !!!",
                      style: TextStyle(fontSize: 15),
                    )),
              );
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
                        AddTickets(
                          from: '',
                          userId: '',
                          addedBy: addedBy,
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

  deleteStaff(BuildContext context, String id) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    AlertDialog alert = AlertDialog(
      backgroundColor: themecolor,
      scrollable: true,
      title: const Text(
        "Do you want to delete this Ticket",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
      content: SizedBox(
        height: 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 37,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextButton(
                        child: const Text(
                          'NO',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          finish(context);
                        }),
                  ),
                  Consumer<AdminProvider>(builder: (context, value, child) {
                    return Container(
                      height: 37,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Textclr),
                      child: TextButton(
                          child: const Text('YES',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            adminProvider.deleteTickets(context, id);
                          }),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
