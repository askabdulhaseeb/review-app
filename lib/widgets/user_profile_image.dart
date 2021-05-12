import 'package:flutter/material.dart';
import '../utils/color_constants.dart';

class UserProfileImage extends StatelessWidget {
  final String _imageUrl;
  const UserProfileImage({
    @required String imageUrl,
    Key key,
  })  : _imageUrl = imageUrl,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.blackColor,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: (_imageUrl == '' || _imageUrl == null)
            ? Container(
                margin: const EdgeInsets.all(8),
                child: Icon(
                  Icons.person,
                  color: ColorConstants.blackColor,
                  size: 64,
                ),
              )
            : CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(_imageUrl),
              ),
      ),
    );
  }
}
