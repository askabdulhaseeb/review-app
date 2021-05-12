import 'package:flutter/material.dart';
import '../../screens/products_services/products_services_screen.dart';
import '../../utils/color_constants.dart';

class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
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
          'Search Screen',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                //search text field
                TextField(
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 16),
                    hintText: 'Search the product to review',
                    border: InputBorder.none,
                    prefixIcon:
                        Icon(Icons.search, color: ColorConstants.greenColor),
                  ),
                ),

                //divider
                Divider(
                  color: ColorConstants.dividerColor,
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'You have 1 review saved in your Drafts',
                  style:
                      TextStyle(color: ColorConstants.blackColor, fontSize: 17),
                ),

                SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductReviewScreen(),
                      ),
                    );*/

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductsServicesScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50.0,
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                        decoration: BoxDecoration(
                            color: ColorConstants.greenColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            )),
                        child: Center(
                          child: Text(
                            "Finish Your Review",
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
