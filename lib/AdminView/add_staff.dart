import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking_app/constant/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../Providers/admin_provider.dart';
import '../UserView/contryCodeModel.dart';
import '../constant/colors.dart';

class AddStaff extends StatelessWidget {
  String from, userId, status, addedBy;

  AddStaff(
      {Key? key,
      required this.from,
      required this.userId,
      required this.status,
      required this.addedBy})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> airportNameList = [
    'Select Airport',
    "Salalah International Airport",
    "Duqm International Airport",
    "Sohar International Airport",
    'Khasab Airport'
  ];

  List<String> Designation = [
    'Select Designation',
    "CHECK_IN",
    "LOADING",
    "UNLOADING",
    'CHECK_OUT'
  ];

  final _userEditTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AdminProvider mainProvider =
        Provider.of<AdminProvider>(context, listen: false);
    mainProvider.fetchCountryJson();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        title: const Text(
          "Add Staff",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 40,
              ),
              Consumer<AdminProvider>(builder: (context, value, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          value.showBottomSheet(context);
                        },
                        child: value.fileImage != null
                            ? CircleAvatar(
                                backgroundColor: cWhite,
                                radius: 50,
                                backgroundImage: FileImage(value.fileImage!),
                              )
                            : value.staffImage != ""
                                ? CircleAvatar(
                                    backgroundColor: cWhite,
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(value.staffImage),
                                  )
                                : CircleAvatar(
                                    backgroundColor: cWhite,
                                    radius: 50,
                                    backgroundImage:
                                        const AssetImage("assets/user.png"),
                                  )),
                    from == 'EDIT'
                        ? Padding(
                            padding: const EdgeInsets.only(right: 30, top: 20),
                            child: Consumer<AdminProvider>(
                                builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  StreamBuilder<Object>(
                                      stream: null,
                                      builder: (context, snapshot) {
                                        return InkWell(
                                          onTap: () {
                                            deleteStaff(
                                                context, value.staffEditId);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: cnttColor),
                                            child: const Center(
                                                child: Text("Remove")),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Consumer<AdminProvider>(
                                      builder: (context, value1, child) {
                                    return InkWell(
                                      onTap: () {
                                        blockStaff(context, userId, status);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: cnttColor),
                                        child: Center(
                                            child: status == 'ACTIVE'
                                                ? const Text("Block")
                                                : const Text("Unblock")),
                                      ),
                                    );
                                  }),
                                ],
                              );
                            }),
                          )
                        : const SizedBox(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        controller: value.NameController,
                        decoration: InputDecoration(
                          helperText: '',
                          hintText: 'Name',
                          contentPadding: const EdgeInsets.all(11),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          controller: value.StaffidController,
                          decoration: InputDecoration(
                            helperText: "",
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(11),
                            hintText: 'Staff ID',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Enter Staff ID";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,

                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: SizedBox(
                              width: 120,
                              child: Consumer<AdminProvider>(
                                  builder: (context, value, child) {
                                return DropdownSearch<CountryCode>(
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.transparent,
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none)),
                                  selectedItem: from !="EDIT"
                                    ? CountryCode("Oman", "OM", "+968"):CountryCode(value.country, value.code, value.selectedValue!),
                                  onChanged: (e) {
                                    value1.selectedValue =
                                        e?.dialCde.toString();
                                    value1.code = e!.code.toString();
                                    value.country = e!.country.toString();
                                    value1.countrySlct = true;
                                  },
                                  items: value.countryCodeList,
                                  filterFn: (item, filter) {
                                    return item.country.contains(filter) || item.country.toLowerCase().contains(filter) || item.country.toUpperCase().contains(filter)||item.dialCde.toUpperCase().contains(filter)||item.code.toUpperCase().contains(filter);
                                  },
                                  itemAsString: (CountryCode u) {
                                    return u.dialCde;
                                  },
                                  popupProps: PopupProps.menu(
                                      searchFieldProps: TextFieldProps(
                                        controller: _userEditTextController,
                                        decoration: const InputDecoration(
                                            label: Text(
                                          'Search Country',
                                          style: TextStyle(fontSize: 12),
                                        )),
                                      ),
                                      showSearchBox: true,
                                      // showSelectedItems: true,
                                      fit: FlexFit.tight,
                                      itemBuilder: (ctx, item, isSelected) {
                                        return ListTile(
                                          selected: isSelected,
                                          title: Text(
                                            item.country,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          subtitle: Text(
                                            item.dialCde,
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        );
                                      }),
                                );
                              }),
                            ),
                            contentPadding: const EdgeInsets.only(right: 80),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.black38,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.black38,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                )),
                            disabledBorder: InputBorder.none,
                            hintText: "Phone Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                )),
                          ),
                          cursorColor: Colors.black,
                          controller: value1.PhoneNumberController,
                          style: const TextStyle(
                            fontFamily: 'BarlowCondensed',
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please Enter The Mobile Number";
                            } else {
                              return null;
                            }
                          },
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: DropdownButtonFormField(
                          hint: const Text(
                            "",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          value: value.staffAirportName,
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
                                borderSide:
                                    const BorderSide(color: Colors.red)),
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
                            value1.staffAirportName = newValue.toString();
                          },
                          items: airportNameList.map((item1) {
                            return DropdownMenuItem(
                                value: item1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(item1),
                                ));
                          }).toList(),
                          validator: (dropValue) {
                            if (dropValue == "Select Airport") {
                              return "Select Airport";
                            }
                            return null;
                          },
                        ),
                      );
                    }),
                    Consumer<AdminProvider>(builder: (context, value1, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: SizedBox(
                          child: DropdownButtonFormField(
                            hint: const Text(
                              "",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: value.designation,
                            iconSize: 30,
                            isExpanded: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
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
                              value1.designation = newValue.toString();
                            },
                            items: Designation.map((item1) {
                              return DropdownMenuItem(
                                  value: item1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(item1),
                                  ));
                            }).toList(),
                            validator: (dropValue) {
                              if (dropValue == "Select Designation") {
                                return "Select Designation";
                              }
                              return null;
                            },
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {
                            final FormState? forme = _formKey.currentState;
                            if (forme!.validate()) {
                              value.addStaff(
                                  context, from, userId, status, addedBy);
                            }
                          },
                          child: Container(
                            height: 48,
                            width: width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: themecolor),
                            child: Center(
                                child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: cWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-SemiBold'),
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  deleteStaff(BuildContext context, String id) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    AlertDialog alert = AlertDialog(
      backgroundColor: themecolor,
      scrollable: true,
      title: const Text(
        "Do you want to delete this staff",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
      content: SizedBox(
        height: 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 37,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextButton(
                        child: const Text(
                          'NO',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          finish(context);
                        }),
                  ),
                  Consumer<AdminProvider>(builder: (context, value, child) {
                    return Container(
                      height: 37,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Textclr),
                      child: TextButton(
                          child: const Text('YES',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            adminProvider.deleteData(context, id, "Staff");
                          }),
                    );
                  }),
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

  blockStaff(BuildContext context, String id, String userStatus) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    AlertDialog alert = AlertDialog(
      backgroundColor: themecolor,
      scrollable: true,
      title: userStatus == 'ACTIVE'
          ? const Text(
              "Do you want to block this staff",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            )
          : const Text(
              "Do you want to unblock this staff",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
      content: SizedBox(
        height: 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 37,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextButton(
                        child: const Text(
                          'NO',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          finish(context);
                        }),
                  ),
                  Consumer<AdminProvider>(builder: (context, value, child) {
                    return Container(
                      height: 37,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Textclr),
                      child: TextButton(
                          child: const Text('YES',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            if (userStatus == 'ACTIVE') {
                              adminProvider.blockStaff(context, id, "Staff");
                            } else {
                              adminProvider.unBlockStaff(context, id, "Staff");
                            }
                          }),
                    );
                  }),
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
}
