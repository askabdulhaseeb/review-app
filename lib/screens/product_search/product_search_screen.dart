import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reviewapp/database/categories_firebase_methods.dart';
import 'package:reviewapp/database/product_firebase_methods.dart';
import 'package:reviewapp/model/category.dart';
import 'package:reviewapp/model/product.dart';
import 'package:reviewapp/screens/product_review/product_review_screen.dart';
import 'package:reviewapp/utils/assets_images.dart';
import '../../screens/products_services/products_services_screen.dart';
import '../../utils/color_constants.dart';

class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final _searchController = TextEditingController();
  Stream _productStream;

  onListener() async {
    _productStream =
        await ProductFirebaseMethods().getSnapshotOfSearchedProduct(
      _searchController.text ?? '',
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(onListener);
    // onPageLoad();
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
            Divider(color: ColorConstants.dividerColor),
            if (_searchController.text.isNotEmpty)
              Flexible(
                child: StreamBuilder(
                  stream: _productStream,
                  builder: (context, snapshot) {
                    return (!snapshot.hasData)
                        ? Center(
                            child: Text('No Product Found Yet!'),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data.docs[index];
                              return ListTile(
                                onTap: () async {
                                  var fetchedData =
                                      await ProductFirebaseMethods()
                                          .fetchProductInfo(id: ds['id']);
                                  Product _product =
                                      Product.fromDocument(fetchedData);
                                  var fetchedCategory =
                                      await CategoriesFirebaseMethods()
                                          .getCategory(_product.category);
                                  Category cat =
                                      Category.fromDocument(fetchedCategory);

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductReviewScreen(
                                        product: _product,
                                        category: cat,
                                      ),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundImage: (ds['imageURL'] != null ||
                                          ds['imageURL'] != '')
                                      ? NetworkImage(ds['imageURL'])
                                      : AssetImage(iAppLogo),
                                ),
                                title: Text(
                                  ds['title'].toString() ?? 'No name found',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle:
                                    Text(ds['description'].toString() ?? ''),
                                trailing: Text(
                                  ds['price'].toString() ?? '0',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),

            if (_searchController.text.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'You have review saved in your Drafts',
                  style:
                      TextStyle(color: ColorConstants.blackColor, fontSize: 17),
                ),
              ),
            if (_searchController.text.isEmpty)
              InkWell(
                onTap: () {
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
    );
  }
}
