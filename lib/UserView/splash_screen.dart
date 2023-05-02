import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:luggage_tracking_app/UserView/tracking_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../AdminView/home_screen.dart';
import '../Users/login_Screen.dart';
import '../constant/colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? packageName;

  @override
  void initState() {
    getPackageName();
    super.initState();
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);

    Timer(const Duration(seconds: 3), () {



      if(packageName=='com.spine.luggage_tracking_app_admin'){
        adminProvider.lockAdminApp();
      }else {
        adminProvider.lockApp();
      }
      FirebaseAuth auth = FirebaseAuth.instance;
      var user = auth.currentUser;
if(packageName=='com.spine.luggage_tracking_app'){
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}else if(packageName=='com.spine.luggage_tracking_app_admin'){
  adminProvider.fetchCustomers();

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

}else if(user==null){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));


}



    });
  }



  @override
  Widget build(BuildContext context) {
    return initwidget();
  }

  Widget initwidget() {
    return Scaffold(
      backgroundColor: themecolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("LOGO",style: TextStyle(color: clc00a618,fontSize: 36,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }

  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      packageName = packageInfo.packageName;

    });
  }
}
