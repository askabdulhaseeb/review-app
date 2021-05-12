import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:group_radio_button/group_radio_button.dart';
import '../../database/users_firebase_methods.dart';
import '../../model/model_helpers.dart/app_user_model_helper.dart';
import '../../services/user_local_data.dart';
import '../../utils/color_constants.dart';
import '../../utils/styles.dart';
import '../../widgets/InputFormField/my_input_text_form_field.dart';
import '../../widgets/show_toast_messages.dart';
import '../../widgets/user_image_and_info_container.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _countryCodeController = TextEditingController(text: '+');
  final _phoneNoController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _professionController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  List<String> _status = ["male", "female", 'other'];
  String _verticalGroupValue = "male";

  //selected field values
  String dateOfBirthValue = 'Date of Birth';
  String currentDate = 'Date of Birth';
  DateTime selectedDate;
  void _assignValues() async {
    final user =
        await UsersFirebaseMethods().getUserInfo(uid: UserLocalData.getUID());
    setState(() {
      _firstNameController.text = user.data()[mhFIRSTNAME];
      _lastNameController.text = user.data()[mhLASTNAME];
      _emailAddressController.text = user.data()[mhEMAIL];
      _addressController.text = user.data()[mhADDRESS];
      _cityController.text = user.data()[mhCity];
      _professionController.text = user.data()[mhPROFESSION];
      _countryCodeController.text = user.data()[mhCOUNTRYCODE];
      _phoneNoController.text = user.data()[mhPHONE];
      _verticalGroupValue = user.data()[mhGENDER] ?? 'male';
      currentDate = user.data()[mhDOB].toString() ?? 'Date of Birth';
    });
  }

  @override
  void initState() {
    _assignValues();
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
        title: Text('Edit Profile', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  UserImageAndInfoContainer(),
                  MyInputTextFormField(
                    controller: _firstNameController,
                    lableText: 'First Name',
                  ),
                  MyInputTextFormField(
                    controller: _lastNameController,
                    lableText: 'Last Name',
                  ),
                  MyInputTextFormField(
                    controller: _emailAddressController,
                    lableText: 'Email',
                    hintText: 'test@test.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _enterPhoneNumber(),
                  _selectDateOfBirth(),
                  _selectGender(),
                  MyInputTextFormField(
                    controller: _addressController,
                    lableText: 'Address',
                  ),
                  MyInputTextFormField(
                    controller: _cityController,
                    lableText: 'City',
                  ),
                  MyInputTextFormField(
                    controller: _professionController,
                    lableText: 'Profession',
                  ),
                  InkWell(
                    onTap: () {
                      Map<String, dynamic> userInfoMap = {
                        mhFIRSTNAME: _firstNameController.text.trim(),
                        mhLASTNAME: _lastNameController.text.trim(),
                        mhEMAIL: _emailAddressController.text.trim(),
                        mhCOUNTRYCODE: _countryCodeController.text.trim(),
                        mhPHONE: _phoneNoController.text.trim(),
                        mhDOB: (selectedDate != null) ? selectedDate : '',
                        mhADDRESS: _addressController.text.trim(),
                        mhCity: _cityController.text.trim(),
                        mhPROFESSION: _professionController.text.trim(),
                      };
                      UsersFirebaseMethods().updateUser(
                        uid: UserLocalData.getUID(),
                        userInfoMap: userInfoMap,
                      );
                      showSuccessToast('Information updated successfully');
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.greenColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Update Profile",
                            style: TextStyle(
                              color: ColorConstants.whiteColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _enterPhoneNumber() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: _countryCodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: new OutlineInputBorder(),
                labelText: "Code",
                hintText: "+92"),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 4,
          child: TextField(
            controller: _phoneNoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: new OutlineInputBorder(),
                labelText: "Phone Number",
                hintText: "12345677890"),
          ),
        ),
      ],
    );
  }

  Widget _selectDateOfBirth() {
    return InkWell(
      onTap: () async {
        final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
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
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 56,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.greyColor),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                currentDate,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _selectGender() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
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
    );
  }

  getCurrentDate(DateTime now) {
    // var formatter = new DateFormat('dd/MM/yyyy');
    // String formattedDate = formatter.format(now);
    String dd = DateFormat('dd/MM/yyyy').format(now);
    setState(() {
      currentDate = dd;
    });
  }
}
