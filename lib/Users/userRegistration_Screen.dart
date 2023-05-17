import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../Providers/loginProvider.dart';
import '../UserView/contryCodeModel.dart';
import '../constant/colors.dart';

enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE2, SHOW_OTP_FORM_STATE2,
  SHOW_MOBILE_FORM_VERIFIED2,
}

class UserRegistrationScreen extends StatefulWidget {
  UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreen();
}

class _UserRegistrationScreen extends State<UserRegistrationScreen> {
  MobileVarificationState currentSate =
      MobileVarificationState.SHOW_MOBILE_FORM_STATE2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final otpController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  late String verificationId;
  bool showLoading = false;

  String code = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> signInWithPhoneAuthCredential(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    if (kDebugMode) {
      print('done 1  $phoneAuthCredential');
    }
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {}
      setState(() {
        showLoading = false;
      });
      try {
        var loginUser = authCredential.user;
        if (loginUser != null) {
          LoginProvider newLoginProvider =
              Provider.of<LoginProvider>(context, listen: false);
          var phone = loginUser.phoneNumber;
          db
              .collection("USERS")
              .where("PHONE_NUMBER", isEqualTo: phone)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Already a registered"),
                duration: Duration(milliseconds: 3000),
              ));
              newLoginProvider.userAuthorized(loginUser.phoneNumber!, context);
            } else {
              setState(() {
                currentSate = MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED2;
              });
            }
          });

          if (kDebugMode) {}
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (kDebugMode) {}
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          e.message ?? "",
        ),
      ));
    }
  }
  Future<void> listenOtp() async {
    SmsAutoFill().listenForCode;
  }
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: themecolor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Image(
                    image: AssetImage("assets/topLayer.png"), height: 150),

                Text(
                  "   Registration",
                  style: TextStyle(
                      color: clc00a618,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                Column(
                  children: [
                    Consumer<AdminProvider>(builder: (context, values, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          onChanged: (value) {
                            if (value.trim().length != 3) {
                              values.showTick = true;
                            } else {
                              values.showTick = false;
                              currentSate = MobileVarificationState
                                  .SHOW_MOBILE_FORM_STATE2;
                            }
                            setState(() {});
                          },
                          keyboardType: TextInputType.phone,

                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            prefixIcon: SizedBox(
                              width: 110,
                              child: Consumer<AdminProvider>(
                                  builder: (context, value, child) {
                                return DropdownSearch<CountryCode>(
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      Colors.transparent,
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  errorBorder:
                                                      InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none)),
                                  selectedItem:  CountryCode(value.country, value.code,
                                          value.selectedValue!),
                                  onChanged: (e) {
                                    value.selectedValue =
                                        e?.dialCde.toString();
                                    value.code = e!.code.toString();
                                    value.country = e!.country.toString();
                                    value.countrySlct = true;
                                  },
                                  items: value.countryCodeList,
                                  filterFn: (item, filter) {
                                    return item.country.contains(filter) || item.country.toLowerCase().contains(filter) || item.country.toUpperCase().contains(filter)||item.dialCde.toUpperCase().contains(filter)||item.code.toUpperCase().contains(filter);
                                    },
                                  itemAsString: (CountryCode u) {
                                    return u.dialCde;
                                  },
                                  popupProps: PopupProps.menu(
                                      searchFieldProps: const TextFieldProps(
                                        decoration: InputDecoration(
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
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          subtitle: Text(
                                            item.dialCde,
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        );
                                      }),
                                );
                              }),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, top: 4, bottom: 4),
                              child: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: values.showTick == false
                                        ? const Color(0xff838282)
                                        : currentSate != MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED2
                                            ? grapeColor
                                            : cl00cf18,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: values.showTick
                                      ? InkWell(
                                          onTap: () async {
                                            setState(() {

    if (values.userPhoneCT.text.length != 3) {
      showLoading = true;
    }
                                            });

                                            await auth.verifyPhoneNumber(
                                                phoneNumber: adminProvider.selectedValue! +
                                                    values.userPhoneCT.text,
                                                verificationCompleted:
                                                    (phoneAuthCredential) async {
                                                  setState(() {
                                                    showLoading = false;
                                                  });

                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Verification Completed"),
                                                    duration: Duration(
                                                        milliseconds: 3000),
                                                  ));
                                                  if (kDebugMode) {}
                                                },
                                                verificationFailed:
                                                    (verificationFailed) async {
                                                  setState(() {
                                                    showLoading = false;
                                                  });
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Sorry, Verification Failed"),
                                                    duration: Duration(
                                                        milliseconds: 3000),
                                                  ));
                                                  if (kDebugMode) {
                                                    print(verificationFailed
                                                        .message
                                                        .toString());
                                                  }
                                                },
                                                codeSent: (verificationId,
                                                    resendingToken) async {
                                                  setState(()  {
                                                    showLoading = false;
                                                    currentSate = MobileVarificationState.SHOW_OTP_FORM_STATE2;
                                                    this.verificationId = verificationId;
                                                    listenOtp();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "OTP sent to phone successfully"),
                                                      duration: Duration(
                                                          milliseconds: 3000),
                                                    ));

                                                    if (kDebugMode) {}
                                                  });
                                                },
                                                codeAutoRetrievalTimeout:
                                                    (verificationId) async {});
                                          },
                                          child: Center(
                                              child: showLoading
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : Text(
                                                      currentSate !=
                                                              MobileVarificationState
                                                                  .SHOW_MOBILE_FORM_VERIFIED2
                                                          ? "Verify"
                                                          : "Verified",
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.white),
                                                    )))
                                      : const Center(
                                          child: Text("Verify",
                                              style: TextStyle(
                                                  color: Colors.white)))),
                            ),
                            hintText: 'Mobile number',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                            helperText: "",
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
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                )),
                            disabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                )),
                          ),
                          controller: values.userPhoneCT,
                          style: TextStyle(
                              color: fontColor,
                              fontSize: 18,
                              fontFamily: "PoppinsMedium"),
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
                    if (currentSate == MobileVarificationState.SHOW_OTP_FORM_STATE2)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        child: PinFieldAutoFill(
                          codeLength: 6,
                          focusNode: _pinPutFocusNode,
                          keyboardType: TextInputType.number,
                          autoFocus: true,
                          controller: otpController,
                          currentCode: "",
                          decoration: BoxLooseDecoration(
                            strokeWidth: 3,
                            textStyle: const TextStyle(color: Colors.black),
                            radius: const Radius.circular(10),
                            strokeColorBuilder:
                                FixedColorBuilder(Colors.grey.shade300),
                          ),
                            onCodeChanged: (pin) {
                              if (pin!.length == 6) {
                                PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId, smsCode: pin);
                                signInWithPhoneAuthCredential(
                                    context, phoneAuthCredential);
                                otpController.text = pin;
                                setState(() {
                                  code = pin;
                                });
                              }
                            },
                        ),
                      )
                    else
                      const SizedBox(),
                    currentSate == MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED2
                        ? Consumer<AdminProvider>(
                            builder: (context, values, child) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 10),
                                  child: TextFormField(
                                    controller: values.userNameCT,
                                    style: TextStyle(
                                        color: fontColor,
                                        fontSize: 18,
                                        fontFamily: "PoppinsMedium"),
                                    autofocus: false,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      counterStyle:
                                          const TextStyle(color: Colors.grey),
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 16),
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
                                      hintText: 'Name',
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 0),
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
                                      counterStyle:
                                          const TextStyle(color: Colors.grey),
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 16),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25),
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Select dob',
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                      helperText: '',
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    readOnly: true,
                                    controller: values.userDobCT,
                                    style: TextStyle(
                                        color: fontColor,
                                        fontSize: 18,
                                        fontFamily: "PoppinsMedium"),
                                    onTap: () {
                                      values.selectDOB(context);
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
                              ],
                            );
                          })
                        : const SizedBox(),
                  ],
                ),

                SizedBox(
                  height: height * .05,
                ),
                currentSate ==
                        MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED2
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
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
                              final FormState? form = _formKey.currentState;
                              if (form!.validate()) {
                                if (currentSate ==
                                    MobileVarificationState
                                        .SHOW_MOBILE_FORM_VERIFIED2) {
                                  adminProvider.userRegistration(context,
                                      'Self Registration', '', '', 'ACTIVE');
                                }
                              }
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                // SizedBox(height: height*.4),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Image(
                      image: AssetImage("assets/downLayer.png"),
                      height: 140,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
