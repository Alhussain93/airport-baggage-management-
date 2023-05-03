import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/pnr_model_class.dart';

import '../UserView/tracking_screen.dart';
import '../constant/my_functions.dart';

class PnrProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController pnrController = TextEditingController();

  List<PnrModel> checkList = [];
  List luggageList = [];

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
          ));
        }
        callNext(TrackingScreen(pnrid: pnrControllerText), context);
      }
    });
  }



  luggageTracking(String lid,) {
    luggageList.clear();
    print(lid.toString() + "gvhb");
    db.collection("PNRTRAIL").doc(lid).get().then((value) {
      Map<dynamic, dynamic> map = value.data() as Map;
      luggageList.add(map["STATUS"].toString(),);
      print("fgjgkj"+luggageList.toString());
      notifyListeners();
    });

  }
}

// for (var element in value.docs) {
// Map<dynamic, dynamic> map = element.data();
// print(checkList.toString()+"JKL");
// checkList.add(PnrModel(
// map["LUGGEGE_NUMBER".toString()],
// map["NAME"],
// map["PNR_ID"].toString(),
// map["STATUS".toString()],
// ));
// notifyListeners();
//
// }
