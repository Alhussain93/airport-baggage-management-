import 'package:flutter/material.dart';

import '../constant/colors.dart';

class AddStaff extends StatelessWidget {
  const AddStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*.1,),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 15),
              child: const Text(
                "Add New Staff",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: "Poppins-SemiBold"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                child: Container(
                  height: 40,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    color: basewhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                      autofocus: false,
                      // obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Container(
                  height: 40,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    color: basewhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                      autofocus: false,
                      // obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Staff ID',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Container(
                  height: 40,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    color: basewhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                      autofocus: false,
                      // obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      )),
                ),
              ),
            ),
SizedBox(height: height*.1,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: 48,
                  width: width/1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Textclr
                  ),
                  child: Center(child: Text("Submit",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'Poppins-SemiBold'),)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
