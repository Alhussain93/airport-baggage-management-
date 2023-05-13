import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/AdminView/staff_screen.dart';
import 'package:luggage_tracking_app/StaffView/tickets_List.dart';
import 'package:provider/provider.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';
import 'passengersList_Screen.dart';
import 'missing_luggage.dart';

class HomeScreen extends StatelessWidget {
  String addedBy;

  HomeScreen({super.key, required this.addedBy});

  ValueNotifier<int> isSelected = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    List screens = [
      CustomersListScreen(
        addedby: addedBy,
      ),
      StaffScreen(addedBy: addedBy),
      MissingLuggage(),
      TicketList(
        addedBy: addedBy,
      ),
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
        valueListenable: isSelected,
        builder: (context, int dIsSelected, child) {
          return WillPopScope(

              onWillPop: () =>adminProvider.showExitPopup(context) ,
          child: SafeArea(
              child: Scaffold(
                endDrawer: Drawer(
                  backgroundColor: themecolor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          isSelected.value = 0;
                          finish(context);
                        },
                        child: Container(
                          height: 40,
                          width: width * .77,
                          color: darkThemeColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_add_alt_1,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Add Passenger",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            isSelected.value = 3;
                            adminProvider.fetchTicketsList();
                            finish(context);
                          },
                          child: Container(
                            height: 40,
                            width: width * .77,
                            color: darkThemeColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.airplane_ticket_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Tickets",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          isSelected.value = 1;
                          finish(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 40,
                            width: width * .77,
                            color: darkThemeColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.perm_contact_calendar_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Staff Details ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            isSelected.value = 2;
                            finish(context);
                          },
                          child: Container(
                            height: 40,
                            width: width * .77,
                            color: darkThemeColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.luggage,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Missing Luggage Details ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {
                            adminProvider.logOutAlert(context);
                          },
                          child: Container(
                            height: 40,
                            width: width * .77,
                            color: darkThemeColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Log Out",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * .28),
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: themecolor,
                    centerTitle: false,
                    title: Image.asset(
                      "assets/Frame48.png",
                      scale: 3.5,
                    ),
                    flexibleSpace: Container(
                      height: height / 3,
                      width: width,
                      color: themecolor,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          isSelected.value == 2
                              ? const Padding(padding: EdgeInsets.only(top: 52))
                              : const SizedBox(),
                          isSelected.value != 2
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Container(
                                    height: 40,
                                    width: width / 1.2,
                                    decoration: BoxDecoration(
                                        color: basewhite,
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    child: TextFormField(
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Search',
                                        contentPadding: const EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                      ),
                                      onChanged: (text) {
                                        if (isSelected.value == 0) {
                                          adminProvider.notifyListeners();
                                          adminProvider.filterCustomerList(text);
                                        } else if (isSelected.value == 1) {
                                          adminProvider.notifyListeners();
                                          adminProvider.filterStaffList(text);
                                        } else if (isSelected.value == 3) {
                                          adminProvider.notifyListeners();
                                          adminProvider.filterTickets(text);
                                        }
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(top: 19),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    isSelected.value = 0;
                                  },
                                  child: Container(
                                    width: 105,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: dIsSelected == 0
                                          ? Colors.white.withOpacity(0.2)
                                          : Textclr,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Add Passenger",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: dIsSelected == 0
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    isSelected.value = 3;
                                  },
                                  child: Container(
                                    width: 105,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: dIsSelected == 3
                                          ? Colors.white.withOpacity(0.2)
                                          : Textclr,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Tickets",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: dIsSelected == 3
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    isSelected.value = 1;
                                  },
                                  child: Container(
                                    width: 105,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: dIsSelected == 1
                                          ? Colors.white.withOpacity(0.2)
                                          : Textclr,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Staff",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: dIsSelected == 1
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: SizedBox(
                  height: height,
                  width: width,
                  // color: my_white,
                  child: screens[dIsSelected],
                ),
              ),
            ),
          );
        });
  }
}
