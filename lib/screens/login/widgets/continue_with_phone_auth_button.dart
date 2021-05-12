import 'package:flutter/material.dart';
import '../../../screens/otp/otp_screen.dart';
import '../../../utils/color_constants.dart';
import '../../../widgets/show_toast_messages.dart';

class ContinueWithPhoneAuthButton extends StatelessWidget {
  final TextEditingController phoneNumber;
  const ContinueWithPhoneAuthButton({
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (phoneNumber.text.isNotEmpty) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OTPScreen(phoneNumber: phoneNumber.text),
            ),
          );
        } else {
          showErrorToast('Enter a phone number');
        }
      },
      child: Container(
        height: 50.0,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.continueButtonColor,
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          child: Center(
            child: Text(
              "Continue",
              style: TextStyle(color: ColorConstants.whiteColor, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
