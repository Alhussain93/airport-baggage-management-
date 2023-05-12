import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:provider/provider.dart';

import '../UserView/contryCodeModel.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';

class AddCustomerScreen extends StatefulWidget {
  String userId, from, passengerStatus, addedBy;

  AddCustomerScreen(
      {Key? key,
      required this.userId,
      required this.from,
      required this.passengerStatus,
      required this.addedBy})
      : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _passengerEditTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    adminProvider.fetchCountryJson();
    var width= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        title: const Text(
          "Add Passenger",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Consumer<AdminProvider>(builder: (context, values, child) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    values.showBottomSheet(context);
                  },
                  child: values.fileImage != null
                      ? CircleAvatar(
                          backgroundColor: cWhite,
                          radius: 50,
                          backgroundImage: FileImage(values.fileImage!),
                        )
                      : values.editImage != ""
                          ? CircleAvatar(
                              backgroundColor: cWhite,
                              radius: 50,
                              backgroundImage: NetworkImage(values.editImage))
                          : CircleAvatar(
                              backgroundColor: cWhite,
                              radius: 50,
                              backgroundImage:
                                  const AssetImage("assets/user.png"),
                            ),

                  // child: Container(
                  //     height: 90,
                  //     decoration: BoxDecoration(
                  //       color: cWhite,
                  //       shape: BoxShape.circle,
                  //       image: values.fileImage != null
                  //           ?  DecorationImage(
                  //           image: FileImage(values.fileImage!),fit: BoxFit.fill)
                  //           : values.editImage!=""? DecorationImage(
                  //           image: NetworkImage(values.editImage),fit: BoxFit.fill,
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
                widget.from == 'EDIT'
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
                                        deleteStaff(context, widget.userId);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: cnttColor),
                                        child:
                                            const Center(child: Text("Remove")),
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
                                        widget.passengerStatus);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: cnttColor),
                                    child: Center(
                                        child: value1.passengerStatusForEdit ==
                                                'ACTIVE'
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
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                  child: TextFormField(
                    controller: values.userNameCT,
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 18,
                        fontFamily: "PoppinsMedium"),
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    // inputFormatters: [
                    //   LengthLimitingTextInputFormatter(10)
                    // ],
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Colors.grey),
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16),
                      filled: true,
                      helperText: "",
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(11),
                      hintText: 'Name',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
                //   child: TextFormField(
                //     controller: values.userPhoneCT,
                //     style: TextStyle(
                //         color: fontColor,
                //         fontSize: 18,
                //         fontFamily: "PoppinsMedium"),
                //     autofocus: false,
                //     keyboardType: TextInputType.phone,
                //     textAlign: TextAlign.start,
                //     inputFormatters: [LengthLimitingTextInputFormatter(10)],
                //     decoration: InputDecoration(
                //       counterStyle: const TextStyle(color: Colors.grey),
                //       hintStyle:
                //           const TextStyle(color: Colors.grey, fontSize: 16),
                //       filled: true,
                //       helperText: "",
                //       fillColor: Colors.white,
                //       contentPadding: const EdgeInsets.all(11),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide(
                //           color: Colors.grey.shade200,
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide(
                //           color: Colors.grey.shade200,
                //         ),
                //       ),
                //       errorBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: const BorderSide(color: Colors.red)),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide(
                //           color: Colors.grey.shade200,
                //         ),
                //       ),
                //       hintText: 'Phone',
                //     ),
                //     validator: (value) {
                //       if (value!.trim().isEmpty) {
                //         return "Enter Phone";
                //       } else {
                //         return null;
                //       }
                //     },
                //   ),
                // ),
                Consumer<AdminProvider>(builder: (context, value1, child) {
                  return Padding(
                    padding:  const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      onChanged: (value) {
                        print("hhhhhhhhh" +
                            value +
                            "  " +
                            value1.selectedValue! +
                            "  " +
                            value1.userPhoneCT.text);
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
                        LengthLimitingTextInputFormatter(
                            10),
                        FilteringTextInputFormatter
                            .digitsOnly,
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: SizedBox(
                          width: 120,
                          child: Consumer<AdminProvider>(
                              builder: (context, value, child) {
                            return DropdownSearch<CountryCode>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      // hintText: 'Select District',
                                      // hintStyle: regLabelStyle,
                                      // prefix:  const SizedBox(width: 10,),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none)),

                              selectedItem: value1.countrySlct == false
                                  ? CountryCode("India", "IN", "+91")
                                  : CountryCode(value.country, value.code,
                                      value.selectedValue!),
                              onChanged: (e) {
                                value1.selectedValue = e?.dialCde.toString();
                                value1.code = e!.code.toString();
                                value.country = e!.country.toString();
                                value1.countrySlct = true;
                                // print("sadsasfsadf" +
                                //     value1.selectedValue! +
                                //     value1.values.userPhoneCT
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
                                print("filkjkdsjf" + filter + item.country);
                                return item.country.contains(filter) ||
                                    item.country
                                        .toLowerCase()
                                        .contains(filter) ||
                                    item.country.toUpperCase().contains(filter);
                              },

                              itemAsString: (CountryCode u) {
                                print("akskaksdsjakd" + u.country + u.dialCde);
                                return u.dialCde;
                              },

                              popupProps: PopupProps.menu(
                                  searchFieldProps: TextFieldProps(
                                    controller: _passengerEditTextController,
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
                        contentPadding: EdgeInsets.only(right:80),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            )),
                        disabledBorder: InputBorder.none,
                        // focusColor: Colors.black,
                        //    contentPadding:
                        //    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Phone Number",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            )),
                        // filled: true,
                        // fillColor: my_black,
                      ),
                      cursorColor: Colors.black,
                      controller: value1.userPhoneCT,
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
                  child: TextFormField(
                    controller: values.userEmailCT,
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 18,
                        fontFamily: "PoppinsMedium"),
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Colors.grey),
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16),
                      filled: true,
                      helperText: "",
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(11),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      hintText: 'Email',
                    ),
                    validator: (value) => validateEmail(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Select dob',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16),
                      helperText: '',
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(11),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    // readOnly: true,
                    controller: values.userDobCT,
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 18,
                        fontFamily: "PoppinsMedium"),
                    onTap: () {
                      adminProvider.selectDOB(context);
                    },

                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please Select dob";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                  child: SizedBox(
                    height: 50,
                    width: 330,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff432244))),
                      onPressed: () {
                        // Navigator.pushNamed(context, newLoginScreen ,arguments: {'type': type});
                        final FormState? form = _formKey.currentState;
                        if (form!.validate()) {
                          if (widget.from == "EDIT") {
                            adminProvider.userRegistration(
                                context,
                                widget.addedBy,
                                widget.userId,
                                widget.from,
                                widget.passengerStatus);
                          } else {
                            adminProvider.userRegistration(
                                context, widget.addedBy, '', '', "ACTIVE");
                          }
                        }
                      },
                      child: const Text(
                        "save",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
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
                            adminProvider.deleteData(context, id, "Passenger");
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
                              adminProvider.blockStaff(
                                  context, id, "Passengers");
                            } else {
                              adminProvider.unBlockStaff(
                                  context, id, "Passengers");
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
