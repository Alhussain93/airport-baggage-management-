import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking_app/constant/colors.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import '../Providers/loginProvider.dart';
import '../constant/my_functions.dart';

class StaffLogin extends StatefulWidget {

   StaffLogin({Key? key}) : super(key: key);

  @override
  State<StaffLogin> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                  image: AssetImage("assets/topLayer.png"), height: 150),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "   STAFF LOG IN",
                    style: TextStyle(
                        color: clc00a618,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: Consumer<LoginProvider>(
                        builder: (context, value1, child) {
                          return Container(
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(11))),
                            child: TextFormField(
                              controller: value1.staffLoginIdController,
                              style: TextStyle(color: fontColor, fontSize: 20),
                              autofocus: false,
                              decoration: InputDecoration(
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
                                    borderSide: const BorderSide(
                                      color: Colors.black38,
                                    )),
                                disabledBorder: InputBorder.none,
                                hintText: "User Id",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: Consumer<LoginProvider>(
                        builder: (context, value1, child) {
                          return Container(
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(11))),
                            child: TextFormField(
                              obscureText: _isHidden,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: value1.staffLoginPasswordController,
                              style: TextStyle(color: fontColor, fontSize: 20),
                              autofocus: false,
                              decoration: InputDecoration(
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
                                    borderSide: const BorderSide(
                                      color: Colors.black38,
                                    )),
                                disabledBorder: InputBorder.none,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    )),
                                suffixIcon:  InkWell(
                                    onTap: _togglePasswordView,
                                    child: Icon(_isHidden ? Icons.visibility_off : Icons.visibility,))
                              ),
                            ),
                          );
                        }),
                  ),

                ],
              ),
              SizedBox(
                height: height * .1,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 330,
                  child: Consumer<LoginProvider>(
                    builder: (context33,value33,child) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff432244))),
                        onPressed: () async {

                          value33.staffAuthorized(value33.staffLoginIdController.text, value33.staffLoginPasswordController.text, context);

                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      );
                    }
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Image(
                  image: AssetImage("assets/downLayer.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
     setState(() {
       _isHidden = !_isHidden;
     });
   }
}
