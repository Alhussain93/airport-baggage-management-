import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking_app/AdminView/staff_screen.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import 'home_screen.dart';

class AddStaff extends StatelessWidget {
  String from, userId,status;

  AddStaff({Key? key, required this.from, required this.userId,required this.status})
      : super(key: key);
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

  @override
  Widget build(BuildContext context) {
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
                height: height /40,
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
                        child:Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: cWhite,
                              shape: BoxShape.circle,
                              image: value.fileImage != null
                                  ?  DecorationImage(
                                  image: FileImage(value.fileImage!),fit: BoxFit.fill)
                                  : value.staffImage!=""? DecorationImage(
                                  image: NetworkImage(value.staffImage),fit: BoxFit.fill,
                                  scale: 15):
                              const DecorationImage(
                                  image: AssetImage("assets/user.png"),
                                  scale: 10),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey.shade500,
                              ),
                            )),),
                    from=='edit'?
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 20),
                      child: Consumer<AdminProvider>(
                        builder: (context,value,child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              StreamBuilder<Object>(
                                stream: null,
                                builder: (context, snapshot) {
                                  return InkWell(
                                    onTap: (){
                                      deleteStaff(context, value.staffEditId);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: cnttColor),
                                      child: Center(child: Text("Remove")),
                                    ),
                                  );
                                }
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Consumer<AdminProvider>(
                                builder: (context,value1,child) {
                                  return InkWell(
                                    onTap: (){

                                        blockStaff(context, value1.staffEditId,status);

                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: cnttColor),
                                      child: Center(child:status=='ACTIVE'? const Text("Block"):const Text("Unblock")),

                                    ),
                                  );
                                }
                              ),
                            ],
                          );
                        }
                      ),
                    ):SizedBox(),
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
                    //     validator: (value) {
                    //       if (value!.trim().isEmpty) {
                    //         return "Enter Email";
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     keyboardType: TextInputType.text,
                    //     controller: value.EmailController,
                    //     decoration: InputDecoration(
                    //       helperText: "",
                    //       fillColor: Colors.white,
                    //       contentPadding: const EdgeInsets.all(11),
                    //       hintText: 'Email',
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(15.0)),
                    //     ),
                    //   ),
                    // ),
                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please Enter a Phone Number";
                          }else if
                          (!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value))
                          {
                            return "Please Enter a Valid Phone Number";
                          }
                        },
                        keyboardType: TextInputType.phone,
                         controller: value.PhoneNumberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          helperText: "",
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(11),
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                    ),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Container(
                        height: 45,
                        width: width / 1.1,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 1,color: Colors.grey),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.shade300,
                          //     blurRadius: 1, // soften the shadow
                          //     spreadRadius: 1.5, //extend the shadow
                          //     offset: Offset(
                          //       .2, // Move to right 5  horizontally
                          //       .2, // Move to bottom 5 Vertically
                          //     ),
                          //   )
                          // ],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40,
                            width: width / 2,
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
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isCollapsed: true,
                                filled: true,
                                fillColor: Colors.transparent,
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
                        ),
                      );
                    }),SizedBox(height: 10,),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Container(
                        height: 45,
                        width: width / 1.1,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 1,color: Colors.grey),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.shade300,
                          //     blurRadius: 1, // soften the shadow
                          //     spreadRadius: 1.5, //extend the shadow
                          //     offset: Offset(
                          //       .2, // Move to right 5  horizontally
                          //       .2, // Move to bottom 5 Vertically
                          //     ),
                          //   )
                          // ],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40,
                            width: width / 2,
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
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isCollapsed: true,
                                filled: true,
                                fillColor: Colors.transparent,
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
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            // val.getdataa();
                            final FormState? forme = _formKey.currentState;
                            if (forme!.validate()&&value.designation!="Select Designation"&& value.staffAirportName!='Select Airport') {
                              value.addData(context, from, userId,status);
                            }else {
                              if (value.designation == "Select Designation"&& value.staffAirportName=='Select Airport') {
                                // print("dtyufgfj");
                                const snackBar = SnackBar(
                                  content: Text('Please select Airport and Designation'),
                                  backgroundColor: Colors.red,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar) ;
                              }
                              else {
                                if(value.designation == "Select Designation"){
                                  const snackBar = SnackBar(
                                    content: Text('Please select Designation'),
                                    backgroundColor: Colors.red,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else if( value.staffAirportName=='Select Airport' ){
                                  const snackBar = SnackBar(
                                    content: Text('Please select Airport'),
                                    backgroundColor: Colors.red,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar) ;
                            }
                          }
                          }
                          },
                          child: Container(
                            height: 48,
                            width: width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: themecolor),
                            child:  Center(
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
                            adminProvider.deleteData(context, id);
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
  blockStaff(BuildContext context, String id,String userStatus) {
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);

    AlertDialog alert = AlertDialog(
      backgroundColor: themecolor,
      scrollable: true,
      title:  userStatus=='ACTIVE'? const Text(
        "Do you want to block this staff",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ):const Text(
        "Do you want to unblock this staff",
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
                            if(userStatus=='ACTIVE'){
                              adminProvider.blockStaff(context, id);
                            }else{
                              adminProvider.unBlockStaff(context, id);
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

