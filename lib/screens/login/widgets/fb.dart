// {
//     name: Rana Abdul Haseeb,
//     first_name: Rana,
//     last_name: Abdul Haseeb,
//     picture: {
//         data: {
//             height: 714,
//             is_silhouette: false,
//             url: https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=1584301495105348&height=800&width=800&ext=1622997689&hash=AeQM6AgvzD5iTieamjY,
//             width: 714
//             }
//         },
//     email: askabdulhaseeb@gmail.com,
//     id: 1584301495105348
// }

// refore:
//  User(
//      displayName: Rana Abdul Haseeb,
//      email: askabdulhaseeb@gmail.com,
//      emailVerified: false,
//      isAnonymous: false,
//       metadata:
//          UserMetadata(
//              creationTime: 2021-05-07 23:15:52.494,
//              lastSignInTime: 2021-05-07 23:21:47.389),
//              phoneNumber: null,
//              photoURL: https://graph.facebook.com/1584301495105348/picture,
//              providerData,
//              [UserInfo(
//                  displayName: Rana Abdul Haseeb,
//                  email: askabdulhaseeb@gmail.com,
//                  phoneNumber: null,
//                  photoURL: https://graph.facebook.com/1584301495105348/picture,
//                  providerId: facebook.com,
//                  uid: 1584301495105348
//              )],
//           refreshToken: ,
//            tenantId: null,
//            uid: YCKkN40g6yf7tqPVxbDVkfnt62P2
// )

//  Future<bool> loginFacebook() async {
//     final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//     final FacebookLogin facebookSignIn = new FacebookLogin();
//     final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

//     switch (result.status) {
//       case FacebookLoginStatus.loggedIn:
//         final FacebookAccessToken accessToken = result.accessToken;
//         final myResult = await facebookSignIn.logIn(['email']);
//         final token = myResult.accessToken.token;

//         final graphResponse = await http.get(Uri.parse(
//             'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture.width(800).height(800),email&access_token=$token'));
//         final profileDecoded = convert.jsonDecode(graphResponse.body);

//         final userInfoMap = {
//           mhFIRSTNAME: profileDecoded['first_name'],
//           mhLASTNAME: profileDecoded['last_name'],
//           mhEMAIL: profileDecoded['email'],
//           mhIMAGEURL: profileDecoded['picture']['data']['url'],
//         };
//         // profile = Profile(
//         //     email: profileDecoded['email'],
//         //     name: profileDecoded['name'],
//         //     id: profileDecoded['id'],
//         //     image: profileDecoded['picture']['data']['url']);
//         // accountType = ACCOUNT.facebook;
//         // final userInfoMap={
//         //   mhUID: profileDecoded['id'],
//         // }
//         print(profileDecoded);
//         return true;
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         print('Login cancelled by the user.');
//         return false;
//         break;
//       case FacebookLoginStatus.error:
//         print('Something went wrong with the login process.\n'
//             'Here\'s the error Facebook gave us: ${result.errorMessage}');
//         return false;
//         break;
//       default:
//         return false;
//     }
//   }

// import 'package:flutter/material.dart';
// import 'package:review_app/model/review_video.dart';
// import 'package:review_app/screens/leaderboard_screen/leaderboard_screen.dart';
// import 'package:review_app/screens/search/search_screen.dart';
// import 'package:review_app/screens/sub_category/sub_category_screen.dart';
// import 'package:review_app/services/user_local_data.dart';
// import 'package:review_app/utils/color_constants.dart';
// import 'package:review_app/utils/styles.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

// class AllCategoriesPage extends StatefulWidget {
//   @override
//   _AllCategoriesPageState createState() => _AllCategoriesPageState();
// }

// class _AllCategoriesPageState extends State<AllCategoriesPage> {
//   List<ReviewVideo> _reviewVideosList = [];

//   @override
//   void initState() {
//     getReviewVideos();
//     super.initState();
//   }

//   final List<Widget> imageSliders = imgList
//       .map((item) => Container(
//             child: Container(
//               margin: EdgeInsets.all(5.0),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   child: Stack(
//                     children: <Widget>[
//                       Image.network(item, fit: BoxFit.fill, width: 1000.0),
//                       Positioned(
//                         bottom: 0.0,
//                         left: 0.0,
//                         right: 0.0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color.fromARGB(200, 0, 0, 0),
//                                 Color.fromARGB(0, 0, 0, 0)
//                               ],
//                               begin: Alignment.bottomCenter,
//                               end: Alignment.topCenter,
//                             ),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 20.0),
//                           child: Text(
//                             'No. ${imgList.indexOf(item)} image',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ))
//       .toList();

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: ColorConstants.whiteColor,
//           title: Text('MYREVUE App',
//               style: TextStyle(color: ColorConstants.blackColor)),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.search, color: ColorConstants.blackColor),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => SearchScreen(),
//                   ),
//                 );
//               },
//             ),
//           ],
//           automaticallyImplyLeading: false,
//           bottom: TabBar(
//             isScrollable: true,
//             tabs: [
//               Tab(
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => LeaderboardScreen(),
//                       ),
//                     );
//                   },
//                   child: Text('Leader Board', style: tabBarTextStyle),
//                 ),
//               ),
//               Tab(child: Text('Train', style: tabBarTextStyle)),
//               Tab(child: Text('Car', style: tabBarTextStyle)),
//               Tab(child: Text('Cycle', style: tabBarTextStyle)),
//               Tab(child: Text('Food', style: tabBarTextStyle)),
//               Tab(child: Text('City', style: tabBarTextStyle)),
//             ],
//           ),
//         ),
//         body: SafeArea(
//           child: Container(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   //image slider
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       autoPlay: true,
//                       aspectRatio: 3,
//                       enlargeCenterPage: true,
//                     ),
//                     items: imageSliders,
//                   ),

//                   //reviews gridview
//                   GridView.builder(
//                     padding: EdgeInsets.all(16),
//                     itemCount: _reviewVideosList.length,
//                     shrinkWrap: true,
//                     primary: false,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                         childAspectRatio: 0.7),
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => SubCategoryScreen(),
//                             ),
//                           );
//                         },
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8.0),
//                               child:
//                                   Image.network(_reviewVideosList[index].image),
//                             ),
//                             Align(
//                               alignment: Alignment.bottomCenter,
//                               child: Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       _reviewVideosList[index].title,
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           color: ColorConstants.whiteColor),
//                                     ),
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 8.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             'view',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color:
//                                                     ColorConstants.whiteColor),
//                                           ),
//                                           Text(
//                                             _reviewVideosList[index].views,
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color:
//                                                     ColorConstants.whiteColor),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   getReviewVideos() {
//     _reviewVideosList.add(
//       ReviewVideo('https://picsum.photos/200/300', 'title of review', '1225'),
//     );

//     _reviewVideosList.add(
//       ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
//     );

//     _reviewVideosList.add(
//       ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
//     );

//     _reviewVideosList.add(
//       ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
//     );

//     _reviewVideosList.add(
//       ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
//     );

//     _reviewVideosList.add(
//       ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
//     );

//     _reviewVideosList.add(
//       ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
//     );
//   }
// }
