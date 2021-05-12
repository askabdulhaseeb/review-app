import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import '../../utils/color_constants.dart';

class TermsOfServiceScreen extends StatefulWidget {
  @override
  _TermsOfServiceScreenState createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  String htmlString;
  bool isLoading = true;

  @override
  void initState() {
    _loadHtmlFromAssets().then((value) => {
          setState(() {
            htmlString = value;
            isLoading = false;
          })
        });

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
          'Terms of Service',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: isLoading
                ? CircularProgressIndicator()
                : Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(parseHtmlString(htmlString)),
                  ),
          ),
        ),
      ),
    );
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }

  Future<String> _loadHtmlFromAssets() async {
    String fileText =
        await rootBundle.loadString('assets/html_pages/terms_of_service.html');

    print(fileText);

    return fileText;

    // _controller.loadUrl( Uri.dataFromString(
    //     fileText,
    //     mimeType: 'text/html',
    //     encoding: Encoding.getByName('utf-8')
    // ).toString());
  }
}
