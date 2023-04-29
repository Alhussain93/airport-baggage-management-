import 'package:flutter/material.dart';

import '../constant/colors.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    int current_step = 0;

    List<Step> steps = [
      Step(
        title: Text('Step 1'),
        content: Text('Hello!'),
        isActive: true,
      ),
      Step(
        title: Text('Step 2'),
        content: Text('World!'),
        isActive: true,
      ),
      Step(
        title: Text('Step 3'),
        content: Text('Hello World!'),
        state: StepState.complete,
        isActive: true,
      ),
    ];
    List num = ["1", "2", "3", "4", "5"];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: height / 2.6,
              width: width,
              decoration: BoxDecoration(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                      Text(
                        "LOGO",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontWeight: FontWeight.w600,
                            fontSize: 36,
                            color: Textclr),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Mohammed Ramees",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: basewhite),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 31),
                    child: Row(
                      children: [
                        Text(
                          "PNR : ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: basewhite),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "8787876868",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: basewhite),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text(
                          "Luggage :",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: basewhite),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "12",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: basewhite),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text(
                          "Luggages :",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: basewhite),
                        ),
                        SizedBox(
                          height: 19,
                          width: width / 1.8,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: num.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: InkWell(
                                    splashColor: Colors.blue,
                                    onTap: () {

                                    },
                                    child: Container(
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Textclr,
                                      ),
                                      child: Center(child: Text(num[index])),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Departure",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Text(
                  "LHR (London Heathrow)",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                  endIndent: width / 2.2,
                  indent: width / 2.2,
                ),
                Stepper(
                  currentStep: current_step,
                  steps: steps,
                  type: StepperType.vertical,
                  onStepTapped: (step) {
                    setState(() {
                      current_step = step;
                    });
                  },
                  onStepContinue: () {
                    setState(() {
                      if (current_step < steps.length - 1) {
                        current_step = current_step + 1;
                      } else {
                        current_step = 0;
                      }
                    });
                  },
                  onStepCancel: () {
                    setState(() {
                      if (current_step > 0) {
                        current_step = current_step - 1;
                      } else {
                        current_step = 0;
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StepperDemo extends StatefulWidget {
  StepperDemo() : super();

  final String title = "Stepper Demo";

  @override
  StepperDemoState createState() => StepperDemoState();
}

class StepperDemoState extends State<StepperDemo> {
  //
  int current_step = 0;
  List<Step> steps = [
    Step(
      title: Text('Step 1'),
      content: Text('Hello!'),
      isActive: true,
    ),
    Step(
      title: Text('Step 2'),
      content: Text('World!'),
      isActive: true,
    ),
    Step(
      title: Text('Step 3'),
      content: Text('Hello World!'),
      state: StepState.complete,
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        currentStep: this.current_step,
        steps: steps,
        type: StepperType.vertical,
        onStepTapped: (step) {
          setState(() {
            current_step = step;
          });
        },
        onStepContinue: () {
          setState(() {
            if (current_step < steps.length - 1) {
              current_step = current_step + 1;
            } else {
              current_step = 0;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (current_step > 0) {
              current_step = current_step - 1;
            } else {
              current_step = 0;
            }
          });
        },
      ),
    );
  }
}
