import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';

import '../AdminView/add_staff.dart';
import '../admin_model/add_staff_model.dart';
import '../strings.dart';
import '../update.dart';

class AdminProvider with ChangeNotifier {
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;


  TextEditingController NameController = TextEditingController();
  TextEditingController StaffidController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  List modellist = [];

  String airportName ='';

  Future<void> lockAdminApp() async {
    mRootReference.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['ADMINAPPVERSION'].toString().split(',');
        for (var ee in versions) {
          print(ee.toString() + "jvnfjvnjfvn");
        }
        for (var k in versions) {}
        if (!versions.contains(appVersion)) {
          String ADDRESS = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();

          runApp(MaterialApp(
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

  Future<void> lockApp() async {
    mRootReference.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['APPVERSION'].toString().split(',');
        for (var ee in versions) {
          print(ee.toString() + "jvnfjvnjfvn");
        }
        if (!versions.contains(appVersion)) {
          String ADDRESS = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();

          runApp(MaterialApp(
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

  void addData() {
    String id = DateTime.now()
        .microsecondsSinceEpoch
        .toString(); //this code is genarate auto id;
    Map<String, Object> dataMap = HashMap();
    dataMap["NAME"] = NameController.text;
    dataMap["STAFF_ID"] = StaffidController.text;
    dataMap["EMAIL"] = EmailController.text;
    dataMap["AIRPORT"] = airportName.toString();

    db.collection("STAFF").doc(id).set(dataMap);
    notifyListeners();
  }

  void getdataa() {
    modellist.clear();
    db.collection("STAFF").get().then((value) {
      for (var element in value.docs) {
        Map<dynamic, dynamic> map = element.data();
        modellist.add(
            AddStaffModel(
              element.id.toString(),
              map["NAME"].toString(),
              map["STAFF_ID"].toString(),
              map["EMAIL"].toString(),
              // element.id,
          ),
        );
        // searchlist = modellist;
        notifyListeners();

        // print(modellist.length.toString() + "ASas");
        //  print(map);
      }
      notifyListeners();
    });
  }
  void clearStaff(){
     NameController.clear();
     StaffidController.clear();
     EmailController.clear();
     notifyListeners();
  }
  void deleteData(BuildContext context ,String id) {
    db.collection("STAFF").doc(id).delete();
    finish(context);
    notifyListeners();
  }
}
