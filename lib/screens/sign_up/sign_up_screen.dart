import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';
import '../../utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _countryCodeController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _professionController = TextEditingController();

  List<String> _status = ["male", "female"];
  String _verticalGroupValue = "male";

  //selected field values
  String dateOfBirthValue = 'Date of Birth';
  String currentDate = 'Date of Birth';
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.blackColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Sign Up', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //header
                Container(
                  height: 120,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.blackColor),
                  ),
                  child: Row(
                    children: [
                      //person icon
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstants.blackColor,
                            ),
                            shape: BoxShape.circle),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Icon(
                              Icons.person,
                              color: ColorConstants.blackColor,
                              size: 64,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 16,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Ahmedali', style: normalTextStyle),
                          SizedBox(
                            height: 4,
                          ),
                          Text('@gmail.com', style: smallTextStyle),
                        ],
                      ),

                      Expanded(child: SizedBox()),

                      Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: ColorConstants.blackColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 40,
                ),

                TextField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "First Name",
                      hintText: "First Name"),
                ),

                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "Last Name",
                      hintText: "Last Name"),
                ),

                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: _emailAddressController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "Email",
                      hintText: "Email address"),
                ),

                SizedBox(
                  height: 10,
                ),

                //country code and phone number row
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _countryCodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(),
                            labelText: "Code",
                            hintText: "Code"),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _phoneNoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(),
                            labelText: "Phone Number",
                            hintText: "Phone Number"),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                InkWell(
                  onTap: () async {
                    //open date picker
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );

                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                        getCurrentDate(selectedDate);
                      });
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 56,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.greyColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(currentDate),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RadioGroup<String>.builder(
                        horizontalAlignment: MainAxisAlignment.center,
                        groupValue: _verticalGroupValue,
                        direction: Axis.horizontal,
                        onChanged: (value) => setState(() {
                          _verticalGroupValue = value;
                        }),
                        items: _status,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "Address",
                      hintText: "Address"),
                ),

                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: _cityController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "City",
                      hintText: "City"),
                ),

                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: _professionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "Profession",
                      hintText: "Profession"),
                ),

                SizedBox(
                  height: 40,
                ),

                //update button
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50.0,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                            color: ColorConstants.greenColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            )),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: ColorConstants.whiteColor, fontSize: 18),
                          ),
                        )),
                  ),
                ),

                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCurrentDate(DateTime now) {
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    currentDate = formattedDate;
  }
}
