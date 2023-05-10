import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';

class AddCustomerScreen extends StatelessWidget {
  String userId, from;

  AddCustomerScreen({Key? key, required this.userId, required this.from})
      : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

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
                  // from == 'edit'
                //     ? Padding(
                //   padding: const EdgeInsets.only(right: 30, top: 20),
                //   child: Consumer<AdminProvider>(
                //       builder: (context, value, child) {
                //         return Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             StreamBuilder<Object>(
                //                 stream: null,
                //                 builder: (context, snapshot) {
                //                   return InkWell(
                //                     onTap: () {
                //                       deleteStaff(
                //                           context, value.staffEditId);
                //                     },
                //                     child: Container(
                //                       height: 30,
                //                       width: 80,
                //                       decoration: BoxDecoration(
                //                           borderRadius:
                //                           BorderRadius.circular(20),
                //                           color: cnttColor),
                //                       child:
                //                       const Center(child: Text("Remove")),
                //                     ),
                //                   );
                //                 }),
                //             const SizedBox(
                //               width: 5,
                //             ),
                //             Consumer<AdminProvider>(
                //                 builder: (context, value1, child) {
                //                   return InkWell(
                //                     onTap: () {
                //                   adminProvider.blockStaff(context, value1.staffEditId,status);
                //                     },
                //                     child: Container(
                //                       height: 30,
                //                       width: 80,
                //                       decoration: BoxDecoration(
                //                           borderRadius:
                //                           BorderRadius.circular(20),
                //                           color: cnttColor),
                //                       child: Center(
                //                           child: status == 'ACTIVE'
                //                               ? const Text("Block")
                //                               : const Text("Unblock")),
                //                     ),
                //                   );
                //                 }),
                //           ],
                //         );
                //       }),
                // )
                //     : const SizedBox(),

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
                      fillColor: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
                  child: TextFormField(
                    controller: values.userPhoneCT,
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 18,
                        fontFamily: "PoppinsMedium"),
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Colors.grey),
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16),
                      filled: true,
                      helperText: "",
                      fillColor: Colors.white,
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
                      hintText: 'Phone',
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter Phone";
                      } else {
                        return null;
                      }
                    },
                  ),
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
                      fillColor: Colors.white,
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
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter Email";
                      } else {
                        return null;
                      }
                    },
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
                      fillColor: Colors.white,
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
                          if (from == "EDIT") {
                            adminProvider.userRegistration(
                                context, 'Admin', userId, from);
                          } else {
                            adminProvider.userRegistration(
                                context, 'Admin', '', '');
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
}
