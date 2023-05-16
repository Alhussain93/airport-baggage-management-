import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:luggage_tracking_app/model/customer_model.dart';
import 'package:luggage_tracking_app/model/luggage_Model.dart';
import 'package:luggage_tracking_app/model/tickets_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../AdminView/add_staff.dart';
import '../AdminView/generateQr_Screen.dart';
import '../StaffView/add_tickets.dart';
import '../StaffView/staff_home_screen.dart';
import '../UserView/contryCodeModel.dart';
import '../UserView/splash_screen.dart';
import '../UserView/tracking_screen.dart';
import '../Users/login_Screen.dart';
import '../admin_model/add_staff_model.dart';
import '../constant/colors.dart';
import '../model/missing_Lagguage_Model.dart';
import '../pnr_model_class.dart';
import '../strings.dart';
import '../update.dart';
import 'package:pdf/widgets.dart' as pw;

class AdminProvider with ChangeNotifier {
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool showTick = false;
  DateTime birthDate = DateTime.now();
  var outputDayNode = DateFormat('d/MM/yyy');
  List<CustomerModel> customersList = [];
  List<CustomerModel> filterCustomersList = [];
  List<TicketModel> ticketList = [];
  List<TicketModel> filterTicketLIst = [];
  String qrData = '';
  List<String> qrDataList = [];
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  String staffEditId = "";
  File? fileImage;
  bool imgCheck = false;
  Reference ref = FirebaseStorage.instance.ref("PROFILE_IMAGE");
  Reference ref2 = FirebaseStorage.instance.ref("PROFILE_IMAGE");
  String editImage = "";
  bool waitRegister = true;
  String passengerStatusForEdit = "";
  String passengerID = "";

  String passengerOldPhone = "";
  String staffOldPhone = "";
  String staffOldId = "";
  TextEditingController userPhoneCT = TextEditingController();
  TextEditingController userNameCT = TextEditingController();
  TextEditingController userEmailCT = TextEditingController();
  TextEditingController userDobCT = TextEditingController();




  List<CountryCode> countryCodeList = [];

  bool carouselCheck = false;
  String? selectedValue = "+968";
  String country = '';
  String code = "";
  bool countrySlct = false;

  TextEditingController pnrController = TextEditingController();

  List<PnrModel> checkList = [];
  List<LuggageModel> luggageList = [];
  List<MissingLuggage> missingLuggageList = [];
  List<String> airportNameList = [
    'Select Airport',
    "Salalah International Airport",
    "Duqm International Airport",
    "Sohar International Airport",
    'Khasab Airport'
  ];

  void changeStaffStatus(String staffId,String designation,String phone,BuildContext context){
    String loginUsername = '';
    String stfDesignation = '';
    String userStatus = '';
    String staffAirport = '';
    db.collection("USERS").doc(staffId).set({"DESIGNATION": designation,}, SetOptions(merge: true));
    db.collection("STAFF").doc(staffId).set({"DESIGNATION": designation,}, SetOptions(merge: true));
    notifyListeners();
    db.collection("USERS")
        .where("MOBILE_NUMBER", isEqualTo: phone)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<dynamic, dynamic> map = value.docs.first.data();
        loginUsername = map['NAME'].toString();
        userStatus = map['STATUS'].toString();
        stfDesignation = map['DESIGNATION'].toString();

        if (userStatus == "ACTIVE") {
          db.collection('STAFF').doc(staffId).get().then((value) {
            if (value.exists) {
              staffAirport = value.get('AIRPORT');
             fetchMissingLuggage();

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StaffHomeScreen(
                        designation: stfDesignation,
                        stfAirport: staffAirport,
                        addedBy: loginUsername,
                        stfName: loginUsername, staffId: staffId, phone:phone,
                      )));
            }
          });
        }


      }
        });
    
    
  }
  

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  const SizedBox(height: 19),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                          child: const Text("Yes"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Text("No",
                                style: TextStyle(color: Colors.black)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }


  checkingPnr(String pnrControllerText, BuildContext context, String username) {
    db.collection("LUGGAGE").where("PNR_ID", isEqualTo: pnrControllerText).get().then((value) {
      checkList.clear();
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          checkList.add(PnrModel(
              element.id,
              map["LUGGAGE_ID"].toString(),
              map["NAME"].toString(),
              map["PNR_ID"].toString(),
              map["STATUS"].toString()));
        }
        // checkList.sort(
        //   (b, a) => b.lagagenumber.compareTo(a.lagagenumber),
        // );
        if (checkList.length!=0) {
          luggageTracking(checkList[0].id);
          callNext(TrackingScreen(pnrid: pnrControllerText, username: username,), context);
        }
      } else {
        final snackBar = SnackBar(
          elevation: 6.0,
          backgroundColor: cWhite,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: const Text(
            "Not Checked In !!!",
            style: TextStyle(color: Colors.red),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  luggageTracking(String lid,) {
    luggageList.clear();
    db.collection("LUGGAGE").doc(lid).snapshots().listen((event) {
      Map<dynamic, dynamic> map = event.data() as Map;

      luggageList.add(LuggageModel(
          map['LUGGAGE_ID'] ?? "",
          map["PNR_ID"] ?? "",
          map['CHECK_IN_AIRPORT'] ?? "",
          map['CHECK_IN_TIMEMILLI'] ?? "",
          map['LOADING_AIRPORT'] ?? "",
          map['LOADED_TIMEMILLI'] ?? "",
          map['UNLOADING_AIRPORT'] ?? "",
          map['UNLOADED_TIMEMILLI'] ?? "",
          map['CHECKOUT_AIRPORT'] ?? "",
          map['CHECKOUT_TIMEMILLI'] ?? "",
          map['STATUS'] ?? "",
          map["CHECK_IN_STAFF_NAME"] ?? "",
          map["LOADING_STAFF_NAME"] ?? "",
          map["UNLOADING_STAFF_NAME"] ?? "",
          map["CHECKOUT_STAFF_NAME"] ?? "",
          map["CHECK_IN_STATUS"] ?? "",
          map["LOADING_STATUS"] ?? "",
          map["UNLOADING_STATUS"] ?? "",
          map["CHECKOUT_STATUS"] ?? "",
          map["MISSING_PLACE"] ?? "",
          map["ARRIVAL_TIME_MILLI"] ?? "",

      ));
      notifyListeners();
    });
    notifyListeners();

  }

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

  Future<bool> checkNumberExist(String phone) async {
    var D = await db
        .collection("USERS")
        .where("MOBILE_NUMBER", isEqualTo: phone)
        .get();

    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkStaffIdExist(String staffId) async {
    var D = await db
        .collection("STAFF")
        .where("STAFF_ID", isEqualTo: staffId)
        .get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkPnrIdExist(String pnrID) async {
    var D =
        await db.collection("TICKETS").where("PNR_ID", isEqualTo: pnrID).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  statusUpdateQrData(String luggageId, String staffDes, String staffAir,
      String stfName, BuildContext context2) {
    DateTime now = DateTime.now();
    String milli = now.millisecondsSinceEpoch.toString();

    db.collection("LUGGAGE").doc(luggageId).get().then((value) async {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;

        if (staffDes == "LOADING") {
          if(map["CHECK_IN_STATUS"]=="CLEARED"){
            db.collection("LUGGAGE").doc(luggageId).set({
              "LOADED_TIMEMILLI": milli,
              "LOADED_TIME": now,
              "STATUS": 'LOADING',
              "LOADING_AIRPORT": staffAir,
              "LOADING_STAFF_NAME": stfName,
              "LOADING_STATUS": "CLEARED",
              "LAST_SCANNED_DATEMILLI": milli,
              "LAST_SCANNED_DATE": now,
            }, SetOptions(merge: true));

            String text = 'Loading completed';
            showAlertDialog(context2, text, staffDes, stfName, staffAir);

          }else{
            String text = 'Invalid Qr, Please complete previous step';
            showAlertDialog(context2, text, staffDes, stfName, staffAir);

          }

        } else if (staffDes == "UNLOADING") {


          if(map["LOADING_STATUS"]=="CLEARED"){
            db.collection("LUGGAGE").doc(luggageId).set({
              "UNLOADED_TIMEMILLI": milli,
              "UNLOADED_TIME": now,
              "STATUS": 'UNLOADING',
              "UNLOADING_AIRPORT": staffAir,
              "UNLOADING_STAFF_NAME": stfName,
              "LAST_SCANNED_DATE": now,
              "LAST_SCANNED_DATEMILLI": milli,
              "LAST_SCANNED_PLACE": staffAir,
              "UNLOADING_STATUS": "CLEARED",

            }, SetOptions(merge: true));

            await checkMissingLuggageInUnloading(context2, luggageId, staffDes, stfName, staffAir);

          }else{
            String text = 'Invalid Qr, Please complete previous step';
            showAlertDialog(context2, text, staffDes, stfName, staffAir);

          }


        } else if (staffDes == "CHECK_OUT") {

          if(map["UNLOADING_STATUS"]=="CLEARED") {
            db.collection("LUGGAGE").doc(luggageId).set({
              "CHECKOUT_TIMEMILLI": milli,
              "CHECKOUT_TIME": now,
              "STATUS": 'CHECK_OUT',
              "CHECKOUT_AIRPORT": staffAir,
              "CHECKOUT_STAFF_NAME": stfName,
              "LAST_SCANNED_DATE": now,
              "LAST_SCANNED_DATEMILLI": milli,
              "LAST_SCANNED_PLACE": staffAir,
              "CHECKOUT_STATUS": "CLEARED",

            }, SetOptions(merge: true));
            await checkMissingLuggageInCheckout(context2, luggageId, staffDes, stfName, staffAir);
          }else{
            String text = 'Invalid Qr, Please complete previous step';
            showAlertDialog(context2, text, staffDes, stfName, staffAir);

          }


        }
      }
    });
  }

  void fetchMissingLuggage() {
    missingLuggageList.clear();

    db
        .collection("LUGGAGE")
        .where("MISSING", isNotEqualTo: "")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        missingLuggageList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          missingLuggageList.add(MissingLuggage(
              element.id,
              map["PNR_ID"].toString(),
              map["STATUS"].toString(),
              map["NAME"].toString(),
              map["MISSING"].toString(),
              map["ARRIVAL_PLACE"].toString(),
              map["FLIGHT_NAME"].toString(),
              map["LAST_SCANNED_DATEMILLI"].toString(),
              map["LAST_SCANNED_PLACE"].toString()));
        }
        notifyListeners();
      }
    });
  }

  void sortMissingLuggageFlightBase(String flightName) {
    missingLuggageList.clear();
    db
        .collection("LUGGAGE")
        .where("MISSING", isNotEqualTo: "")
        .where("FLIGHT_NAME", isEqualTo: flightName)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        missingLuggageList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          missingLuggageList.add(MissingLuggage(
              element.id,
              map["PNR_ID"].toString(),
              map["STATUS"].toString(),
              map["NAME"].toString(),
              map["MISSING"].toString(),
              map["ARRIVAL_PLACE"].toString(),
              map["FLIGHT_NAME"].toString(),
              map["LAST_SCANNED_DATEMILLI"].toString(),
              map["LAST_SCANNED_PLACE"].toString()));
        }
        notifyListeners();
      }
      notifyListeners();
    });
  }

  void sortMissingLuggageByDateWise(var firstDate, var lastDate) {
    missingLuggageList.clear();
    db
        .collection("LUGGAGE")
        .where("MISSING", isEqualTo: "YES")
        .where("LAST_SCANNED_DATE", isGreaterThanOrEqualTo: firstDate)
        .where("LAST_SCANNED_DATE", isLessThanOrEqualTo: lastDate)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        missingLuggageList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          missingLuggageList.add(MissingLuggage(
              element.id,
              map["PNR_ID"].toString(),
              map["STATUS"].toString(),
              map["NAME"].toString(),
              map["MISSING"].toString(),
              map["ARRIVAL_PLACE"].toString(),
              map["FLIGHT_NAME"].toString(),
              map["LAST_SCANNED_DATEMILLI"].toString(),
              map["LAST_SCANNED_PLACE"].toString()));
        }
        notifyListeners();
      }
      notifyListeners();
    });
  }

  checkMissingLuggageInUnloading(BuildContext context1, String luggageId,
      String staffDes, String staffName, String staffAirport) async {
    await db.collection("LUGGAGE").doc(luggageId).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        if (map["ARRIVAL_PLACE"] == map["UNLOADING_AIRPORT"]) {
          String text = 'Unloading completed';
          showAlertDialog(context1, text, staffDes, staffName, staffAirport);
          notifyListeners();
        } else {
          db.collection("LUGGAGE").doc(luggageId).set({
            "MISSING": "YES",
            "MISSING_PLACE": "UNLOADING",
            "UNLOADING_STATUS": "NOT",

          }, SetOptions(merge: true));
          String text = 'Airport miss matched';
          showAlertDialog(context1, text, staffDes, staffName, staffAirport);
          notifyListeners();
        }
      }
    });
  }

  checkMissingLuggageInCheckout(BuildContext context, String luggageId,
      String staffDes, String staffName, String staffAirport) async {
    await db.collection("LUGGAGE").doc(luggageId).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        if (map["ARRIVAL_PLACE"] == map["CHECKOUT_AIRPORT"]) {
          String text = 'Checkout completed';
          showAlertDialog(context, text, staffDes, staffName, staffAirport);
          notifyListeners();
        } else {
          db.collection("LUGGAGE").doc(luggageId).set({
            "MISSING": "YES",
            "MISSING_PLACE": "CHECK_OUT",
            "CHECKOUT_STATUS": "NOT",

          }, SetOptions(merge: true));
          String text = 'Airport miss matched';
          showAlertDialog(context, text, staffDes, staffName, staffAirport);
          notifyListeners();
        }
      }
    });
  }

  showAlertDialog(BuildContext context, String text, String staffDes,
      String staffName, String stsAirport) {
    // set up the button
    Widget okButton = Container(
      height: 38,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: text =="Airport miss matched"|| text == "Invalid Qr, Please complete previous step" ? txtred:Textclr,
      ),
      child: TextButton(
        child: Text(
          "OK",
          style: TextStyle(
              color:
              text == "Airport miss matched"|| text== "Invalid Qr, Please complete previous step" ? Colors.white:Colors.black ,
              fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          finish(context);
          callNextReplacement(StaffHomeScreen(designation: staffDes, stfAirport: stsAirport, addedBy: '', stfName: staffName, staffId: '', phone: ''), context);

        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      content: Text(
        text,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
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

  void filterCustomerList(String item) {
    filterCustomersList = customersList
        .where((a) =>
            a.name.toLowerCase().contains(item.toLowerCase()) ||
            a.phone.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void filterTickets(String item) {
    filterTicketLIst = ticketList
        .where((a) =>
            a.pnrId.toLowerCase().contains(item.toLowerCase()) ||
            a.flightName.toLowerCase().contains(item.toLowerCase()))
        .toList();

    notifyListeners();
  }

  void filterStaffList(String item) {
    filtersStaffList = modellist
        .where((a) =>
            a.Name.toLowerCase().contains(item.toLowerCase()) ||
            a.StaffId.toLowerCase().contains(item.toLowerCase()))
        .toList();
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

      sortMissingLuggageByDateWise(birthDate, dateNow);
    }
    notifyListeners();
  }

  final DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime secondDate = DateTime.now();
  DateTime endDate2 = DateTime.now();
  String startdateformat = '';
  String enddateformat = '';

  void showCalendarDialog(BuildContext context) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: _dateRangePickerController,
          initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) {
            _dateRangePickerController.selectedRange = val as PickerDateRange?;
            if (_dateRangePickerController.selectedRange!.endDate == null) {
              firstDate = _dateRangePickerController.selectedRange!.startDate!;
              secondDate = _dateRangePickerController.selectedRange!.startDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(hours: firstDate.hour, minutes: firstDate.minute, seconds: firstDate.second));
              sortMissingLuggageByDateWise(firstDate2, endDate2);
              notifyListeners();
            } else {
              firstDate = _dateRangePickerController.selectedRange!.startDate!;
              secondDate = _dateRangePickerController.selectedRange!.endDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              sortMissingLuggageByDateWise(firstDate2, endDate2);

              final formatter = DateFormat('dd/MM/yyyy');
              startdateformat = formatter.format(firstDate);
              enddateformat = formatter.format(secondDate);

              notifyListeners();
            }
            finish(context);
          },
          onCancel: () {
            _dateRangePickerController.selectedDate = null;
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  void clearUserControllers() {
    userPhoneCT.clear();
    userNameCT.clear();
    userEmailCT.clear();
    userDobCT.clear();
    fileImage = null;
    editImage = "";
    notifyListeners();
  }

  Future<void> userRegistration(BuildContext context1, String addedBy,
      String userId, String from, String passengerStatus) async {
    bool numberStatus = await checkNumberExist(userPhoneCT.text);
    if (!numberStatus || userPhoneCT.text == passengerOldPhone) {
      showDialog(
          context: context1,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(color: themecolor),
            );
          });
      HashMap<String, Object> userMap = HashMap();
      HashMap<String, Object> passengerMap = HashMap();
      HashMap<String, Object> passengerEditMap = HashMap();
      HashMap<String, Object> editMap = HashMap();

      String key = DateTime.now().millisecondsSinceEpoch.toString();
      passengerMap['ADDED_BY'] = addedBy;
      userMap['NAME'] = userNameCT.text;
      passengerMap['NAME'] = userNameCT.text;
      userMap['MOBILE_NUMBER'] = selectedValue! + userPhoneCT.text;
      passengerMap['COUNTRY_CODE'] = selectedValue!;
      passengerMap['MOBILE_NUMBER'] = userPhoneCT.text;
      passengerMap['COUNTRY_CODE'] = selectedValue.toString();
      passengerMap['EMAIL'] = userEmailCT.text;
      userMap['USER_ID'] = key;
      userMap['DESIGNATION'] = "PASSENGER";
      passengerMap['DESIGNATION'] = "PASSENGER";
      passengerMap['PASSENGER_ID'] = key;
      passengerMap["DOB"] = birthDate;
      passengerMap["DOB STRING"] = userDobCT.text;
      passengerMap["REGISTRATION_TIME"] = DateTime.now();
      passengerMap["STATUS"] = passengerStatus;
      userMap["STATUS"] = passengerStatus;

      if (fileImage != null) {
        String time = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance.ref().child(time);
        await ref.putFile(fileImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            passengerMap['PASSENGER_IMAGE'] = value;
            passengerEditMap['PASSENGER_IMAGE'] = value;

            notifyListeners();
          });
        });
        notifyListeners();
      } else {
        passengerMap['PASSENGER_IMAGE'] = "";
        passengerEditMap['PASSENGER_IMAGE'] = editImage;
      }
      passengerEditMap["DOB STRING"] = userDobCT.text;
      passengerEditMap["DOB"] = birthDate;
      passengerEditMap['EMAIL'] = userEmailCT.text;
      passengerEditMap['COUNTRY_CODE'] = selectedValue.toString();
      editMap['MOBILE_NUMBER'] = userPhoneCT.text;
      passengerEditMap['MOBILE_NUMBER'] = userPhoneCT.text;
      passengerEditMap['COUNTRY_CODE'] = selectedValue.toString();
      editMap['COUNTRY_CODE'] = selectedValue.toString();
      editMap['NAME'] = userNameCT.text;
      passengerEditMap['NAME'] = userNameCT.text;
      passengerEditMap["STATUS"] = passengerStatus;
      editMap["STATUS"] = passengerStatus;

      if (from == "EDIT") {
        db
            .collection('USERS')
            .doc(userId)
            .set(editMap, SetOptions(merge: true));
        db
            .collection('PASSENGERS')
            .doc(userId)
            .set(passengerEditMap, SetOptions(merge: true));
        // update(passengerEditMap);
      } else {
        db.collection('USERS').doc(key).set(userMap);
        db.collection('PASSENGERS').doc(key).set(passengerMap);
        ScaffoldMessenger.of(context1).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Registration successful..."),
          duration: Duration(milliseconds: 3000),
        ));
      }
      finish(context1);
      finish(context1);
      notifyListeners();
    } else {
      final snackBar = SnackBar(
        elevation: 6.0,
        backgroundColor: themecolor,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Text(
          "Number Already Exist...",
          style: TextStyle(color: cWhite),
        ),
      );
      ScaffoldMessenger.of(context1).showSnackBar(snackBar);
    }
  }

  /// generate qr controllers
  TextEditingController qrPnrCT = TextEditingController();
  TextEditingController qrUserNameCT = TextEditingController();
  TextEditingController qrLuggageCountCT = TextEditingController();

  TextEditingController ticketFromController = TextEditingController();
  TextEditingController ticketToController = TextEditingController();
  TextEditingController passengerCountController = TextEditingController();
  TextEditingController ticketPnrController = TextEditingController();
  TextEditingController arrivalTime = TextEditingController();
  TextEditingController departureTime = TextEditingController();
  TextEditingController ticketPassengersController = TextEditingController();

  List<dynamic> ticketNameList = [];

  void clearQrControllers() {
    qrLuggageCountCT.clear();
    qrPnrCT.clear();
    qrUserNameCT.clear();
    flightName = 'Select Flight Name';
  }

  void clearTicketControllers() {
    previousPnrId = '';
    ticketFromController.clear();
    ticketToController.clear();
    passengerCountController.clear();
    ticketPnrController.clear();
    ticketFlightName = 'Select Flight Name';
    arrivalTime.clear();
    departureTime.clear();
    ticketPassengersController.clear();
    ticketNameList.clear();
  }

  TextEditingController NameController = TextEditingController();
  TextEditingController StaffidController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  List<AddStaffModel> modellist = [];
  List<AddStaffModel> filtersStaffList = [];

  String staffAirportName = 'Select Airport';
  String designation = 'Select Designation';
  String flightName = 'Select Flight Name';
  String staffDesignation = 'CHECK_IN';
  String ticketFlightName = 'Select Flight Name';
  String airportName = '';
  String fromTicket = 'Select Airport';
  String toTicket = 'Select Airport';
  List<String> flightNameList = [
    "Select Flight Name",
    "Air Arabia Abu dhabi",
    "Vistara",
    "Air india Express",
    'Srilankan Airlines',
    'Etihad Airways'
  ];
  List<String> staffDesignationList = [
    "CHECK_IN",
    "LOADING",
    "UNLOADING",
    "CHECK_OUT",
  ];

  List<String> fromList = [
    "From",
    "Select Flight Name",
    "Air Arabia Abu dhabi",
    "Vistara",
    "Air india Express",
    'Srilankan Airlines',
    'Etihad Airways'
  ];
  List<String> toList = [
    "To",
    "Select Flight Name",
    "Air Arabia Abu dhabi",
    "Vistara",
    "Air india Express",
    'Srilankan Airlines',
    'Etihad Airways'
  ];

  Future<void> lockAdminApp() async {
    mRootReference.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['ADMINAPPVERSION'].toString().split(',');
        for (var ee in versions) {}
        for (var k in versions) {}
        if (!versions.contains(appVersion)) {
          String address = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();

          runApp(MaterialApp(
            home: Update(
              ADDRESS: address,
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
        for (var ee in versions) {}
        if (!versions.contains(appVersion)) {
          String address = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();

          runApp(MaterialApp(
            home: Update(
              ADDRESS: address,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

  void checkPnrIdExists(String pnrId, BuildContext context) {
    db
        .collection("TICKETS")
        .where("PNR_ID", isNotEqualTo: pnrId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No data found ",
              style: TextStyle(color: Colors.white),
            )));
      }
    });
  }

  checkPnrIDExist(String pnrId, BuildContext context, String staffAirport,
      String stfName) async {
    String arrivalPlace = '';
    String flightName = '';
    String arrivalTimeMilli = '';

    db
        .collection("TICKETS")
        .where("PNR_ID", isEqualTo: pnrId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<dynamic, dynamic> map = value.docs.first.data();
        arrivalPlace = map["TO"].toString();
        flightName = map["FLIGHT_NAME"].toString();
        arrivalTimeMilli = map["ARRIVAL_DATE_MILLI"].toString();
        notifyListeners();
        generateQrCode(
            context, staffAirport, stfName, arrivalPlace, flightName,arrivalTimeMilli);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Sorry, No PNR ID found..."),
          duration: Duration(milliseconds: 3000),
        ));
      }
    });
  }

  void generateQrCode(BuildContext context, String staffAirport, String stfName,
      String arrivalPlace, String flightName, String arrivalTime) {
    HashMap<String, Object> qrMap = HashMap();
    qrDataList.clear();
    int luggageCount = int.parse(qrLuggageCountCT.text);
    for (int i = 0; i < luggageCount; i++) {
      String qrID = DateTime.now().millisecondsSinceEpoch.toString();
      qrData =
          DateTime.now().millisecondsSinceEpoch.toString() + getRandomString(4);
      DateTime now = DateTime.now();
      qrMap['PNR_ID'] = qrPnrCT.text;
      qrMap['QR_ID'] = qrID;
      qrMap['ARRIVAL_PLACE'] = arrivalPlace;
      qrMap['ARRIVAL_TIME_MILLI'] = arrivalTime;
      qrMap['FLIGHT_NAME'] = flightName;
      qrMap['LUGGAGE_ID'] = qrData;
      qrMap['DATE'] = qrID;
      qrMap['STATUS'] = "CHECK_IN";
      qrMap['CHECK_IN_STATUS'] = "CLEARED";
      qrMap['CHECK_IN_TIMEMILLI'] = qrID;
      qrMap['CHECK_IN_TIME'] = now;
      qrMap['CHECK_IN_STAFF_NAME'] = stfName;
      qrMap['CHECK_IN_AIRPORT'] = staffAirport;
      qrDataList.add(qrData);
      db.collection("LUGGAGE").doc(qrData).set(qrMap);
      notifyListeners();
    }

    callNext(
        GenerateQrScreen(
          qrDatasList: qrDataList,
          qrId: qrData,
        ),
        context);
    clearQrControllers();

  }

  void fetchCustomers() {
    db
        .collection("PASSENGERS")
        .where("STATUS", isNotEqualTo: "DELETED")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        customersList.clear();
        filterCustomersList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          customersList.add(CustomerModel(
            element.id,
            map["NAME"].toString(),
            map["MOBILE_NUMBER"].toString(),
            map["COUNTRY_CODE"].toString(),
            map["DOB STRING"].toString(),
            map["PASSENGER_IMAGE"]??"",
            map["STATUS"].toString(),
          ));
        }
        filterCustomersList = customersList;
        notifyListeners();
      }
    });
  }

  void fetchCustomersForEdit(String userId) {
    db.collection("PASSENGERS").doc(userId).get().then((value) async {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        userNameCT.text = map["NAME"].toString();
        userEmailCT.text = map["EMAIL"].toString();
        userDobCT.text = map["DOB STRING"].toString();
        passengerOldPhone = userPhoneCT.text = map["MOBILE_NUMBER"].toString();
        passengerStatusForEdit = map["STATUS"].toString();
        selectedValue = map["COUNTRY_CODE"].toString();
        editImage = map["PASSENGER_IMAGE"] ?? "";
      }
      notifyListeners();
    });
  }

  void fetchStaff() {
    modellist.clear();
    filtersStaffList.clear();

    db
        .collection("STAFF")
        .where("STATUS", isNotEqualTo: "DELETED")
        .snapshots()
        .listen((event) {
      modellist.clear();
      filtersStaffList.clear();
      for (var element in event.docs) {
        Map<dynamic, dynamic> map = element.data();
        modellist.add(
          AddStaffModel(
              element.id.toString(),
              map["NAME"].toString(),
              map["STAFF_ID"].toString(),
              map["PROFILE_IMAGE"]??"",
              map["MOBILE_NUMBER"].toString(),
              map["STATUS"].toString()),
        );
        filtersStaffList = modellist;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  String newPath = "";
  String pdfPath = '';

  Future<void> addStaff(BuildContext context, String from, String userId,
      String status, String addedBy) async {
    bool idStatus = await checkStaffIdExist(StaffidController.text);
    bool numberStatus = await checkNumberExist(PhoneNumberController.text);
    if (!idStatus || StaffidController.text == staffOldId){
      if (!numberStatus || PhoneNumberController.text == staffOldPhone) {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            });
        String id = DateTime.now().millisecondsSinceEpoch.toString();
        //this code is genarate auto id;
        Map<String, Object> dataMap = HashMap();
        Map<String, Object> userMap = HashMap();
        dataMap["ADDED_BY"] = addedBy;
        dataMap["NAME"] = NameController.text;
        userMap["NAME"] = NameController.text;
        dataMap["STAFF_ID"] = StaffidController.text;
        dataMap["TIME"] = DateTime.now();
        userMap["STAFF_ID"] = StaffidController.text;
        // dataMap["EMAIL"] = EmailController.text;
        dataMap["MOBILE_NUMBER"] = PhoneNumberController.text;
        dataMap["COUNTRY_CODE"] = selectedValue.toString();
        userMap["MOBILE_NUMBER"] = selectedValue! + PhoneNumberController.text;
        dataMap["AIRPORT"] = staffAirportName.toString();
        dataMap["DESIGNATION"] = designation.toString();
        userMap["DESIGNATION"] = designation.toString();
        userMap["TYPE"] = "STAFF";
        if (from == '') {
          dataMap["ID"] = id.toString();
          userMap["ID"] = id.toString();
        } else {
          dataMap["ID"] = userId;
          userMap["ID"] = userId;
        }
        dataMap["STATUS"] = status;
        userMap["STATUS"] = status;
        if (fileImage != null) {
          String time = DateTime.now().millisecondsSinceEpoch.toString();
          ref = FirebaseStorage.instance.ref().child(time);
          await ref.putFile(fileImage!).whenComplete(() async {
            await ref.getDownloadURL().then((value) {
              dataMap['PROFILE_IMAGE'] = value;
              notifyListeners();
            });
            notifyListeners();
          });
          notifyListeners();
        } else {
          dataMap['PROFILE_IMAGE'] = staffImage;
        }
        if (from == '') {
          db.collection("STAFF").doc(id).set(dataMap);
          db.collection("USERS").doc(id).set(userMap);
        } else {
          db.collection("STAFF").doc(userId).update(dataMap);
          db.collection("USERS").doc(userId).update(userMap);
        }
        notifyListeners();

        finish(context);
        finish(context);
        notifyListeners();
        notifyListeners();
      }
      else {
        final snackBar = SnackBar(
          elevation: 6.0,
          backgroundColor: themecolor,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Text(
            "Phone Number Already Exist...",
            style: TextStyle(color: cWhite),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    }
    else {
      final snackBar = SnackBar(
        elevation: 6.0,
        backgroundColor: themecolor,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Text(
          "Staff ID Already Exist...",
          style: TextStyle(color: cWhite),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void clearStaff() {
    NameController.clear();
    StaffidController.clear();
    PhoneNumberController.clear();
    designation = 'Select Designation';
    staffAirportName = 'Select Airport';
    fileImage = null;
    staffImage = "";
    notifyListeners();
  }

  void deleteData(BuildContext context, String id, String from) {
    if (from == "Staff") {
      db.collection("STAFF").doc(id).set({'STATUS':'DELETED'},SetOptions(merge: true));

      db.collection("USERS").doc(id).delete();

      notifyListeners();
      finish(context);
      finish(context);
    } else {
      db.collection("PASSENGERS").doc(id).update({'STATUS': 'DELETED'});

      db.collection("USERS").doc(id).delete();

      notifyListeners();
      finish(context);
      finish(context);
    }
  }

  String status = '';
  String staffImage = '';
  String passengerImage = '';

  void editStaff(BuildContext context, String id) {
    db.collection("STAFF").doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        staffEditId = map['ID'].toString();
        NameController.text = map['NAME'].toString();
        staffOldId = StaffidController.text = map['STAFF_ID'].toString();
        staffAirportName = map['AIRPORT'].toString();
        designation = map["DESIGNATION"].toString();
        selectedValue = map["COUNTRY_CODE"].toString();
        staffOldPhone = PhoneNumberController.text =
            map["MOBILE_NUMBER"].toString().replaceAll("+91", '');
        status = map['STATUS'].toString();
        staffImage = map["PROFILE_IMAGE"] ?? "";
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddStaff(
                    from: "EDIT",
                    userId: id,
                    status: status,
                    addedBy: '',
                  )));
    });

    notifyListeners();
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.camera_enhance_sharp,
                    color: cl172f55,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () => {imageFromCamera(), Navigator.pop(context)}),
              ListTile(
                  leading: Icon(Icons.photo, color: cl172f55),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () => {imageFromGallery(), Navigator.pop(context)}),
            ],
          );
        });
    // ImageSource
  }

  imageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  imageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileImage = File(response.file!.path);

      notifyListeners();
    }
  }

  Future<void> _cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileImage = File(croppedFile.path);
      imgCheck = true;
      notifyListeners();
    }
  }

  Future<void> addTickets(
      BuildContext context, String addedBy, String id, String from) async {
    bool numberStatus = await checkPnrIdExist(ticketPnrController.text);
    if (!numberStatus || ticketPnrController.text == previousPnrId) {
      HashMap<String, Object> ticketMap = HashMap();
      String ticketId = DateTime.now().millisecondsSinceEpoch.toString();

      ticketMap["PNR_ID"] = ticketPnrController.text;
      ticketMap["FLIGHT_NAME"] = ticketFlightName;
      ticketMap["FROM"] = fromTicket;
      ticketMap["TO"] = toTicket;
      ticketMap["PASSENGERS_NUM"] = passengerCountController.text;
      if (from != 'edit') {
        ticketMap["ID"] = ticketId;
        ticketMap["ADDED_BY"] = addedBy;
      }
      ticketMap["ADDED_TIME"] = DateTime.now();
      ticketMap["ARRIVAL"] = arrivalTime.text;
      ticketMap["ARRIVAL_DATE"] = arrivalDate;
      ticketMap["ARRIVAL_DATE_MILLI"] = arrivalDateMilli;
      ticketMap["DEPARTURE"] = departureTime.text;
      ticketMap["DEPARTURE_DATE"] = departureDate;
      ticketMap["DEPARTURE_DATE_MILLI"] = departureDateMilli;
      ticketMap["PASSENGERS"] = ticketNameList;
      if (from != 'edit') {
        db.collection("TICKETS").doc(ticketId).set(ticketMap);
      } else {
        db.collection("TICKETS").doc(id).update(ticketMap);
      }
      fetchTicketsList();
      finish(context);
    } else {
      final snackBar = SnackBar(
        elevation: 6.0,
        backgroundColor: cWhite,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: const Text(
          "PNR ID Already Exist..",
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    clearTicketControllers();
  }

  void blockStaff(BuildContext context, String id, String from) {
    if (from == "Staff") {
      db.collection("STAFF").doc(id).update({'STATUS': 'BLOCKED'});
      db.collection("USERS").doc(id).update({'STATUS': 'BLOCKED'});
    } else {
      db.collection("PASSENGERS").doc(id).update({'STATUS': 'BLOCKED'});
      db.collection("USERS").doc(id).update({'STATUS': 'BLOCKED'});
    }

    // callNextReplacement(HomeScreen(), context);

    notifyListeners();
    finish(context);
    finish(context);
  }

  void unBlockStaff(BuildContext context, String id, String from) {
    if (from == "Staff") {
      db.collection("STAFF").doc(id).update({'STATUS': 'ACTIVE'});
    } else {
      db.collection("PASSENGERS").doc(id).update({'STATUS': 'ACTIVE'});
    }

    // callNextReplacement(HomeScreen(), context);
    notifyListeners();
    finish(context);
    finish(context);
  }

  logOutAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      backgroundColor: cWhite,
      contentPadding: const EdgeInsets.only(bottom: 8),
      scrollable: true,
      title: Center(
          child: Column(children: [
        Icon(
          Icons.logout,
          size: 30,
          color: themecolor,
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "LogOut",
          style: TextStyle(
              fontFamily: 'PoppinsMedium',
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ),
        const SizedBox(
          height: 15,
        ),
      ])),
      content: SizedBox(
        height: 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      finish(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: themecolor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('NOT NOW',
                          style: TextStyle(color: cWhite, fontSize: 13)),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut();
                      finish(context);
                      CountryCode("Oman", "OM", "+968");
                      callNextReplacement(const LoginScreen(), context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: themecolor),
                          color: cWhite,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('LOGOUT',
                          style: TextStyle(
                              fontSize: 13,
                              color: themecolor,
                              fontFamily: "PoppinsMedium")),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String selectedDateTime = "";
  DateTime arrivalDate = DateTime.now();
  String arrivalDateMilli = '';
  DateTime departureDate = DateTime.now();
  String departureDateMilli = '';

  datePicker(context, String ticketTime) {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(1980, 1, 1),
        maxTime: DateTime(3000, 12, 31), onConfirm: (dateTime) {
      selectedDateTime = DateFormat("dd/MM/yyyy  HH:mm").format(dateTime);
      if (ticketTime == "Arrival") {
        arrivalDate=dateTime;
        arrivalDateMilli=dateTime.millisecondsSinceEpoch.toString();
        arrivalTime.text = selectedDateTime;
      } else {
         departureDate =dateTime;
         departureDateMilli=dateTime.millisecondsSinceEpoch.toString();

        departureTime.text = selectedDateTime;
      }
      notifyListeners();
    }, locale: LocaleType.en);
  }

  void addPassengersName(String passenger, BuildContext context2) {
    ticketPassengersController.clear();
    ticketNameList.add(passenger);
    notifyListeners();
  }

  fetchTicketsList() {
    db.collection("TICKETS").snapshots().listen((value) {
      if (value.docs.isNotEmpty) {
        ticketList.clear();
        filterTicketLIst.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          ticketList.add(TicketModel(
              map["ID"].toString(),
              map["PNR_ID"].toString(),
              map["ARRIVAL"].toString(),
              map["DEPARTURE"].toString(),
              map["FLIGHT_NAME"].toString(),
              map["FROM"].toString(),
              map["TO"].toString()));
        }
        filterTicketLIst = ticketList;
        notifyListeners();
      }
    });
  }

  Future savePdf(String qrData) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4.portrait,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.BarcodeWidget(
                    data: qrData,
                    barcode: pw.Barcode.qrCode(),
                    width: 100,
                    height: 50),
              ]);
        }));
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/Invoice2.pdf");

    notifyListeners();
  }

  void deleteTickets(BuildContext context, String id) {
    db.collection("TICKETS").doc(id).delete();
    fetchTicketsList();
    finish(context);
    notifyListeners();
  }

  String previousPnrId = '';

  void editTickets(BuildContext context, String id) {
    db.collection('TICKETS').doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        ticketFlightName = map['FLIGHT_NAME'].toString();
        ticketPnrController.text = map['PNR_ID'].toString();
        previousPnrId = map['PNR_ID'].toString();
        fromTicket = map['FROM'].toString();
        toTicket = map['TO'].toString();
        passengerCountController.text = map['PASSENGERS_NUM'].toString();
        arrivalTime.text = map['ARRIVAL'].toString();
        departureTime.text = map['DEPARTURE'].toString();
        ticketNameList = map['PASSENGERS'];
        notifyListeners();
        callNext(
            AddTickets(
              from: 'edit',
              userId: id,
              addedBy: '',
            ),
            context);
      }
    });
  }

  Future<void> fetchCountryJson() async {
    countryCodeList.clear();
    var jsonText = await rootBundle.loadString('assets/countryCodes.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map<dynamic, dynamic> map = jsonResponse as Map;
    List<String> list = [];
    map.forEach((key, value) {
      if (!list.contains(value['name'].toString())) {
        list.add(value['name'].toString());
        countryCodeList.add(CountryCode(value['name'].toString(),
            value['code'].toString(), value['dial_code'].toString()));
        notifyListeners();
      }
    });
  }

}
