import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/pnr_model_class.dart';

import '../UserView/tracking_screen.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';

class PnrProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController pnrController = TextEditingController();

  List<PnrModel> checkList = [];
  List<String> luggageList = [];

  // db.collection("USERS").where("PHONE",isEqualTo:phoneNumber ).get().
  checkingPnr(String pnrControllerText, BuildContext context) {
    db
        .collection("PNRTRAIL")
        .where("PNR_ID", isEqualTo: pnrControllerText)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          checkList.add(PnrModel(
              element.id,
              map["LUGGEGE_NUMBER"].toString(),
              map["NAME"].toString(),
              map["PNR_ID"].toString(),
              map["STATUS"].toString()));
        }
        checkList.sort(
          (b, a) => b.lagagenumber.compareTo(a.lagagenumber),
        );
        if (checkList.length != 0) {
          luggageTracking(checkList[0].id);
          callNext(TrackingScreen(pnrid: pnrControllerText), context);
        }
      } else {
        final snackBar = SnackBar(
          elevation: 6.0,
          backgroundColor: cWhite,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: const Text(
            "No Luggage !!!",
            style: TextStyle(color: Colors.red),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  luggageTracking(
    String lid,
  ) {
    luggageList.clear();
    print(lid.toString() + "gvhb");
    db.collection("PNRTRAIL").doc(lid).snapshots().listen((event){
      Map<dynamic, dynamic> map = event.data() as Map;
      luggageList.add(
        map["STATUS"].toString(),
      );
      print("fgjgkj" + luggageList.toString());
      notifyListeners();
    });
  }
}
