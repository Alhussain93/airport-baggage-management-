import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/AdminView/qr_Scanner_Screen.dart';
import 'package:luggage_tracking_app/AdminView/scan_page.dart';
import 'package:luggage_tracking_app/AdminView/staff_screen.dart';
import 'package:provider/provider.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';
import 'add_staff.dart';
import 'customersList_Screen.dart';
import 'generateQr_Screen.dart';
import 'makeQrcode_Screen.dart';
import 'missing_luggage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  ValueNotifier<int> isSelected = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);

    List screens = [
      const CustomersListScreen(),
       QrScanner(),
      const StaffScreen(),
      const MisingLaggage(),
      const AddStaff(),
      const MakeQrScreen(),

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
                    SizedBox(
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
                          children: [
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
                              "Add customer",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
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
                            children: [
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
                    ),
                    InkWell(
                      onTap: () {
                        print("xnjssxsxjs");
                        isSelected.value = 2;
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
                            children: [
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
                          isSelected.value = 3;
                          finish(context);
                        },
                        child: Container(
                          height: 40,
                          width: width * .77,
                          color: darkThemeColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          isSelected.value = 5;
                         adminProvider. clearQrControllers();
                          finish(context);
                        },
                        child: Container(
                          height: 40,
                          width: width * .77,
                          color: darkThemeColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                  ],
                ),
              ),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(height * .28),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: themecolor,
                  centerTitle: true,
                  title: Text(
                    "LOGO",
                    style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                        color: Textclr),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                )),
                          ),
                        ),
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
                                    "Add Costumer",
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
                                    "Scan",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: dIsSelected == 1
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  isSelected.value = 2;
                                },
                                child: Container(
                                  width: 105,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: dIsSelected == 2
                                        ? Colors.white.withOpacity(0.2)
                                        : Textclr,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Staff",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: dIsSelected == 2
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
              body: Container(
                height: height,
                width: width,
                // color: my_white,
                child: screens[dIsSelected],
              ),
            ),
          );
        });
  }
}
