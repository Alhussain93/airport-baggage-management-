import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/Providers/admin_provider.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../constant/colors.dart';

class TrackingScreen extends StatelessWidget {
  final String pnrid;
  final String username;

  TrackingScreen({Key? key, required this.pnrid, required this.username})
      : super(key: key);
  int i = 0;
  String datee = '';

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Consumer<AdminProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Container(
                    height: height / 2.8,
                    width: width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/victor.png",
                            ),
                            fit: BoxFit.fill)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  finish(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/Frame48.png",
                              scale: 3,
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 35,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            username,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: basewhite),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Consumer<AdminProvider>(
                              builder: (context, val, child) {
                            return Container(
                              height: 90,
                              width: width / 1.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: themecolor,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xff1A000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4.0)
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "PNR : ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: basewhite),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        pnrid,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: basewhite),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Luggage :",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: basewhite),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        val.checkList.length.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: basewhite),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Luggages :",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: basewhite),
                                      ),
                                      Consumer<AdminProvider>(
                                          builder: (context, value1, child) {
                                        return SizedBox(
                                          height: 19,
                                          width: width / 1.48,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  value1.checkList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: InkWell(
                                                    splashColor: Colors.blue,
                                                    onTap: () {
                                                      adminProvider
                                                          .luggageTracking(
                                                              value1
                                                                  .checkList[
                                                                      index]
                                                                  .id);
                                                      i = index;
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: index == i
                                                            ? Textclr
                                                            : cWhite,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                              "${index + 1}")),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        );
                                      })
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  Consumer<AdminProvider>(
                    builder: (context, value, child) {
                      return SizedBox(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            var item = value.luggageList[index];
                            return Column(
                              children: [
                                const Text(
                                  "Departure",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  item.checkInPlace,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  endIndent: width / 2.2,
                                  indent: width / 2.2,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    item.missingPlace != "CHECK_IN"
                                        ? CircleAvatar(
                                            radius: 13,
                                            backgroundColor: item.status ==
                                                    'CHECK_OUT'
                                                ? cl00962A
                                                : item.status == 'UNLOADING'
                                                    ? cl00962A
                                                    : item.status == 'LOADING'
                                                        ? cl00962A
                                                        : item.status ==
                                                                'CHECK_IN'
                                                            ? cl00962A
                                                            : cl938492)
                                        : const CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Colors.red,
                                          ),
                                    const Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "CHECK_IN",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 10,
                                          decoration: item.missingPlace !=
                                                  "CHECK_IN"
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius
                                                              .vertical(
                                                          top: Radius.circular(
                                                              20)),
                                                  color: item.status ==
                                                          'CHECK_OUT'
                                                      ? cl00962A
                                                      : item.status ==
                                                              'UNLOADING'
                                                          ? cl00962A
                                                          : item.status ==
                                                                  'LOADING'
                                                              ? cl00962A
                                                              : item.status ==
                                                                      'CHECK_IN'
                                                                  ? cl00962A
                                                                  : cl938492)
                                              : BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                  color: cl938492,
                                                ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 10,
                                          decoration: item.missingPlace !=
                                                  "LOADING"
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius
                                                              .vertical(
                                                          bottom:
                                                              Radius.circular(
                                                                  20)),
                                                  color:
                                                      item.status == 'CHECK_OUT'
                                                          ? cl00962A
                                                          : item.status ==
                                                                  'UNLOADING'
                                                              ? cl00962A
                                                              : item.status ==
                                                                      'LOADING'
                                                                  ? cl00962A
                                                                  : cl938492)
                                              : BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    bottom: Radius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                  color: cl00962A,
                                                ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 17.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.checkInPlace,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text(
                                            item.checkInStaffName,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text(
                                              item.checkInTime != ""
                                                  ? uploadDatee(
                                                      item.checkInTime)
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: cl252525)),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        "LOADING",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    item.missingPlace != "LOADING"
                                        ? CircleAvatar(
                                            radius: 13,
                                            backgroundColor: item.status ==
                                                    'CHECK_OUT'
                                                ? cl00962A
                                                : item.status == 'UNLOADING'
                                                    ? cl00962A
                                                    : item.status == 'LOADING'
                                                        ? cl00962A
                                                        : cl938492)
                                        : const CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Colors.red,
                                          ),
                                    const SizedBox(
                                      width: 75,
                                    ),
                                    const Spacer()
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    SizedBox(
                                      width: width / 2.1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.loadingPlace,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text(
                                            item.loadingStaffName,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text(
                                              item.loadingTime != ""
                                                  ? uploadDatee(
                                                      item.loadingTime)
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: cl252525)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 10,
                                          decoration: item.missingPlace != "LOADING"? BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              color: item.status == 'CHECK_OUT'
                                                  ? cl00962A
                                                  : item.status == 'UNLOADING'
                                                      ? cl00962A
                                                      : item.status == 'LOADING'
                                                          ? cl00962A
                                                          : cl938492):BoxDecoration(
                                            borderRadius:
                                            const BorderRadius
                                                .vertical(
                                              top: Radius.circular(
                                                20,
                                              ),
                                            ),
                                            color: cl938492,
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 10,
                                          decoration: item.missingPlace != "UNLOADING"? BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(20)),
                                              color: item.status == 'CHECK_OUT'
                                                  ? cl00962A
                                                  : item.status == 'UNLOADING'
                                                      ? cl00962A
                                                      : cl938492):BoxDecoration(
                                            borderRadius:
                                            const BorderRadius
                                                .vertical(
                                              bottom: Radius.circular(
                                                20,
                                              ),
                                            ),
                                            color: cl00962A,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width / 2.1,
                                    ),
                                    const Spacer()
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    item.missingPlace != "UNLOADING"
                                        ? CircleAvatar(
                                            radius: 13,
                                            backgroundColor:
                                                item.status == 'CHECK_OUT'
                                                    ? cl00962A
                                                    : item.status == 'UNLOADING'
                                                        ? cl00962A
                                                        : cl938492)
                                        : const CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Colors.red,
                                          ),
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "UNLOADING",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 10,
                                          decoration:item.missingPlace != "UNLOADING"?  BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              color: item.status == 'CHECK_OUT'
                                                  ? cl00962A
                                                  : item.status == 'UNLOADING'
                                                      ? cl00962A
                                                      : cl938492):BoxDecoration(
                                            borderRadius:
                                            const BorderRadius
                                                .vertical(
                                              top: Radius.circular(
                                                20,
                                              ),
                                            ),
                                            color: cl938492,
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 10,
                                          decoration: item.missingPlace != "CHECK_OUT"? BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(20)),
                                              color: item.status == 'CHECK_OUT'
                                                  ? cl00962A
                                                  : cl938492):BoxDecoration(
                                            borderRadius:
                                            const BorderRadius
                                                .vertical(
                                              bottom: Radius.circular(
                                                20,
                                              ),
                                            ),
                                            color: cl00962A,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.unloadingPlace,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text(
                                            item.unloadingStaffName,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text(
                                              item.unloadingTime != ""
                                                  ? uploadDatee(
                                                      item.unloadingTime)
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: cl252525)),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        "CHECK_OUT",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    item.missingPlace != "CHECK_OUT"
                                        ? CircleAvatar(
                                            radius: 13,
                                            backgroundColor:
                                                item.status == 'CHECK_OUT'
                                                    ? cl00962A
                                                    : cl938492)
                                        : const CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Colors.red,
                                          ),
                                    const SizedBox(
                                      width: 96,
                                    ),
                                    const Spacer()
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width / 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.checkoutPlace,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text(
                                            item.checkOutStaffName,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text(
                                              item.checkoutTime != ""
                                                  ? uploadDatee(
                                                      item.checkoutTime)
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: cl252525)),
                                        ],
                                      ),
                                    ),
                                    const Spacer()
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String uploadDatee(String date) {
    var startdate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    datee = DateFormat("dd-MM-yy hh:mm a").format(startdate);
    return datee;
  }
}
