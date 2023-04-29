import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../strings.dart';
import '../update.dart';

class AdminProvider with ChangeNotifier{
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;


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

}