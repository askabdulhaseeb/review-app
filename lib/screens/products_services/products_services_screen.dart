import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../model/product.dart';
import '../../screens/product_detail/product_details_screen.dart';
import '../../utils/color_constants.dart';

class ProductsServicesScreen extends StatefulWidget {
  @override
  _ProductsServicesScreenState createState() => _ProductsServicesScreenState();
}

class _ProductsServicesScreenState extends State<ProductsServicesScreen> {
  List<Product> productsList = [];

  @override
  void initState() {
    getProducts();

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
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: ColorConstants.blackColor),
            onPressed: () {},
          ),
        ],
        title: Text(
          'Products / Services',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: productsList.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(productsList[index].image),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productsList[index].title,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.blackColor),
                            ),

                            SizedBox(
                              height: 4,
                            ),

                            //rating and likes percentage row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: productsList[index].rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(productsList[index].rating.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.favorite, color: Colors.red),
                                    SizedBox(width: 4),
                                    Text(
                                      productsList[index].like.toString(),
                                      style: TextStyle(
                                          color: ColorConstants.greyColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 4,
                            ),

                            Row(
                              children: [
                                Text(
                                  productsList[index].votes.toString(),
                                  style: TextStyle(
                                      color: ColorConstants.greyColor),
                                ),
                                Text(
                                  ' Votes',
                                  style: TextStyle(
                                      color: ColorConstants.greyColor),
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  'RS. ',
                                  style: TextStyle(
                                      color: ColorConstants.greyColor),
                                ),
                                Text(
                                  productsList[index].price.toString(),
                                  style: TextStyle(
                                      color: ColorConstants.greyColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getProducts() {
    //   productsList.add(Product(
    //       'assets/images/dish1.jpg', 'Food dish', '5.0', '123', '1200', '100%'));
    //   productsList.add(Product(
    //       'assets/images/dish2.jpg', 'Food dish', '4.0', '120', '1000', '90%'));
    //   productsList.add(Product(
    //       'assets/images/dish3.jpg', 'Food dish', '4.5', '150', '2600', '99%'));
    //   productsList.add(Product(
    //       'assets/images/dish1.jpg', 'Food dish', '4.6', '240', '3400', '80%'));
    //   productsList.add(Product(
    //       'assets/images/dish2.jpg', 'Food dish', '3.0', '26', '1210', '70%'));
    //   productsList.add(Product(
    //       'assets/images/dish3.jpg', 'Food dish', '4.2', '30', '2250', '85%'));
    //   productsList.add(Product(
    //       'assets/images/dish1.jpg', 'Food dish', '5.0', '56', '6100', '89%'));
  }
}
