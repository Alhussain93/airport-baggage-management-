import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scanbkgrnd,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: width,
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.only(top: 33, left: 20),
                child: Text(
                  "Leading Department",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: height / 2.7,
                  width: width / 2,
                  child: Image.asset("assets/scan.png"),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: 48,
                  width: width / 1.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: Textclr),
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
            )
          ],
        ),
      ),
    );
  }
}
