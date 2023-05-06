import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';

import '../Providers/admin_provider.dart';
import '../constant/colors.dart';

class AddTickets extends StatelessWidget {
  AddTickets({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Consumer<AdminProvider>(builder: (context, values, child) {
            return Column(
              children: [
                SizedBox(height: height/10,),
                Consumer<AdminProvider>(builder: (context, value1, child) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: DropdownButtonFormField(
                      hint: const Text(
                        "Flight",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      value: value1.ticketFlightName,
                      iconSize: 30,
                      isExpanded: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        isCollapsed: true,
                        helperText: '',
                        contentPadding: const EdgeInsets.all(11),
                      ),
                      onChanged: (newValue) {
                        value1.ticketFlightName = newValue.toString();
                      },
                      validator: (value) {
                        if (value == 'Select Flight Name') {
                          return 'Flight is required';
                        }
                      },
                      items: value1.flightNameList.map((item1) {
                        return DropdownMenuItem(
                            value: item1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                item1,
                                style: TextStyle(color: fontColor),
                              ),
                            ));
                      }).toList(),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: values.ticketPnrController,
                    decoration: InputDecoration(
                      labelText: 'PNR ID',
                      hintText: 'PNR ID',
                      helperText: '',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter PNR ID";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: values.ticketFromController,
                    decoration: InputDecoration(
                      labelText: 'From',
                      hintText: 'From',
                      helperText: '',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter from";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: values.ticketToController,
                    decoration: InputDecoration(
                      labelText: 'To',
                      hintText: 'To',
                      helperText: '',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter where to";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    controller: values.passengerCountController,
                    decoration: InputDecoration(
                      labelText: 'Number of Passengers',
                      hintText: 'Number of Passengers',
                      helperText: '',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter Number of Passengers";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 5),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Arrival Time',
                      hintText: 'Arrival Time',
                      helperText: '',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    controller: adminProvider.arrivalTime,
                    onTap: () {
                      adminProvider.datePicker(context, "Arrival");
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter Number of Passengers";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'DepartureTime',
                      hintText: 'DepartureTime',
                      helperText: '',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    controller: adminProvider.departureTime,
                    onTap: () {
                      adminProvider.datePicker(context, "Departure");
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter Number of Passengers";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: SizedBox(
                    width: width - 50,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width - 150,
                          child: TextFormField(
                            // autofocus: false,
                            // obscureText: _obscureText,
                            keyboardType: TextInputType.text,
                            controller: values.ticketPassengersController,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: 'Add Passengers Name',
                              helperText: '',

                              // isDense: true, // important line
                              // contentPadding: EdgeInsets.fromLTRB(10, 50, 50, 0),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              if (values.ticketPassengersController.text
                                  .trim()
                                  .isNotEmpty) {
                                values.addPassengersName(
                                    values.ticketPassengersController.text,
                                    context);
                              }
                            },
                            child: Container(
                                width: 90,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  color: Textclr,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                      fontFamily: 'BarlowCondensed',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: values.ticketNameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            //  color: Colors.red,
                            // height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (values.ticketNameList.isNotEmpty &&
                                    index == 0)
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                    ),
                                    child: Text(
                                        ' Passengers List (${values.ticketNameList.length})',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        )),
                                  ))
                                else
                                  const SizedBox(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '  ${index + 1} -   ${values.ticketNameList[index]}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        )),
                                    InkWell(
                                        onTap: () {
                                          values.ticketNameList.removeAt(index);
                                          values.notifyListeners();
                                        },
                                        child: const Icon(Icons.delete))
                                  ],
                                ),
                                const Divider(
                                  color: cGrey,
                                )
                              ],
                            )),
                      );
                    }),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Consumer<AdminProvider>(
                        builder: (context, value1, child) {
                      return InkWell(
                        onTap: () {
                          final FormState? form = _formKey.currentState;

                          if (form!.validate()) {
                            if (values.ticketNameList.isNotEmpty &&
                                values
                                    .ticketPassengersController.text.isEmpty) {
                              adminProvider.addTickets("", "");
                              finish(context);
                              adminProvider.clearTicketControllers();
                            } else {
                              final snackBar = SnackBar(
                                elevation: 6.0,
                                backgroundColor: cWhite,
                                behavior: SnackBarBehavior.floating,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                                content:  Text(
                                  values.ticketNameList.isEmpty
                                  ?"No Passengers Found"
                                  :values.ticketPassengersController.text.isNotEmpty
                                  ?"Please Add Passenger":"",
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            }
                          }
                        },
                        child: Container(
                          height: 48,
                          width: width / 1.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Textclr),
                          child: const Center(
                              child: Text(
                            "Add Ticket",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins-SemiBold'),
                          )),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
