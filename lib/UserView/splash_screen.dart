import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Providers/loginProvider.dart';
import '../StaffView/staff_home_screen.dart';
import '../Users/login_Screen.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';

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
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    Timer(const Duration(seconds: 3), () {
      adminProvider.lockApp();
      adminProvider.fetchCustomers();
      adminProvider.fetchTicketsList();
      adminProvider.fetchStaff();


      // if (user == null) {
        // adminProvider.fetchCountryJson();

        // CountryCode("Oman", "OM", "+968");
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      // } else {

        getSharedPreference(context);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return initwidget();
  }

  Widget initwidget() {
    return Scaffold(
      backgroundColor: cWhite,
      body: Column(
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
    );
  }

  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      packageName = packageInfo.packageName;
    });
  }


  Future<void> getSharedPreference(BuildContext context) async {
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
    SharedPreferences userPreference = await SharedPreferences.getInstance();
    final FirebaseFirestore db = FirebaseFirestore.instance;
String staffAirport='';
    String? type= userPreference.getString("TYPE");
    String? designation= userPreference.getString("DESIGNATION");
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    LoginProvider loginProvider = LoginProvider();
if(type=="ADMIN"||designation=="PASSENGER"){

  loginProvider.userAuthorized(user!.phoneNumber, context);

}

  else if(userPreference.getString("STAFF_ID")!=null){
      String? StaffId= userPreference.getString("STAFF_ID");
      String? password= userPreference.getString("PASSWORD");
      loginProvider.staffAuthorized(StaffId,password, context);

  }else{
      callNextReplacement(LoginScreen(), context);
    }

}
}