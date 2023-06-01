import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/AdminView/missing_luggage.dart';
import 'package:luggage_tracking_app/AdminView/passengerReport_Screen.dart';

import '../constant/colors.dart';

class MissingHomeScreen extends StatelessWidget {
  const MissingHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          bottomNavigationBar: Container(
        color: grapeColor,
        child: TabBar(
          labelColor: clc00a618,
          indicatorColor: clc00a618,

          unselectedLabelColor: Colors.white,
          tabs: [
            const Tab(
              child: Text("Missing Luggage",style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w600,),),
            ),

            Tab(
              child: const Text("Missing Reported",style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w600,),),
            ),
          ],
        ),
      ),
   body: TabBarView(
       children: [
         MissingLuggageScreen(),
         PassengerReportScreen()

       ],
   ) ,

      ),
    );
  }
}
