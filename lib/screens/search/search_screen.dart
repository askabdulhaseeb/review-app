import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../model/product.dart';
import '../../utils/color_constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchQueryController = TextEditingController();

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
          icon:
              Icon(Icons.arrow_back_outlined, color: ColorConstants.blackColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: _buildSearchField(),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: ColorConstants.blackColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: productsList.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(productsList[index].imageURL),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating:
                                            productsList[index].rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 0.0),
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
                                      Text(productsList[index]
                                          .rating
                                          .toString()),
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
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: ColorConstants.blackColor),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    );
  }

  getProducts() {
    // productsList.add(Product(
    //     'assets/images/dish1.jpg', 'Food dish', '5.0', '123', '1200', '100%'));
    // productsList.add(Product(
    //     'assets/images/dish2.jpg', 'Food dish', '4.0', '120', '1000', '90%'));
    // productsList.add(Product(
    //     'assets/images/dish3.jpg', 'Food dish', '4.5', '150', '2600', '99%'));
    // productsList.add(Product(
    //     'assets/images/dish1.jpg', 'Food dish', '4.6', '240', '3400', '80%'));
    // productsList.add(Product(
    //     'assets/images/dish2.jpg', 'Food dish', '3.0', '26', '1210', '70%'));
    // productsList.add(Product(
    //     'assets/images/dish3.jpg', 'Food dish', '4.2', '30', '2250', '85%'));
    // productsList.add(Product(
    //     'assets/images/dish1.jpg', 'Food dish', '5.0', '56', '6100', '89%'));
  }
}
