import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking_app/AdminView/staff_screen.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../Providers/admin_provider.dart';
import '../UserView/contryCodeModel.dart';
import '../Users/login_Screen.dart';
import '../constant/colors.dart';
import 'home_screen.dart';

class AddStaff extends StatefulWidget {
  String from, userId, status, addedBy;

  AddStaff(
      {Key? key,
      required this.from,
      required this.userId,
      required this.status,
      required this.addedBy})
      : super(key: key);

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> airportNameList = [
    'Select Airport',
    "Salalah International Airport",
    "Duqm International Airport",
    "Sohar International Airport",
    'Khasab Airport'
  ];

  List<String> Designation = [
    'Select Designation',
    "CHECK_IN",
    "LOADING",
    "UNLOADING",
    'CHECK_OUT'
  ];
  final _userEditTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AdminProvider mainProvider =
        Provider.of<AdminProvider>(context, listen: false);
    mainProvider.fetchCountryJson();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        title: const Text(
          "Add Staff",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 40,
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 20),
              //   child: Text(
              //     "Add New Staff",
              //     style: TextStyle(
              //         fontWeight: FontWeight.w600,
              //         fontSize: 20,
              //         fontFamily: "Poppins-SemiBold"),
              //   ),
              // ),
              Consumer<AdminProvider>(builder: (context, value, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          value.showBottomSheet(context);
                        },
                        child: value.fileImage != null
                            ? CircleAvatar(
                                backgroundColor: cWhite,
                                radius: 50,
                                backgroundImage: FileImage(value.fileImage!),
                              )
                            : value.staffImage != ""
                                ? CircleAvatar(
                                    backgroundColor: cWhite,
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(value.staffImage),
                                  )
                                : CircleAvatar(
                                    backgroundColor: cWhite,
                                    radius: 50,
                                    backgroundImage:
                                        const AssetImage("assets/user.png"),
                                  )
                        // Container(
                        //     height: 100,
                        //     decoration: BoxDecoration(
                        //       color: cWhite,
                        //       shape: BoxShape.circle,
                        //       image: value.fileImage != null
                        //           ?  DecorationImage(
                        //           image: FileImage(value.fileImage!),fit: BoxFit.fill)
                        //           : value.staffImage!=""? DecorationImage(
                        //           image: NetworkImage(value.staffImage),fit: BoxFit.contain,
                        //           scale: 15):
                        //       const DecorationImage(
                        //           image: AssetImage("assets/user.png"),
                        //           scale: 10),
                        //       border: Border.all(
                        //         width: 1.5,
                        //         color: Colors.grey.shade500,
                        //       ),
                        //     )),
                        ),
                    widget.from == 'edit'
                        ? Padding(
                            padding: const EdgeInsets.only(right: 30, top: 20),
                            child: Consumer<AdminProvider>(
                                builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  StreamBuilder<Object>(
                                      stream: null,
                                      builder: (context, snapshot) {
                                        return InkWell(
                                          onTap: () {
                                            deleteStaff(
                                                context, value.staffEditId);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: cnttColor),
                                            child: const Center(
                                                child: Text("Remove")),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Consumer<AdminProvider>(
                                      builder: (context, value1, child) {
                                    return InkWell(
                                      onTap: () {
                                        blockStaff(context, widget.userId,
                                            widget.status);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: cnttColor),
                                        child: Center(
                                            child: widget.status == 'ACTIVE'
                                                ? const Text("Block")
                                                : const Text("Unblock")),
                                      ),
                                    );
                                  }),
                                ],
                              );
                            }),
                          )
                        : const SizedBox(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: TextFormField(
                        autofocus: false,
                        // obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        controller: value.NameController,

                        decoration: InputDecoration(
                          helperText: '',
                          hintText: 'Name',
                          contentPadding: const EdgeInsets.all(11),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: TextFormField(
                          autofocus: false,
                          // obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          controller: value.StaffidController,
                          decoration: InputDecoration(
                            helperText: "",
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(11),
                            hintText: 'Staff ID',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Enter Staff ID";
                            } else {
                              return null;
                            }
                          }),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 17.0),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.number,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return "Please Enter a Phone Number";
                    //       } else if (!RegExp(
                    //               r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                    //           .hasMatch(value)) {
                    //         return "Please Enter a Valid Phone Number";
                    //       }
                    //     },
                    //     controller: value.PhoneNumberController,
                    //     inputFormatters: [
                    //       LengthLimitingTextInputFormatter(10),
                    //       FilteringTextInputFormatter.digitsOnly,
                    //     ],
                    //     decoration: InputDecoration(
                    //       helperText: "",
                    //       fillColor: Colors.white,
                    //       contentPadding: const EdgeInsets.all(11),
                    //       hintText: 'Phone Number',
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(15.0)),
                    //     ),
                    //   ),
                    // ),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Padding(
                        padding: const EdgeInsets.only( left: 25, right: 25),
                        child: TextFormField(
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          onChanged: (value) {
                            print("hhhhhhhhh" +
                                value +
                                "  " +
                                value1.selectedValue! +
                                "  " +
                                value1.PhoneNumberController.text);
                            // if (value.length >= 6) {
                            //   showTick = true;
                            //   if (kDebugMode) {
                            //     // print("ppppllll$showTick");
                            //   }
                            //   // SystemChannels.textInput
                            //   //     .invokeMethod(
                            //   //         'TextInput.hide');
                            // } else {
                            //   showTick = false;
                            //   print("tick false$showTick");
                            //
                            //   currentSate =
                            //       MobileVarificationState
                            //           .SHOW_MOBILE_FORM_STATE;
                            // }
                            setState(() {});
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: SizedBox(
                              width: 120,
                              child: Consumer<AdminProvider>(
                                  builder: (context, value, child) {
                                return DropdownSearch<CountryCode>(
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.transparent,
                                                  // hintText: 'Select District',
                                                  // hintStyle: regLabelStyle,
                                                  // prefix:  const SizedBox(width: 10,),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none)),

                                  selectedItem: CountryCode(value.country, value.code,
                                          value.selectedValue!),
                                  onChanged: (e) {
                                    value1.selectedValue =
                                        e?.dialCde.toString();
                                    value1.code = e!.code.toString();
                                    value.country = e!.country.toString();
                                    value1.countrySlct = true;
                                    // print("sadsasfsadf" +
                                    //     value1.selectedValue! +
                                    //     value1.PhoneNumberController
                                    //         .text +
                                    //     "kdsjkf   " +
                                    //     _userEditTextController
                                    //         .text);

                                    // registrationProvider.qualificationOthers(
                                    //     e?.degree.toString());
                                    // adminProvider.getManagerWiseReport(
                                    //     context, managerID!, fromName,managerName!);
                                  },
                                  items: value.countryCodeList,
                                  // dropdownBuilder: (context, selectedItem) => selectedItem.dialCde,
                                  filterFn: (item, filter) {

                                    return item.country.contains(filter) ||
                                        item.country
                                            .toLowerCase()
                                            .contains(filter) ||
                                        item.country
                                            .toUpperCase()
                                            .contains(filter);
                                  },

                                  itemAsString: (CountryCode u) {
                                    print("akskaksdsjakd" +
                                        u.country +
                                        u.dialCde);
                                    return u.dialCde;
                                  },

                                  popupProps: PopupProps.menu(
                                      searchFieldProps: TextFieldProps(
                                        controller: _userEditTextController,
                                        decoration: const InputDecoration(
                                            label: Text(
                                          'Search Country',
                                          style: TextStyle(fontSize: 12),
                                        )),
                                      ),
                                      showSearchBox: true,
                                      // showSelectedItems: true,
                                      fit: FlexFit.tight,
                                      itemBuilder: (ctx, item, isSelected) {
                                        return ListTile(
                                          selected: isSelected,
                                          title: Text(
                                            item.country,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          subtitle: Text(
                                            item.dialCde,
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        );
                                      }),
                                );
                              }),
                            ),
                             contentPadding: EdgeInsets.only(right: 80),

                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                )),
                            disabledBorder: InputBorder.none,
                            // focusColor: Colors.black,
                            //    contentPadding:
                            //    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            hintText: "Phone Number",

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                )),
                            // filled: true,
                            // fillColor: my_black,
                          ),
                          cursorColor: Colors.black,
                          controller: value1.PhoneNumberController,
                          style: const TextStyle(
                            fontFamily: 'BarlowCondensed',
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please Enter The Mobile Number";
                            } else {
                              return null;
                            }
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Padding(
                        padding:
                            const EdgeInsets.only( left: 25, right: 25),
                        child: DropdownButtonFormField(
                          hint: const Text(
                            "",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          value: value.staffAirportName,
                          iconSize: 30,
                          isExpanded: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            isCollapsed: true,
                            helperText: '',
                            contentPadding: const EdgeInsets.all(11),
                          ),
                          onChanged: (newValue) {
                            value1.staffAirportName = newValue.toString();
                          },
                          items: airportNameList.map((item1) {
                            return DropdownMenuItem(
                                value: item1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(item1),
                                ));
                          }).toList(),
                          validator: (dropValue) {
                            if (dropValue == "Select Airport") {
                              return "Select Airport";
                            }
                            return null;
                          },
                        ),
                      );
                    }),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Padding(
                        padding:
                            const EdgeInsets.only( left: 25, right: 25),
                        child: SizedBox(
                          child: DropdownButtonFormField(
                            hint: const Text(
                              "",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: value.designation,
                            iconSize: 30,
                            isExpanded: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              isCollapsed: true,
                              helperText: '',
                              contentPadding: const EdgeInsets.all(11),
                            ),
                            onChanged: (newValue) {
                              value1.designation = newValue.toString();
                            },
                            items: Designation.map((item1) {
                              return DropdownMenuItem(
                                  value: item1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(item1),
                                  ));
                            }).toList(),
                            validator: (dropValue) {
                              if (dropValue == "Select Designation") {
                                return "Select Designation";
                              }
                              return null;
                            },
                          ),
                          // DropdownButtonHideUnderline(
                          //   child: DropdownSearch<String>(
                          //     popupProps: PopupProps.menu(
                          //       showSelectedItems: true,
                          //       disabledItemFn: (String s) => s.startsWith('I'),
                          //     ),
                          //     items: const [
                          //       "Salalah International Airport",
                          //       'Muscat International Airport'
                          //       "Duqm International Airport",
                          //       "Sohar International Airport",
                          //       'Khasab Airport'
                          //     ],
                          //     dropdownDecoratorProps: const DropDownDecoratorProps(
                          //       dropdownSearchDecoration: InputDecoration(
                          //       enabledBorder: InputBorder.none,
                          //         // labelText: "Select Airpote",
                          //         hintText: "Select Airport",contentPadding: EdgeInsets.only(left: 18)
                          //       ),
                          //     ),
                          //     onChanged: (value){
                          //       value1.airportName=value.toString();
                          //       print("rftgyhjuio"+value.toString());
                          //     },
                          //     // selectedItem: "Brazil",
                          //   ),
                          // ),
                        ),
                      );
                    }),

                    // DropdownSearch<String>.multiSelection(
                    //   items: [
                    //     "Salalah International Airport",
                    //     "Duqm International Airport",
                    //     "Sohar International Airport",
                    //     'Khasab Airport'
                    //   ],
                    //   // popupProps: PopupPropsMultiSelection.menu(
                    //   //   showSelectedItems: true,
                    //   //   disabledItemFn: (String s) => s.startsWith('I'),
                    //   // ),
                    //   // onChanged: print,
                    //   // selectedItems: ["Brazil"],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {
                            final FormState? forme = _formKey.currentState;
                            if (forme!.validate()) {
                              value.addStaff(context, widget.from,
                                  widget.userId, widget.status, widget.addedBy);
                            }
                          },
                          child: Container(
                            height: 48,
                            width: width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: themecolor),
                            child: Center(
                                child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: cWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-SemiBold'),
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  deleteStaff(BuildContext context, String id) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    AlertDialog alert = AlertDialog(
      backgroundColor: themecolor,
      scrollable: true,
      title: const Text(
        "Do you want to delete this staff",
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
                            adminProvider.deleteData(context, id, "Staff");
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

  blockStaff(BuildContext context, String id, String userStatus) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    AlertDialog alert = AlertDialog(
      backgroundColor: themecolor,
      scrollable: true,
      title: userStatus == 'ACTIVE'
          ? const Text(
              "Do you want to block this staff",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            )
          : const Text(
              "Do you want to unblock this staff",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
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
                            if (userStatus == 'ACTIVE') {
                              adminProvider.blockStaff(context, id, "Staff");
                            } else {
                              adminProvider.unBlockStaff(context, id, "Staff");
                            }
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
