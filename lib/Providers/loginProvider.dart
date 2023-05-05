import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:provider/provider.dart';

import '../AdminView/home_screen.dart';
import '../StaffView/staff_home_screen.dart';
import '../UserView/pnrsearching_screen.dart';
import '../Users/login_Screen.dart';
import '../constant/my_functions.dart';



class LoginProvider extends ChangeNotifier {
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // String packageName = packageInfo.packageName;

  String? packageName;
  bool loader=false;

  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {

    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);

    String loginUsername = '';
    String loginUsertype = '';
    String loginUserid = '';
    try {
      var phone = phoneNumber!;
      print("ahhhhhhhhhhhhh"+phone);

      // final ref= db.collection('USERS').doc(phone).get();
      db.collection("USERS").where("PHONE_NUMBER",isEqualTo:phone ).get().then((value) {
        if(value.docs.isNotEmpty){
          for(var element in value.docs){
            Map<dynamic,dynamic> map = element.data();
            loginUsername=map['NAME'].toString();
            loginUsertype= map['TYPE'].toString();
            loginUserid=element.id;

          }
          if(loginUsertype=="CUSTOMER"){
            callNextReplacement(const PnrSearching(), context);
          }else if(loginUsertype=="ADMIN"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }else if(loginUsertype=="STAFF"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StaffHomeScreen()));
          }
        }
        else {
          const snackBar = SnackBar(
              backgroundColor: Colors.white,
              duration: Duration(milliseconds: 2000),
              content: Text("Sorry , You don't have any access",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }


      });


    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Sorry , Some Error Occurred'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future<void> getPackageName() async {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // packageName = packageInfo.packageName;
      print("${packageName}packagenameee");
      notifyListeners();
    }
    void LoaderOn() {
      loader = true;
      notifyListeners();
    }
    void LoaderOFF() {
      loader = false;
      notifyListeners();
    }
  }
}
