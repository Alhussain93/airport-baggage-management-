import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';
import '../Providers/admin_provider.dart';
import '../constant/colors.dart';
import 'add_staff.dart';

class StaffScreen extends StatelessWidget {
  String addedBy;

  StaffScreen({Key? key, required this.addedBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      "All Staff",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Poppins-SemiBold'),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 26,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 1.0, // soften the shadow
                              spreadRadius: 1.0, //extend the shadow
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Consumer<AdminProvider>(
                              builder: (context, value, child) {
                            return InkWell(
                              onTap: () {
                                value.clearStaff();
                                callNext(
                                    AddStaff(
                                      from: '',
                                      userId: '',
                                      status: 'ACTIVE',
                                      addedBy: addedBy,
                                    ),
                                    context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Add Staff",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Poppins-SemiBold'),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 14,
                                    color: blck,
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Consumer<AdminProvider>(builder: (context, value, child) {
              return ListView.builder(
                  itemCount: value.filtersStaffList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = value.filtersStaffList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 2),
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
                                padding: const EdgeInsets.only(left: 10),
                                child: item.profileImage != ""
                                    ? CircleAvatar(
                                        backgroundColor: cWhite,
                                        radius: 25,
                                        backgroundImage:
                                            NetworkImage(item.profileImage))
                                    : CircleAvatar(
                                        backgroundColor: cWhite,
                                        radius: 25,
                                        backgroundImage:
                                            const AssetImage("assets/user.png"),
                                      ),
                              ),
                              SizedBox(
                                width: width / 1.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.Name,
                                          style: const TextStyle(
                                              fontFamily: "Poppins-SemiBold",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "ID : ",
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Poppins-SemiBold",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              value.modellist[index].StaffId,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      "Poppins-SemiBold",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "STATUS : ",
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Poppins-SemiBold",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              item.status,
                                              style: TextStyle(
                                                  color:
                                                      item.status == "BLOCKED"
                                                          ? Colors.red
                                                          : Colors.green,
                                                  fontFamily:
                                                      "Poppins-SemiBold",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          value.fileImage = null;
                                          value.editStaff(context, item.id);
                                        },
                                        icon: const Icon(
                                          Icons.edit_calendar_outlined,
                                          size: 25,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
