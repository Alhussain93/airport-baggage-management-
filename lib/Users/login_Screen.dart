import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking_app/Users/userRegistration_Screen.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../Providers/admin_provider.dart';
import '../Providers/loginProvider.dart';
import '../UserView/contryCodeModel.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';

enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate =
      MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final _userEditTextController = TextEditingController();

  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  late BuildContext context;
  String Code = "";
  late String verificationId;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpPage = false;
  FirebaseFirestore db = FirebaseFirestore.instance;


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
      if (kDebugMode) {
        print(' 1  $phoneAuthCredential');
      }
      setState(() {
        showLoading = false;
      });
      try {
        var LoginUser = authCredential.user;
        if (LoginUser != null) {
          LoginProvider loginProvider = LoginProvider();
          loginProvider.userAuthorized(LoginUser.phoneNumber, context);

          if (kDebugMode) {
            print("Login SUccess");
          }
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.toString());
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

  final FocusNode _pinPutFocusNode = FocusNode();

  Widget getMobileFormWidget(context) {
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
adminProvider.fetchCountryJson();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          // color: Colors.cyan,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Image(image: AssetImage("assets/topLayer.png"),height: 150),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("   Log in",style: TextStyle(color: clc00a618,fontSize: 28,fontWeight: FontWeight.w600),),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: Consumer<AdminProvider>(
                      builder: (context,value1,child) {
                        return Container(
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color:Colors.grey.shade200),
                              borderRadius: const BorderRadius.all(Radius.circular(11))
                          ),
                          child: TextFormField(
                            controller: phoneController,
                            onChanged: (value) {
                              if (value.length == 10) {
                                showTick = true;
                                SystemChannels.textInput.invokeMethod('TextInput.hide');
                              } else {
                                showTick = false;
                              }

                              setState(() {});
                            },
                            style:  TextStyle(color:fontColor, fontSize: 20),
                            autofocus: false,
                            keyboardType: TextInputType.number,
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
                              // contentPadding: EdgeInsets.only(right: 100),

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
                                    color: Colors.black38,
                                  )),
                              disabledBorder: InputBorder.none,
                              hintText: "Phone Number",

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  )),
                              // filled: true,
                              // fillColor: my_black,
                            ),
                            //
                            // decoration:  InputDecoration(
                            //
                            //   counterStyle: const TextStyle(color: Colors.grey),
                            //   hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                            //   // labelText: 'MOBILE NUMBER',
                            //   hintText: 'MOBILE NUMBER',
                            //   enabledBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //     borderSide: BorderSide(
                            //       color: Colors.grey.shade200,
                            //     ),
                            //   ),
                            //   // enabledBorder: InputBorder.none,
                            //   border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //     borderSide:  BorderSide(
                            //       color: Colors.grey.shade200,
                            //     ),
                            //   ),
                            //   focusedBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //     borderSide: BorderSide(
                            //       color: Colors.grey.shade200,
                            //     ),
                            //   ),
                            //   filled: true,
                            //   fillColor: Colors.white,
                            //
                            // ),
                          ),
                        );
                      }
                    ),
                  ),

                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      // OnlineClassProvider onlineClassProvider =
                      // Provider.of<OnlineClassProvider>(context, listen: false);
                      // onlineClassProvider.clearOnlineUsers();
                      adminProvider.clearUserControllers();

                      callNext( UserRegistrationScreen(), context);

                    }, child: Center(
                      child: Container(
                      height: 43,
                      width: 260,
                      decoration: BoxDecoration(
                          color: Colors.white,
border: Border.all(color:Colors.grey.shade200),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("new user? ",style: TextStyle(color: Colors.grey.shade500),),
                          const Text(" REGISTER",style: TextStyle(color: Colors.blue,fontSize: 15),)
                        ],
                      ),
                  ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*.1,),
             showLoading?
                Center(
                  child: CircularProgressIndicator(color: grapeColor,),
                ): Center(
                  child: SizedBox(
                    height:50,
                    width: 330,

                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          backgroundColor:
                          MaterialStateProperty.all(const Color(0xff432244))),
                        onPressed: ()async{

    db
        .collection("USERS")
        .where("MOBILE_NUMBER",
    isEqualTo: adminProvider.selectedValue!+ phoneController.text)
        .get()
        .then((userValue) async {
      if (userValue.docs.isNotEmpty) {
        setState(() {
          print(phoneController.text.toString()+"fgefegh9h8w");
          if (phoneController.text.length == 10) {
            showLoading = true;
          }
        });
        AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
        await auth.verifyPhoneNumber(
            phoneNumber: adminProvider.selectedValue!+phoneController.text,

            verificationCompleted: (phoneAuthCredential) async {
              setState(() {
                  showLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Verification Completed"),
                  duration: Duration(milliseconds: 3000),
              ));
              if (kDebugMode) {
              }
            },
            verificationFailed: (verificationFailed) async {

              setState(() {
                  showLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Sorry, Verification Failed"),
                  duration: Duration(milliseconds: 3000),
              ));
              if (kDebugMode) {
                  print(verificationFailed.message.toString());
              }
            },
            codeSent: (verificationId, resendingToken) async {
              setState(() {
                  showLoading = false;
                  currentSate =
                      MobileVarificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP sent to phone successfully"),
                    duration: Duration(milliseconds: 3000),
                  ));

                  if (kDebugMode) {
                    print("");
                  }
              });
            },
            codeAutoRetrievalTimeout: (verificationId) async {

            });

      }else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
          content: Text("Sorry, No user found..."),
          duration: Duration(milliseconds: 3000),
        ));
      }
    });



                        },
                      child:  const Text(
                        "Log in",
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                      ),

                    ),
                  ),
                ),
              const Align(alignment: Alignment.bottomLeft,
                child: Image(image: AssetImage("assets/downLayer.png"),),
              ),

            ],
          ),
        ),
      ),
    );
  }
  getOtpFormWidget(context){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Image(image: AssetImage("assets/topLayer.png"),height: 150),

             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: Text("   Enter OTP",style: TextStyle(color: clc00a618,fontSize: 28,fontWeight: FontWeight.w600),),
                 ),
                 Padding(
                   padding:  const EdgeInsets.only(left: 40, right: 40, top: 20),
                   child: PinFieldAutoFill(
                     codeLength: 6,
                     focusNode: _pinPutFocusNode,
                     keyboardType: TextInputType.number,
                     autoFocus: true,
                     controller: otpController,
                     currentCode: "",
                     decoration:  BoxLooseDecoration(
                       textStyle: const TextStyle( color: Colors.black),
                       radius: const Radius.circular(5), strokeColorBuilder: const FixedColorBuilder(Colors.black38),
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
                           Code = pin;
                         });
                       }
                     },
                   ),

                 ),
               ],
             ),

              showLoading
                  ?  Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(color: cWhite,),
              ) : Container(),
              const Align(alignment: Alignment.bottomLeft,
                child: Image(image: AssetImage("assets/downLayer.png"),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor:Colors.black,

          key: scaffoldKey,
          body: Container(
            child: currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),

            // padding: const EdgeInsets.all(16),
          )),
    );
  }
}
