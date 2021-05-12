import 'package:flutter/material.dart';
import '../../database/users_firebase_methods.dart';
import '../../model/model_helpers.dart/app_user_model_helper.dart';
import '../../screens/category/category_screen.dart';
import '../../services/user_local_data.dart';
import '../../utils/color_constants.dart';
import '../../utils/styles.dart';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final _otherGenderController = TextEditingController();

  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isOtherSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        leading: IconButton(
          color: ColorConstants.blackColor,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Whats your gender?',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('This helps us find you more relevent content.',
                  style: normalTextStyle),

              SizedBox(
                height: 24,
              ),

              //female
              InkWell(
                onTap: () {
                  setState(() {
                    isFemaleSelected = true;

                    isMaleSelected = false;
                    isOtherSelected = false;
                  });
                },
                child: Container(
                  height: 60.0,
                  child: Container(
                      decoration: BoxDecoration(
                          color: ColorConstants.containerBgColor,
                          border: Border.all(
                              color: isFemaleSelected
                                  ? ColorConstants.genderFieldBorderColor
                                  : ColorConstants.containerBgColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          )),
                      child: Center(
                        child: Text(
                          'Female',
                          style: normalTextStyle,
                        ),
                      )),
                ),
              ),

              SizedBox(
                height: 8,
              ),

              //male
              InkWell(
                onTap: () {
                  setState(() {
                    isMaleSelected = true;

                    isFemaleSelected = false;
                    isOtherSelected = false;
                  });
                },
                child: Container(
                  height: 60.0,
                  child: Container(
                      decoration: BoxDecoration(
                          color: ColorConstants.containerBgColor,
                          border: Border.all(
                              color: isMaleSelected
                                  ? ColorConstants.genderFieldBorderColor
                                  : ColorConstants.containerBgColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          )),
                      child: Center(
                        child: Text(
                          'Male',
                          style: normalTextStyle,
                        ),
                      )),
                ),
              ),

              SizedBox(
                height: 8,
              ),

              //other
              InkWell(
                onTap: () {
                  setState(() {
                    isOtherSelected = true;

                    isMaleSelected = false;
                    isFemaleSelected = false;
                  });
                },
                child: Container(
                  height: 60.0,
                  child: Container(
                      decoration: BoxDecoration(
                          color: ColorConstants.containerBgColor,
                          border: Border.all(
                              color: isOtherSelected
                                  ? ColorConstants.genderFieldBorderColor
                                  : ColorConstants.containerBgColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          )),
                      child: Center(
                        child: Text(
                          'Specify another',
                          style: normalTextStyle,
                        ),
                      )),
                ),
              ),

              SizedBox(
                height: 8,
              ),

              //other gender text field
              Visibility(
                visible: isOtherSelected,
                child: Container(
                  height: 60.0,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: ColorConstants.containerBgColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          )),
                      child: Center(
                        child: TextField(
                          controller: _otherGenderController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Specify another gender',
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //continue button
              isMaleSelected || isFemaleSelected || isOtherSelected
                  ? InkWell(
                      onTap: () {
                        if (isFemaleSelected ||
                            isMaleSelected ||
                            isOtherSelected) {
                          String _gender = isMaleSelected
                              ? "male"
                              : isFemaleSelected
                                  ? "female"
                                  : "other";
                          UsersFirebaseMethods().updateUser(
                              uid: UserLocalData.getUID(),
                              userInfoMap: {mhGENDER: _gender});

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CategoryScreen(),
                            ),
                          );
                        } else {}
                      },
                      child: Container(
                        height: 50.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstants.continueButtonColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32.0),
                                )),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: ColorConstants.whiteColor,
                                    fontSize: 18),
                              ),
                            )),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
