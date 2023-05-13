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

    const snackBar2 = SnackBar(
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

    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);

    String loginUsername = '';
    String designation = '';
    String loginUsertype = '';
    String loginUserid = '';
    String userStatus= '';
    String staffAirport= '';
    try {
      var phone = phoneNumber!;
      // var phone = phoneNumber!.substring(3, 13);

      print("ahhhhhhhhhhhhh"+phone);

      // final ref= db.collection('USERS').doc(phone).get();
      db.collection("USERS").where("MOBILE_NUMBER",isEqualTo:phone ).get().then((value) {
        if(value.docs.isNotEmpty){
          for(var element in value.docs){
            Map<dynamic,dynamic> map = element.data();
            loginUsername=map['NAME'].toString();
            designation=map['DESIGNATION'].toString();
            loginUsertype= map['TYPE'].toString();
            userStatus= map['STATUS'].toString();
            loginUserid=element.id;

          }
          if(designation=="PASSENGER"){
            if(userStatus=="ACTIVE") {
              adminProvider.pnrController.clear();
              callNextReplacement( PnrSearching(username: loginUsername), context);
            }else{


              ScaffoldMessenger.of(context).showSnackBar(snackBar2);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut();
            }
          }else if(loginUsertype=="ADMIN"){
            adminProvider.fetchMissingLuggage();

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(addedBy: loginUsername,)));
          }else if(loginUsertype=="STAFF"){
            if(userStatus=="ACTIVE") {
              db.collection('STAFF').doc(loginUserid).get().then((value) {
                if (value.exists) {
                  staffAirport = value.get('AIRPORT');
                  adminProvider.fetchMissingLuggage();

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StaffHomeScreen(designation:designation, stfAirport: staffAirport, addedBy:loginUsername, stfName: loginUsername,)));

                }
              });

            }else{


              ScaffoldMessenger.of(context).showSnackBar(snackBar2);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut();

            }
          }
        }
        else {

          ScaffoldMessenger.of(context).showSnackBar(snackBar2);
        }


      });


    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Sorry , Some Error Occurred'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}
