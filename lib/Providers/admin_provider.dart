import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/AdminView/home_screen.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:luggage_tracking_app/model/customer_model.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart' as enc;

import '../AdminView/add_staff.dart';
import '../AdminView/generateQr_Screen.dart';
import '../admin_model/add_staff_model.dart';
import '../constant/colors.dart';
import '../strings.dart';
import '../update.dart';

class AdminProvider with ChangeNotifier {
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool showTick = false;
  DateTime birthDate = DateTime.now();
  var outputDayNode = DateFormat('d/MM/yyy');
  List<CustomerModel> customersList = [];
  List<CustomerModel> filterCustomersList = [];
  String qrData='';

  TextEditingController userPhoneCT = TextEditingController();
  TextEditingController userNameCT = TextEditingController();
  TextEditingController userEmailCT = TextEditingController();
  TextEditingController userDobCT = TextEditingController();

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  String encrypt(String plainText) {
    final key = enc.Key.fromUtf8('XedfNNHdfgCCCCvsdFRT34567nbhHHHn');
    final iv = enc.IV.fromLength(16);

    final encrypter = enc.Encrypter(enc.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return (encrypted.base64.toString());
  }

  String decrypt(String cipher) {
    final key = enc.Key.fromUtf8('XedfNNHdfgCCCCvsdFRT34567nbhHHHn');

    final iv = enc.IV.fromLength(16);

    final encrypter = enc.Encrypter(enc.AES(key));

    final decrypted2 = encrypter.decrypt64(cipher, iv: iv);

    return decrypted2;
  }

  enterQrData( String luggageId,BuildContext context) {
String userName='';
String pnrId='';

    print('how many times happend 2');


    DateTime now = DateTime.now();
    String milli = now.millisecondsSinceEpoch.toString();
db.collection("LUGGAGE").doc(luggageId).get().then((value) {
  if(value.exists){
    Map<dynamic, dynamic> map = value.data() as Map;
    userName=map["NAME"].toString();
    pnrId=map["PNR_ID"].toString();

    db.collection("QR_VALUES").doc(luggageId).get().then((value) {
      if(value.exists){
        Map<dynamic, dynamic> qrMap = value.data() as Map;

        if( qrMap["STATUS"].toString()=="SECURITY CHECKING"){

          db.collection("QR_VALUES").doc(luggageId).set({
            "LUGGAGE_ID": luggageId,
            "PNR_ID": pnrId,
            "USER_NAME": userName,
            "TIME": now,
            "TIME MILLI": milli,
            "STATUS": 'SCREENING',
          });
          String text='Screening  completed';
          showAlertDialog(context,text);





        }

        else if(qrMap["STATUS"].toString()=="SCREENING"){

          db.collection("QR_VALUES").doc(luggageId).set({
            "LUGGAGE_ID": luggageId,
            "PNR_ID": pnrId,
            "USER_NAME": userName,
            "TIME": now,
            "TIME MILLI": milli,
            "STATUS": 'CHECK OUT',
          });
          String text='Check out  completed';
          showAlertDialog(context,text);

        }

        else if(qrMap["STATUS"].toString()=="CHECK OUT"){
          String text='Already check out';
          showAlertDialog(context,text);

        }

      }else{
        db.collection("QR_VALUES").doc(luggageId).set({
          "LUGGAGE_ID": luggageId,
          "PNR_ID": pnrId,
          "USER_NAME": userName,
          "TIME": now,
          "TIME MILLI": milli,
          "STATUS": 'SECURITY CHECKING',
        });

        String text='Security checking completed';
        showAlertDialog(context,text);

      }

    });


  }

});


  }

  showAlertDialog(BuildContext context,String text) {

    // set up the button
    Widget okButton = Container(
      height: 38,
      width: 90,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        color: Textclr,

      ),
      child: TextButton(
        child: const Text("OK",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
        onPressed: () { callNextReplacement(HomeScreen(), context);},
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      content: Text(text,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w500) ,),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  void filterCustomerList(String item){
    filterCustomersList = customersList.where((a) =>
    a.name.toLowerCase().contains(item.toLowerCase()) ||
        a.phone.toLowerCase().contains(item.toLowerCase())).toList();
    notifyListeners();
  }
  void filterStaffList(String item){
    filtersStaffList = modellist.where((a) =>
    a.Name.toLowerCase().contains(item.toLowerCase()) ||
        a.StaffId.toLowerCase().contains(item.toLowerCase())).toList();
    notifyListeners();
  }
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

  void clearUserControllers(){
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

/// generate qr controllers
  TextEditingController qrPnrCT = TextEditingController();
  TextEditingController qrUserNameCT = TextEditingController();

void clearQrControllers(){
  qrPnrCT.clear();
  qrUserNameCT.clear();

}


  TextEditingController NameController = TextEditingController();
  TextEditingController StaffidController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  List <AddStaffModel>modellist = [];
  List <AddStaffModel>filtersStaffList = [];

  String staffAirportName = 'Select';
bool qrScreen=false;
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


  void generateQrCode(BuildContext context){

    HashMap<String, Object> qrMap = HashMap();
      qrData = DateTime.now().millisecondsSinceEpoch.toString() + getRandomString(4);
    String key = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    qrMap['NAME'] = qrUserNameCT.text;
    qrMap['PNR_ID'] = qrPnrCT.text;
    qrMap['LUGGAGE_ID'] = qrData;
    db.collection("LUGGAGE").doc(qrData).set(qrMap);
    qrScreen=true;
    notifyListeners();

    callNext( GenerateQrScreen(qrData: qrData,), context);

  }
  void fetchCustomers(){
    print("dshjskmdcfgf");
    db.collection("USERS").where("TYPE",isEqualTo:"CUSTOMER").get().then((value) {
     if(value.docs.isNotEmpty){
       customersList.clear();
       filterCustomersList.clear();
       for (var element in value.docs) {
         Map<dynamic, dynamic> map = element.data();

         customersList.add(CustomerModel(element.id, map["NAME"].toString(), map["PHONE_NUMBER"].toString(), map["DOB STRING"].toString(),));
       }
       filterCustomersList=customersList;
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


  void getdataa() {
    modellist.clear();
    filtersStaffList.clear();

    db.collection("STAFF").get().then((value) {
      for (var element in value.docs) {
        Map<dynamic, dynamic> map = element.data();
        modellist.add(AddStaffModel(
            element.id.toString(),
            map["NAME"].toString(),
            map["STAFF_ID"].toString(),
            map["EMAIL"].toString(),
            // element.id,
          ),
        );
        filtersStaffList=modellist;
        // searchlist = modellist;
        notifyListeners();

        // print(modellist.length.toString() + "ASas");
        //  print(map);
      }
      notifyListeners();
    });
  }



  void addData(BuildContext context, String from, String userId) {
    String id = DateTime.now()
        .microsecondsSinceEpoch
        .toString(); //this code is genarate auto id;
    Map<String, Object> dataMap = HashMap();
    dataMap["NAME"] = NameController.text;
    dataMap["STAFF_ID"] = StaffidController.text;
    dataMap["EMAIL"] = EmailController.text;
    dataMap["AIRPORT"] = staffAirportName.toString();
    if (from == '') {
      db.collection("STAFF").doc(id).set(dataMap);
    } else {
      db.collection("STAFF").doc(userId).update(dataMap);
    }
    notifyListeners();
    getdataa();
    finish(context);
    notifyListeners();
  }


  void clearStaff() {
    NameController.clear();
    StaffidController.clear();
    EmailController.clear();
    notifyListeners();
  }

  void deleteData(BuildContext context, String id) {
    db.collection("STAFF").doc(id).delete();
    getdataa();
    finish(context);
    notifyListeners();
  }

  void editStaff(String id) {
    db.collection("STAFF").doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        print(map.toString() + "ijuygtfr");
        NameController.text = map['NAME'].toString();
        StaffidController.text = map['STAFF_ID'].toString();
        staffAirportName = map['AIRPORT'].toString();
        EmailController.text = map['EMAIL'].toString();
      }
    });
    notifyListeners();
  }
}
