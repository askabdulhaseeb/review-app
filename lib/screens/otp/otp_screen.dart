import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../database/auth_methods.dart';
import '../../database/users_firebase_methods.dart';
import '../../screens/category/category_screen.dart';
import '../../screens/gender/gender_screen.dart';
import '../../utils/assets_images.dart';
import '../../utils/color_constants.dart';
import '../../widgets/show_toast_messages.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({@required this.phoneNumber});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _verificationCode;
  String otpCode;
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => Home()),
            //     (route) => false);
            print('FFFFFFFFFFFF');
            print(value.user);
            print('FFFFFFFFFFFF');
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        showErrorToast('Verification failed');
      },
      codeSent: (String verficationID, int resendToken) {
        setState(() {
          _verificationCode = verficationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
      // timeout: Duration(seconds: 120)
    );
  }

  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'OTP',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Image.asset(
                  iAppLogo,
                  width: 120,
                  height: 120,
                ),

                SizedBox(height: 10),

                Text(
                  'MYREVUE',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),
                Text(
                  'An OTP code is sended to your\nPhone Number',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontFamily: 'Quicksand',
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.phoneNumber}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontFamily: 'Quicksand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onChanged: (pin) {},
                  onCompleted: (pin) async {
                    print("Completed: " + pin);
                    setState(() {
                      otpCode = pin;
                    });
                    User _user = await AuthMethods()
                        .signinWithPhoneNumber(_verificationCode, pin);
                    print('login OTP case: step User on OTP');
                    if (_user != null) {
                      print('login OTP case: user not null');
                      var gender = await UsersFirebaseMethods()
                          .getUserGender(uid: _user.uid);
                      if (gender == '' || gender == null) {
                        print('login OTP case: user is new');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => GenderScreen()),
                        );
                      } else {
                        print('login OTP case: user is old');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CategoryScreen()),
                        );
                      }
                    } else {
                      showErrorToast('Something goes wrong');
                    }
                  },
                ),
                // OTPTextField(
                //   length: 5,
                //   width: MediaQuery.of(context).size.width / 2,
                //   fieldWidth: 80,
                //   style: TextStyle(fontSize: 17),
                //   textFieldAlignment: MainAxisAlignment.spaceAround,
                //   fieldStyle: FieldStyle.underline,
                //   onChanged: (value) {
                //     print('chnage: $value');
                //   },
                //   onCompleted: (pin) {
                //     print("Completed: " + pin);
                //   },
                // ),
                // SizedBox(
                //   height: 40,
                // ),

                //continue button
                // InkWell(
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => GenderScreen(),
                //       ),
                //     );
                //   },
                //   child: Container(
                //     height: 50.0,
                //     color: Colors.transparent,
                //     child: Container(
                //         decoration: BoxDecoration(
                //             color: ColorConstants.continueButtonColor,
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(32.0),
                //             )),
                //         child: Center(
                //           child: Text(
                //             "Continue",
                //             style: TextStyle(
                //                 color: ColorConstants.whiteColor, fontSize: 18),
                //           ),
                //         )),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
