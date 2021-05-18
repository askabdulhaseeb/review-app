import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewapp/model/category.dart';
import 'package:reviewapp/model/product.dart';
import 'package:reviewapp/screens/product_review/product_overview.dart';
import '../../utils/color_constants.dart';

class ProductReviewScreen extends StatefulWidget {
  final Product _product;
  final Category _category;
  const ProductReviewScreen(
      {@required Product product, @required Category category})
      : _product = product,
        _category = category;
  @override
  _ProductReviewScreenState createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  final _productReviewController = TextEditingController();
  final _aboutProductController = TextEditingController();

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
          'Add Product Review',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductOverview(
                  product: widget._product,
                  category: widget._category.title,
                ),
                TextField(
                  controller: _productReviewController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                          color: ColorConstants.greyColor, fontSize: 15),
                      hintText: "Product Review Title",
                      fillColor: Colors.white70),
                ),

                SizedBox(height: 16),

                //text area
                TextField(
                  controller: _aboutProductController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                          color: ColorConstants.greyColor, fontSize: 15),
                      hintText: 'Tell people what you think about this product',
                      fillColor: Colors.white70),
                ),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tap a Star to Rate',
                      style: TextStyle(
                        color: ColorConstants.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //rating bar
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 24,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                //product rating
                Text(
                  'Product Rating',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 18,
                      color: ColorConstants.greyColor),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    _buildChip('1', Colors.red),
                    _buildChip('2', Colors.orange),
                    _buildChip('3', Colors.blue),
                    _buildChip('4', Colors.lightGreen),
                    _buildChip('5', Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.withOpacity(0.1),
        height: 86,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductReviewScreen(),
              ),
            );
          },
          child: Container(
            height: 50.0,
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstants.greenColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  )),
              child: Center(
                child: Text(
                  'Submit',
                  style:
                      TextStyle(color: ColorConstants.whiteColor, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Chip(
        labelPadding: EdgeInsets.all(0),
        avatar: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        label: Icon(
          Icons.star,
          color: ColorConstants.whiteColor,
          size: 16,
        ),
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      ),
    );
  }
}
