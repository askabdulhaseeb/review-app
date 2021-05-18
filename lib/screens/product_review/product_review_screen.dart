import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviewapp/database/reviews_firebase_methods.dart';
import 'package:reviewapp/model/category.dart';
import 'package:reviewapp/model/product.dart';
import 'package:reviewapp/model/review.dart';
import 'package:reviewapp/screens/home/home_screen.dart';
import 'package:reviewapp/screens/product_review/product_overview.dart';
import 'package:reviewapp/services/user_local_data.dart';
import 'package:reviewapp/widgets/show_toast_messages.dart';
import 'package:path/path.dart';
import '../../widgets/showLoadingDialog.dart';
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
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  double rating;
  PickedFile _video;
  File file;

  _titleListener() => setState(() {});
  _aboutListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _productReviewController.addListener(_titleListener);
    _aboutProductController.addListener(_aboutListener);
  }

  bool _isformFilled() {
    setState(() {});
    if (_aboutProductController.text.length > 3 &&
        _productReviewController.text.length > 3 &&
        (rating != null && rating > 0)) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Scaffold(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductOverview(
                      product: widget._product,
                      category: widget._category.title,
                    ),
                    TextFormField(
                      controller: _productReviewController,
                      validator: (value) {
                        return (value.length == 0)
                            ? 'Enter review title'
                            : (value.length < 4)
                                ? 'Enter more then 3 words'
                                : null;
                      },
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
                    TextFormField(
                      controller: _aboutProductController,
                      maxLines: 4,
                      validator: (value) {
                        return (value.length == 0)
                            ? 'Enter review about'
                            : (value.length < 4)
                                ? 'Enter more then 3 words'
                                : null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                              color: ColorConstants.greyColor, fontSize: 15),
                          hintText:
                              'Tell people what you think about this product',
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
                          onRatingUpdate: (newRating) {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            setState(() {
                              rating = newRating;
                            });
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
                    if (_isformFilled())
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Attach video here',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                icon: (_video == null)
                                    ? Icon(Icons.movie_creation_outlined)
                                    : Icon(Icons.movie),
                                onPressed: () => _showPicker(context),
                              ),
                            ],
                          ),
                          Text(basename(_video?.path ?? '')),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.grey.withOpacity(0.1),
          height: 86,
          child: InkWell(
            onTap: () async {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ProductReviewScreen(),
              //   ),
              // );
              if (_isformFilled()) {
                showLoadingDislog(context);
                await _uploadeReview();
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              } else {
                showErrorToast('Select all the fields first');
              }
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
                    style: TextStyle(
                        color: ColorConstants.whiteColor, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _uploadeReview() async {
    String url = await ReviewsFirebaseMethods().storeVideoToFirestore(
      File(_video.path),
    );
    Review review = Review(
      uid: UserLocalData.getUID(),
      productId: widget._product.id,
      categoryId: widget._category.id,
      title: _productReviewController.text,
      about: _aboutProductController.text,
      rating: rating,
      views: 0,
      videoURL: url,
    );
    await ReviewsFirebaseMethods().addNewReview(review.toMap());
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.video_call_sharp),
                      title: new Text('Video Library'),
                      onTap: () {
                        _videoFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _videoFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _videoFromCamera() async {
    // PickedFile video;
    final getMedia = ImagePicker().getVideo;
    final media = await getMedia(source: ImageSource.camera);
    setState(() {
      _video = media;
    });
  }

  _videoFromGallery() async {
    final getMedia = ImagePicker().getVideo;
    final media = await getMedia(source: ImageSource.gallery);
    setState(() {
      _video = media;
    });
  }
}
