import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/colors.dart';

class UserRegistrationScreen extends StatelessWidget {
  const UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

              Text("   Registration",style: TextStyle(color: clc00a618,fontSize: 30,fontWeight: FontWeight.w600),),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
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
                          hintText: 'Name',
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10)
                        ],
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10)
                        ],
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
                          hintText: 'Email',
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

              SizedBox(height: height*.05,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,),
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
                      "Register",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                    ),

                  ),
                ),
              ),
              // SizedBox(height: height*.4),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Image(image: AssetImage("assets/downLayer.png"),height: 140,)),

            ],
          ),
        ),
      ),

    );
  }
}
