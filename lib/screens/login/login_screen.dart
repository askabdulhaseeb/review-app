import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/app_terms_line.dart';
import 'widgets/continue_with_phone_auth_button.dart';
import 'widgets/login_with_facebook.dart';
import 'widgets/login_with_google.dart';
import '../../screens/login/widgets/phone_number_input_field.dart';
import '../../utils/assets_images.dart';
import '../../utils/color_constants.dart';
import '../../screens/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fireStoreInstance = FirebaseFirestore.instance;

  final TextEditingController _mobileNoController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    Get.put(LoginController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Builder(
            builder: (cxt) => Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: ColorConstants.blackColor,
                    image: DecorationImage(
                      image: AssetImage(iLoginBG),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                      ),
                      Image.asset(
                        iAppLogo,
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Welcome To MYREVUE',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 26,
                            color: ColorConstants.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ValidePhoneNumberTextFormField(
                        phoneNumber: _mobileNoController,
                      ),
                      SizedBox(height: 10),
                      ContinueWithPhoneAuthButton(
                        phoneNumber: _mobileNoController,
                      ),
                      const SizedBox(height: 24),
                      LoginWithFacebook(),
                      const SizedBox(height: 10),
                      LoginWithGoogle(),
                      const SizedBox(height: 16),
                      AppTermsLineOfLoginScreen(),
                    ],
                  ),
                ),
                Visibility(
                  visible: isLoading,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Function(String) validateModileNo = (String mobileNo) {
    if (mobileNo.isEmpty) {
      return 'Mobile Number empty';
    } else if (mobileNo.length < 3) {
      return 'Mobile Number short';
    }

    return null;
  };

  // void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
  //   await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
  // }

  // void verificationFailed(FirebaseAuthException error) {
  //   if (error.code == 'invalid-phone-number') {
  //     print('The provided phone number is not valid.');
  //   }
  // }

  // void codeSent(String verificationId, int forceResendingToken) async {
  //   String smsCode = 'xxxx';
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId, smsCode: smsCode);
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // void codeAutoRetrievalTimeout(String verificationId) {}
}

// class PhoneNumberInputField extends StatelessWidget {
//   const PhoneNumberInputField({
//     Key key,
//     @required TextEditingController mobileNoController,
//     @required this.validateModileNo,
//   })  : _mobileNoController = mobileNoController,
//         super(key: key);

//   final TextEditingController _mobileNoController;
//   final Function(String p1) validateModileNo;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50.0,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//             color: ColorConstants.containerBgColor,
//             borderRadius: BorderRadius.all(
//               Radius.circular(24.0),
//             )),
//         child: Center(
//           child: TextFormField(
//             controller: _mobileNoController,
//             keyboardType: TextInputType.number,
//             validator: validateModileNo,
//             decoration: InputDecoration(
//               hintText: 'Please enter mobile no',
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
