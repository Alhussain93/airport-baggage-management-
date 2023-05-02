import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:luggage_tracking_app/model/customer_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../strings.dart';
import '../update.dart';

class AdminProvider with ChangeNotifier{
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool showTick = false;
  DateTime birthDate = DateTime.now();
  var outputDayNode = DateFormat('d/MM/yyy');
  List<CustomerModel> customersList = [];


  TextEditingController userPhoneCT = TextEditingController();
  TextEditingController userNameCT = TextEditingController();
  TextEditingController userEmailCT = TextEditingController();
  TextEditingController userDobCT = TextEditingController();


  void dateSetting(DateTime birthDate) {

    userDobCT.text = outputDayNode.format(birthDate).toString();

  }
  Future<void> selectDOB(BuildContext context) async {
    // userAgeController.text = "";
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != birthDate) {
      birthDate = pickedDate;
      dateSetting(birthDate);
      DateTime dateNow = DateTime.now();
      int k = dateNow.difference(birthDate).inDays ~/ 365;
      // userAgeController.text = " $k";
      // howOldAreYou = k;
    }
    notifyListeners();
  }

  void clearUserContollers(){
    userPhoneCT.clear();
    userNameCT.clear();
    userEmailCT.clear();
    userDobCT.clear();
    notifyListeners();

  }

  void userRegistration(BuildContext context,String addedBy,String userId,String from){
    print("jjdsmcdckdscdfegrrfe");
    HashMap<String, Object> userMap = HashMap();
    HashMap<String, Object> editMap = HashMap();

    String key = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    userMap['ADDED_BY'] =addedBy;
    userMap['NAME'] = userNameCT.text;
    userMap['PHONE_NUMBER'] = "91${userPhoneCT.text}";
    userMap['EMAIL'] = userEmailCT.text;
    userMap['TYPE'] = 'CUSTOMER';
    userMap['USER_ID'] = key;
    userMap["DOB"] = birthDate;
    userMap["DOB STRING"] = userDobCT.text;


    editMap["DOB STRING"] = userDobCT.text;
    editMap["DOB"] = birthDate;
    editMap['EMAIL'] = userEmailCT.text;
    editMap['PHONE_NUMBER'] = "91${userPhoneCT.text}";
    editMap['NAME'] = userNameCT.text;


    if(from=="EDIT"){
  db.collection('USERS').doc(userId).set(editMap);

}else{
  db.collection('USERS').doc(key).set(userMap);
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(
    content: Text("Registration successful..."),
    duration: Duration(milliseconds: 3000),
  ));
}

    finish(context);
    notifyListeners();
  }



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

  void fetchCustomers(){
    print("dshjskmdcfgf");
    db.collection("USERS").where("TYPE",isEqualTo:"CUSTOMER").get().then((value) {
     if(value.docs.isNotEmpty){
       customersList.clear();
       for (var element in value.docs) {
         Map<dynamic, dynamic> map = element.data();

         customersList.add(CustomerModel(element.id, map["NAME"].toString(), map["PHONE_NUMBER"].toString(), map["DOB STRING"].toString(),));
       }
       notifyListeners();

  }

  });

}


void fetchCustomersForEdit(String userId){
    db.collection("USERS").doc(userId).get().then((value) async {
    if (value.exists) {
      Map<dynamic, dynamic> map = value.data() as Map;
      userNameCT.text = map["NAME"].toString();
      userEmailCT.text = map["EMAIL"].toString();
      userDobCT.text = map["DOB STRING"].toString();
      userPhoneCT.text = map["PHONE_NUMBER"].toString().replaceAll("+91", '');
    }
    notifyListeners();
  });


}


}