import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviewapp/screens/home/home_screen.dart';
import 'package:reviewapp/screens/product_review/product_review_screen.dart';
import 'package:reviewapp/screens/product_search/product_search_screen.dart';
import 'package:reviewapp/widgets/showLoadingDialog.dart';
import '../../database/categories_firebase_methods.dart';
import '../../database/product_firebase_methods.dart';
import '../../model/category.dart';
import '../../model/product.dart';
import '../../model/sub_category.dart';
import '../../widgets/show_toast_messages.dart';
import '../../utils/color_constants.dart';
import '../../utils/styles.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Product _product;
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _descController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String catValue = null, subValue = null, secondSubValue = null;
  List<Category> _allCategories = [];
  List<SubCategory> _allSubCategories = [];
  PickedFile _image;
  File file;
  getCategories() async {
    _allCategories = await CategoriesFirebaseMethods().getCategoriesList();
    setState(() {});
    // catValue = _allCategories[0].id;
    catValue = null;
    subValue = null;
    secondSubValue = null;
  }

  getSubCategories(String id) async {
    _allSubCategories =
        await CategoriesFirebaseMethods().getCategoriesSubCat(id);
    setState(() {});
  }

  @override
  void initState() {
    getCategories();
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
        title: Text(
          'Add a Product',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //category drop down
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(color: Colors.blueGrey)),
                    child: DropdownButton<String>(
                      value: catValue,
                      autofocus: true,
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text("Select Category"),
                      items: _allCategories.map((category) {
                        return new DropdownMenuItem(
                          value: category.id,
                          child: new Text(category.title),
                        );
                      }).toList(),
                      onChanged: (String category) {
                        setState(() {
                          catValue = category;
                          subValue = null;
                          secondSubValue = null;
                        });
                        getSubCategories(category);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  // sub-category drop down
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(color: Colors.blueGrey)),
                    child: DropdownButton<String>(
                      value: subValue,
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text("Select Sub-Category"),
                      items: _allSubCategories.map((category) {
                        return new DropdownMenuItem(
                          value: category.id,
                          child: new Text(category.title),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          subValue = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(color: Colors.blueGrey)),
                    child: DropdownButton<String>(
                      value: secondSubValue,
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text("Select Second Sub-Category"),
                      items: _allSubCategories.map((category) {
                        return new DropdownMenuItem(
                          value: category.id,
                          child: new Text(category.title),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          secondSubValue = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  //product name
                  Container(
                    height: 56,
                    child: TextField(
                      controller: _productNameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        border: new OutlineInputBorder(),
                        hintText: "Product Name",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _productPriceController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                      border: new OutlineInputBorder(),
                      hintText: "Enter the Product Price",
                    ),
                  ),
                  const SizedBox(height: 10),
                  //product name
                  TextField(
                    controller: _descController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 6,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                      border: new OutlineInputBorder(),
                      hintText: "Description about a product",
                    ),
                  ),

                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: _image != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 120,
                                  height: 120,
                                  child: Image.file(
                                    File(_image.path),
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 120,
                                  height: 120,
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                        const SizedBox(height: 4),
                        const Text('Add Product Image'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Do you want to write a review on this product now ?',
                    style: normalTextStyle,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (_productNameController.text.isNotEmpty) {
                              showLoadingDislog(context);
                              await _uploadeProduct();
                              // var fetchedCategory =
                              //     await CategoriesFirebaseMethods()
                              //         .getCategory(_product.category);
                              // Category cat =
                              //     Category.fromDocument(fetchedCategory);
                              // Navigator.of(context).pop();
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //       builder: (context) => ProductReviewScreen(
                              //         product: _product,
                              //         category: cat,
                              //       ),
                              //     ),
                              //     (route) => false);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => ProductSearchScreen(),
                                  ),
                                  (route) => false);
                            } else {
                              showErrorToast('Enter Product Name');
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
                                    )),
                                child: Center(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 18),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (_productNameController.text.isNotEmpty) {
                              showLoadingDislog(context);
                              await _uploadeProduct();
                              Navigator.of(context).pop();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                  (route) => false);
                            } else {
                              showErrorToast('Enter Product Name');
                            }
                          },
                          child: Container(
                            height: 50.0,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red[500],
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32.0),
                                    )),
                                child: Center(
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        color: ColorConstants.redColor,
                                        fontSize: 18),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _uploadeProduct() async {
    String url =
        await ProductFirebaseMethods().storeImageToFirestore(File(_image.path));
    _product = Product(
        id: '',
        title: _productNameController.text,
        imageURL: url,
        price: double.parse(_productPriceController.text),
        category: catValue,
        subCategory: subValue,
        secondSubCategory: secondSubValue,
        description: _descController.text);
    Map<String, dynamic> productInfo = _product.toMap();
    ProductFirebaseMethods().addNewProduct(productInfo: productInfo);
  }

  _imgFromCamera() async {
    PickedFile image;
    image = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      _image = image;
    });
  }
}
