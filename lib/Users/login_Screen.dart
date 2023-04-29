import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../Constants/my_colors.dart';
import '../Providers/loginProvider.dart';

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

  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  late BuildContext context;
  String Code = "";
  late String verificationId;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpPage = false;

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          // color: Colors.cyan,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Image(image: AssetImage("assets/topLayer.png"),height: 150),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("   Log in",style: TextStyle(color: clc00a618,fontSize: 28,fontWeight: FontWeight.w600),),

                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

                      elevation: 1,
                      child: TextFormField(
                        // controller: value.productPointCT,
                        style: TextStyle(
                            color: cntinercolr,
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
                          hintStyle: TextStyle(

                              color: Colors.black54,
                              fontSize: 17,
                              fontFamily: "PoppinsMedium"),
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
                              color: Colors.grey.shade300,
                            ),
                          ),
                          hintText: 'Mobile number',
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Point";
                          } else if (!RegExp(r'^[0-9.]+$')
                              .hasMatch(value)) {
                            return "Enter Correct Data";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: height*.1,),
              Padding(
                padding: const EdgeInsets.only(left: 23,right: 23,top: 35),
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
                        MaterialStateProperty.all(Color(0xff432244))),
                    onPressed: () {
                      // Navigator.pushNamed(context, newLoginScreen ,arguments: {'type': type});

                    },
                    child:  Text(
                      "Log in",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                    ),

                  ),
                ),
              ),
              Align(alignment: Alignment.bottomLeft,
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

              Image(image: AssetImage("assets/topLayer.png"),height: 150),

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
                       radius: const Radius.circular(5), strokeColorBuilder: FixedColorBuilder(Colors.black38),
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
              Align(alignment: Alignment.bottomLeft,
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
