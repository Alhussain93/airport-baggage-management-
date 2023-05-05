import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/pnr_provider.dart';
import '../constant/colors.dart';

class TrackingScreen extends StatelessWidget {
  final String pnrid;

  TrackingScreen({Key? key, required this.pnrid}) : super(key: key);
  int i = 0;

  @override
  Widget build(BuildContext context) {
    PnrProvider pnrProvider = Provider.of<PnrProvider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Consumer<PnrProvider>(
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
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                )),
                            const Spacer(),
                            Text(
                              "LOGO",
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36,
                                  color: Textclr),
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
                            'hai',
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
                          child: Consumer<PnrProvider>(
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
                                      Consumer<PnrProvider>(
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
                                                      pnrProvider
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
                  Consumer<PnrProvider>(
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
                                const Text(
                                  "dfdgfwerfdg",
                                  style: TextStyle(
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
                                    CircleAvatar(
                                        radius: 13,
                                        backgroundColor: value.luggageList
                                                .contains('Loading')
                                            ? cl00962A
                                            : value.luggageList
                                                    .contains('Screening')
                                                ? cl00962A
                                                : value.luggageList.contains(
                                                        'Security_customer')
                                                    ? cl00962A
                                                    : cl938492),
                                    const Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Security Checking",
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
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              color: value.luggageList
                                                      .contains('Loading')
                                                  ? cl00962A
                                                  : value.luggageList
                                                          .contains('Screening')
                                                      ? cl00962A
                                                      : value.luggageList.contains(
                                                              'Security_customer')
                                                          ? cl00962A
                                                          : cl938492),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(20)),
                                              color: value.luggageList
                                                      .contains('Loading')
                                                  ? cl00962A
                                                  : value.luggageList
                                                          .contains('Screening')
                                                      ? cl00962A
                                                      : cl938492),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Badhusha",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text("16/08/2023",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: cl252525)),
                                          Text("15:45",
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
                                        "Screening",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    CircleAvatar(
                                        radius: 13,
                                        backgroundColor: value.luggageList
                                                .contains('Loading')
                                            ? cl00962A
                                            : value.luggageList
                                                    .contains('Screening')
                                                ? cl00962A
                                                : cl938492),
                                    const SizedBox(
                                      width: 80,
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Najeeb",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: cl252525),
                                          ),
                                          Text("16/08/2023",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: cl252525)),
                                          Text("15:45",
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
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              color: value.luggageList
                                                      .contains('Loading')
                                                  ? cl00962A
                                                  : value.luggageList
                                                          .contains('Screening')
                                                      ? cl00962A
                                                      : cl938492),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(20)),
                                              color: value.luggageList
                                                      .contains('Loading')
                                                  ? cl00962A
                                                  : cl938492),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 87,
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
                                    CircleAvatar(
                                        radius: 13,
                                        backgroundColor: value.luggageList
                                                .contains('Loading')
                                            ? cl00962A
                                            : cl938492),
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Loading",
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
                                // Container(
                                //   height: 100,
                                //   width: 10,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(20),
                                //       color: cl938492),
                                // ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // CircleAvatar(
                                //     radius: 13, backgroundColor: cl938492),
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
}
