import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/AdminView/missingLuggage_HomeScreen.dart';
import 'package:luggage_tracking_app/AdminView/qr_Scanner_Screen.dart';
import 'package:provider/provider.dart';
import '../AdminView/passengersList_Screen.dart';
import '../AdminView/makeQrcodeScreen.dart';
import '../AdminView/missing_luggage.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';

class StaffHomeScreen extends StatelessWidget {
  String designation, stfAirport, addedBy, stfName,staffId,phone;

  StaffHomeScreen({
    super.key,
    required this.designation,
    required this.stfAirport,
    required this.addedBy,
    required this.stfName,
    required this.staffId,
    required this.phone,
  });
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        stfName: stfName, stfId: staffId, phone: phone, stfBelt: '',
      ),
      MakeQrScreen(
        stfAirport: stfAirport,
        stfName: stfName,
      ),
      MissingHomeScreen(),
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
                      designation != "CHECK_IN"
                          ? InkWell(
                              onTap: () {
                                if(designation =="CHECK_OUT"){
                                  adminProvider.conveyorBeltNo = 'Select Belt No';
                                  selectBeltAlert(context);

                                }else{
                                  isSelected.value = 1;
                                  finish(context);
                                }

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
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 8,left: 25),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Select Department",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 11),)),
                      ),

                      Consumer<AdminProvider>(builder: (context, value1, child) {
                        return Container(
                          height: 40,
                          width: width / 1.35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                            Border.all(width: 1, color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DropdownButtonFormField(
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black),

                              hint: const Text(
                                "Department",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: value1.staffDesignation,
                              iconSize: 30,
                              isExpanded: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isCollapsed: true,
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (newValue) {
                                value1.staffDesignation = newValue.toString();
                                value1.changeStaffStatus(staffId,newValue.toString(),phone,context);
                              },
                              items: value1.staffDesignationList.map((item1) {
                                return DropdownMenuItem(
                                    value: item1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        item1,
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        );
                      }),


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

                                      if(designation =="CHECK_OUT"){
                                        adminProvider.conveyorBeltNo = 'Select Belt No';

                                        selectBeltAlert(context);

                                      }else{
                                        isSelected.value = 1;
                                        // finish(context);
                                      }
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

                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Department :",style: TextStyle(fontSize: 12,color: Colors.white),),
                                Text(designation,style: TextStyle(fontSize: 13,color: Colors.white),),
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
            ),
          );
        });
  }
  Future<void> selectBeltAlert(BuildContext context) async {

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Text(
        "Select conveyor belt",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Consumer<AdminProvider>(builder: (context, value1, child) {
                return DropdownButtonFormField(
                  hint: const Text(
                    "Belt No",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  value: value1.conveyorBeltNo,
                  iconSize: 30,
                  isExpanded: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    isCollapsed: true,
                    helperText: '',
                    contentPadding: const EdgeInsets.all(11),
                  ),
                  onChanged: (newValue) {
                    value1.conveyorBeltNo = newValue.toString();
                  },
                  validator: (value) {
                    if (value == 'Select Belt No') {
                      return 'Belt No is required';
                    }
                    return null;
                  },
                  items: value1.conveyorBeltList.map((item1) {
                    return DropdownMenuItem(
                        value: item1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            item1,
                            style: item1 != "Select Belt No"
                                ? const TextStyle(color: Colors.black)
                                : TextStyle(color: fontColor),
                          ),
                        ));
                  }).toList(),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: cLightGrey,
                  ),
                  child: TextButton(
                      child: const Text('NO',style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        finish(context);
                      }
                  ),
                ),

                Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: clc00a618,),

                  child: Consumer<AdminProvider>(
                    builder: (context,value2,child) {
                      return TextButton(
                          child:  Text('Scan',style: TextStyle(color: Colors.black)),
                          onPressed: ()  {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
callNextReplacement(QrScanner(
    designation: designation,
    stfAirport: stfAirport,
    stfName: stfName, stfId: staffId, phone: phone, stfBelt:  value2.conveyorBeltNo, ),context);

    }


                          }
                      );
                    }
                  ),
                ),
              ],
            ),
          ],
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
