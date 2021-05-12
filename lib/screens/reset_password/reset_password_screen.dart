import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';
import '../../utils/styles.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
        title: Text('Reset Password', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),

                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Password"),
                ),

                SizedBox(
                  height: 20,
                ),

                //reset password button
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
                            "Reset Password",
                            style: TextStyle(
                                color: ColorConstants.whiteColor, fontSize: 18),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
