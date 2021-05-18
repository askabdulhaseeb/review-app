import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../utils/color_constants.dart';
import '../../utils/styles.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isVideo = false;
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;

  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.bgColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined,
                color: ColorConstants.blackColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Product Page', style: appBarTextStyle),
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerSection(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //product title and rating
                      titleAndRating(),
                      SizedBox(
                        height: 8,
                      ),

                      //rating bar and votes
                      ratingbarAndVotes(),
                      SizedBox(
                        height: 40,
                      ),

                      recordReviewButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerSection() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://picsum.photos/seed/picsum/200/300',
          width: double.maxFinite,
          height: 260,
          fit: BoxFit.fill,
          placeholder: (context, url) => CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          width: double.maxFinite,
          height: 220,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    );
  }

  Widget titleAndRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'Name of the Product NewTest Company',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstants.blackColor,
            ),
          ),
        ),
        Text(
          '3.6',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConstants.ratingColor,
          ),
        ),
        Icon(Icons.star, color: ColorConstants.ratingColor),
      ],
    );
  }

  Widget ratingbarAndVotes() {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: 5,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
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

        //likes
        Container(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.redColor),
          ),
          child: Row(
            children: [
              Icon(
                Icons.favorite,
                color: ColorConstants.redColor,
                size: 20,
              ),
              SizedBox(width: 8.0),
              Text(
                '92%',
                style: TextStyle(fontSize: 12, color: ColorConstants.redColor),
              ),
            ],
          ),
        ),

        SizedBox(
          width: 8,
        ),

        //votes
        Container(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.greenColor),
          ),
          child: Center(
              child: Text(
            '143 votes',
            style: TextStyle(fontSize: 12, color: ColorConstants.greenColor),
          )),
        ),
      ],
    );
  }

  Widget recordReviewButton() {
    return InkWell(
      onTap: () {
        /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CameraScreen(),
          ),
        );*/

        /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImagePickerDemo(title: 'Image Picker',),
          ),
        );*/

        isVideo = true;
        _onImageButtonPressed(ImageSource.camera);
      },
      child: Container(
        height: 50.0,
        color: Colors.transparent,
        child: Container(
            decoration: BoxDecoration(
                color: ColorConstants.redColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                )),
            child: Center(
              child: Text(
                "Record Review",
                style:
                    TextStyle(color: ColorConstants.whiteColor, fontSize: 18),
              ),
            )),
      ),
    );
  }

  Future<void> _playVideo(PickedFile file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      VideoPlayerController controller;

      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }

      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      final double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    if (isVideo) {
      final PickedFile file = await _picker.getVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    }
  }

  /*Widget _previewVideo() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }


  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
  */

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      }
    } else {
      _retrieveDataError = response.exception.code;
      print(_retrieveDataError);
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }
}
