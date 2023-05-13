import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/colors.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';

class PnrSearching extends StatelessWidget {
  final String username;

  const PnrSearching({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
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
                  color: themecolor,
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/white.png",
                    ),
                    fit: BoxFit.fill,
                  )),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, right: 20),
                    child: InkWell(
                        onTap: () {
                          adminProvider.logOutAlert(context);
                        },
                        child: const Icon(
                          Icons.logout,
                          size: 30,
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/Frame49.png",
                          scale: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 80),
              child: Text(
                "Enter Your PNR",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: Colors.white),
              ),
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
                      controller: adminProvider.pnrController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter PNR',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                ),
              ),
            ),
            Consumer<AdminProvider>(builder: (context, val, child) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 37),
                  child: InkWell(
                    onTap: () {
                      adminProvider.checkingPnr(
                          adminProvider.pnrController.text, context, username);
                    },
                    child: Container(
                        height: 40,
                        width: width / 1.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Textclr),
                        child: const Center(
                            child: Text(
                          "SUBMIT",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ))),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
