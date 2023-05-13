import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/AdminView/qr_Scanner_Screen.dart';
import 'package:provider/provider.dart';
import '../AdminView/passengersList_Screen.dart';
import '../AdminView/makeQrcodeScreen.dart';
import '../AdminView/missing_luggage.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';

class StaffHomeScreen extends StatelessWidget {
  String designation, stfAirport, addedBy, stfName;

  StaffHomeScreen({
    super.key,
    required this.designation,
    required this.stfAirport,
    required this.addedBy,
    required this.stfName,
  });

  ValueNotifier<int> isSelected = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    List screens = [
      CustomersListScreen(
        addedby: addedBy,
      ),
      QrScanner(
        designation: designation,
        stfAirport: stfAirport,
        stfName: stfName,
      ),
      MakeQrScreen(
        stfAirport: stfAirport,
        stfName: stfName,
      ),
      MissingLuggage(),
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
        valueListenable: isSelected,
        builder: (context, int dIsSelected, child) {
          return SafeArea(
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
                    designation != "CHECK_IN"
                        ? InkWell(
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
                                      Icons.qr_code_scanner,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Scan",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                isSelected.value = 2;
                                adminProvider.clearQrControllers();
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
                                      Icons.qr_code_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Generate Qr  ",
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
                          isSelected.value = 3;
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
                        isSelected.value != 0
                            ? const Padding(padding: EdgeInsets.only(top: 52))
                            : const SizedBox(),
                        isSelected.value == 0
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
                                      } else if (isSelected.value == 3) {
                                        adminProvider.notifyListeners();
                                      }
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox(),
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
                                  if (designation != "CHECK_IN") {
                                    isSelected.value = 1;
                                  } else {
                                    adminProvider.clearQrControllers();
                                    isSelected.value = 2;
                                  }
                                },
                                child: Container(
                                  width: 105,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: dIsSelected == 1 || dIsSelected == 2
                                        ? Colors.white.withOpacity(0.2)
                                        : Textclr,
                                  ),
                                  child: Center(
                                      child: Text(
                                    designation != "CHECK_IN"
                                        ? "Scan"
                                        : "Generate Qr",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            dIsSelected == 1 || dIsSelected == 2
                                                ? Colors.white
                                                : Colors.black),
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
                                    "Missing Luggage",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: dIsSelected == 3
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
                child: screens[dIsSelected],
              ),
            ),
          );
        });
  }
}
