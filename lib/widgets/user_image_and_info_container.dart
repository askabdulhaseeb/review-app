import 'package:flutter/material.dart';
import '../services/user_local_data.dart';
import '../utils/color_constants.dart';
import '../utils/styles.dart';
import 'user_profile_image.dart';

class UserImageAndInfoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.blackColor),
      ),
      child: Row(
        children: [
          UserProfileImage(
            imageUrl: UserLocalData.getImageURL(),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  (UserLocalData.getDisplayName() == '' ||
                          UserLocalData.getDisplayName() == null)
                      ? 'No name found'
                      : UserLocalData.getDisplayName(),
                  overflow: TextOverflow.ellipsis,
                  style: normalTextStyle,
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  (UserLocalData.getEmail() == '' ||
                          UserLocalData.getEmail() == null)
                      ? 'No email found'
                      : UserLocalData.getEmail(),
                  overflow: TextOverflow.ellipsis,
                  style: smallTextStyle,
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            color: ColorConstants.blackColor,
            size: 30,
          ),
        ],
      ),
    );
  }
}
