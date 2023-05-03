import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import '../constant/my_functions.dart';
import 'addCustomer_screen.dart';
import 'add_staff.dart';

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: width / 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Customers",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Poppins-SemiBold'),
                    ),

                  ],
                ),
              ),
            ),
            Consumer<AdminProvider>(
              builder: (context,value2,child) {
                return ListView.builder(
                    itemCount:value2.customersList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var item=value2.customersList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 2),
                        child: InkWell(
                          onTap: (){
                            value2. fetchCustomersForEdit(item.id);
                            callNext(AddCustomerScreen(userId: item.id, from: 'EDIT',), context);


                          },
                          child: Container(
                            height: 85,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                      AssetImage("assets/girl.png")),
                                ),
                                SizedBox(
                                  height: 60,
                                  width: width / 1.3,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                                fontFamily: "Poppins-SemiBold",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(item.phone,style: TextStyle( fontFamily: "Poppins-SemiBold",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),)
                                        ],
                                      ),
                                      IconButton(onPressed: (){},icon: Icon(Icons.edit_calendar_outlined,size: 10.5,))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            )
          ],
        ),
      ),
      floatingActionButton:
           Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 22, bottom: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Consumer<AdminProvider>(
                  builder: (context, value3, child) {
                    return FloatingActionButton(
                      tooltip: "df",
                      backgroundColor: themecolor,
                      onPressed: () {
                        value3.clearUserControllers();
callNext(AddCustomerScreen(userId: '', from: '',), context);
                      },
                      child: const Icon(Icons.add),
                    );
                  }),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
