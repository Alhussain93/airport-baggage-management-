import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/colors.dart';

class PnrSearching extends StatelessWidget {
  const PnrSearching({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themecolor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height / 2.6,
              width: width,
              decoration: BoxDecoration(
                  color:themecolor,
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/white.png",
                    ),
                    fit: BoxFit.fill,
                  )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: Container(
                      alignment: Alignment.center,
                      height: 250,
                      width: 250,
                      child: Text("LOGO",style: TextStyle(color: clc00a618,fontSize: 34,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 80),
              child: Text("Enter Your PNR",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 22,color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Container(
                  height: 40,
                  width: width / 1.2,
                  decoration: BoxDecoration(
                    color: basewhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 0.1,
                        spreadRadius: 0.1,
                      )
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                      autofocus: false,
                      // obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter PNR',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 37),
                child: Container(
                  height: 40,
                  width: width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Textclr
                  ),
                  child: Center(child: Text("SUBMIT",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),))
                  ),
              ),
              ),
             ],
        ),
      ),
    );
  }
}
