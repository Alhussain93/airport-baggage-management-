import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/colors.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';

class PnrSearching extends StatelessWidget {
   String username,userPhone,userImage,emailId,passengerId,mobile;

   PnrSearching({Key? key, required this.username,required this.userPhone,required this.userImage,required this.emailId,required this.passengerId,required this.mobile,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () =>adminProvider.showExitPopup(context) ,
      child: Scaffold(
        backgroundColor: themecolor,
        endDrawer:Container(
          width: 220,
          child: Drawer(

            backgroundColor: themecolor,
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height*.3,color: darkThemeColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 45,left: 20),
                        child: userImage != ""
                            ? CircleAvatar(
                            backgroundColor: cWhite,
                            radius: 30,
                            backgroundImage:
                            NetworkImage(userImage))
                            : CircleAvatar(
                          backgroundColor: cWhite,
                          radius: 30,
                          backgroundImage:
                          const AssetImage("assets/user.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17,top: 10),
                        child: Text(username,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),Padding(
                        padding: const EdgeInsets.only(left: 17,top:2),
                        child: Text(mobile,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
                      ),Padding(
                        padding: const EdgeInsets.only(left: 17,top:2),
                        child: Text(emailId,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                      ),Padding(
                        padding: const EdgeInsets.only(left: 17,top:2),
                        child: Text(passengerId,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                      ),




                    ],
                  ),
                ),

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () {
                      adminProvider.logOutAlert(context);
                    },
                    child: Container(
                      height: 40,
                      width: width * .77,
                      color: darkThemeColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Log Out",
                            style: TextStyle(
                                color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ) ,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor:basewhite,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height / 3.3,
                width: width,
                decoration: BoxDecoration(
                    color: themecolor,
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/white.png",
                      ),
                      fit: BoxFit.fill,
                    )),
                child: Column(
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
              ),
              const Padding(
                padding: EdgeInsets.only(left: 28, top: 80),
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
                        adminProvider.checkingPnr(adminProvider.pnrController.text, context, username,userPhone);
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
      ),
    );
  }
}
