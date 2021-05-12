import 'package:flutter/material.dart';

class ValidePhoneNumberTextFormField extends StatefulWidget {
  final TextEditingController _phoneNumber;
  ValidePhoneNumberTextFormField({
    Key key,
    @required TextEditingController phoneNumber,
  })  : _phoneNumber = phoneNumber,
        super(key: key);
  @override
  _ValidePhoneNumberTextFormFieldState createState() =>
      _ValidePhoneNumberTextFormFieldState();
}

class _ValidePhoneNumberTextFormFieldState
    extends State<ValidePhoneNumberTextFormField> {
  onListener() => setState(() {});
  @override
  void initState() {
    widget._phoneNumber.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._phoneNumber.removeListener(onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: widget._phoneNumber,
        keyboardType: TextInputType.phone,
        style: TextStyle(color: Colors.white),
        textInputAction: TextInputAction.next,
        autofillHints: [AutofillHints.telephoneNumberLocal],
        validator: (value) {
          if (value.length < 10) return 'Enter Correct Phone Number';
          return null;
        },
        decoration: InputDecoration(
          hintText: '+1234567890',
          hintStyle: TextStyle(
            color: Colors.white54,
          ),
          labelStyle: TextStyle(color: Colors.white),
          prefix: Container(width: 10),
          suffixIcon: IconButton(
            icon: (widget._phoneNumber.text.isEmpty)
                ? Container(width: 0)
                : Icon(Icons.clear),
            onPressed: () => widget._phoneNumber.clear(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
        ),
      ),
    );
  }
}
