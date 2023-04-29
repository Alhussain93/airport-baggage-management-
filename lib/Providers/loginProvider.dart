import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class LoginProvider extends ChangeNotifier {
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // String packageName = packageInfo.packageName;

  String? packageName;
  bool loader=false;

  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {
    const snackBar = SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(milliseconds: 3000),
        content: Text("Sorry , You don't have any access",
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ));

    String loginUsername = '';
    String loginUsertype = '';
    String loginUserid = '';
    String phone = phoneNumber!.substring(3, 13);


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
