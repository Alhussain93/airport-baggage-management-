import 'dart:io';

import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/AdminView/staff_screen.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import 'home_screen.dart';

class AddStaff extends StatelessWidget {
  String from, userId;

  AddStaff({Key? key, required this.from, required this.userId})
      : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> airportNameList = [
    "Select",
    "Salalah International Airport",
    "Duqm International Airport",
    "Sohar International Airport",
    'Khasab Airport'
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .1,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 15),
                child: Text(
                  "Add New Staff",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: "Poppins-SemiBold"),
                ),
              ),
              Consumer<AdminProvider>(builder: (context, value, child) {
                return Column(
                  children: [
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){value.showBottomSheet(context);},
                      child: Container(
                        height: 90,
                        decoration:value.fileImage==""?BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(image: AssetImage("assets/add-photo.png",),scale: 10),

                          border: Border.all(
                            width: 1.5,
                            color: Colors.grey.shade500,
                          ),
                        ):BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: FileImage(value.fileImage!)),
                          border: Border.all(
                            width: 1.5,
                            color: Colors.grey.shade500,
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
                      child: TextFormField(
                        autofocus: false,
                        // obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        controller: value.NameController,
                        
                        decoration: InputDecoration(helperText: '',
                          hintText: 'Name',
                          contentPadding:
                              const EdgeInsets.all(11),
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
                      padding: const EdgeInsets.only(top: 10,right: 20,left: 20),
                      child: TextFormField(
                          autofocus: false,
                          // obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          controller: value.StaffidController,
                          decoration: InputDecoration(
                            helperText: "",

                            contentPadding:
                            const EdgeInsets.all(11),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                      child: TextFormField(
                          autofocus: false,
                          // obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          controller: value.EmailController,
                          decoration: InputDecoration(
                            helperText: "",
                            hintText: 'Email',
                            contentPadding:
                            const EdgeInsets.all(11),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Enter Email";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Container(
                        height: 40,
                        width: width / 1.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: Colors.grey.shade500),
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
                                fillColor: Colors.white,
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
                      height: height * .1,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            // val.getdataa();
                            final FormState? forme = _formKey.currentState;
                            if (forme!.validate()){
                            value.addData(context, from, userId);

                            }
                          },
                          child: Container(
                            height: 48,
                            width: width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Textclr),
                            child: const Center(
                                child: Text(
                              "Submit",
                              style: TextStyle(
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
}
