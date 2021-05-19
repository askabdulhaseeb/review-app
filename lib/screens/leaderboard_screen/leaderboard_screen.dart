import 'package:flutter/material.dart';
import 'package:reviewapp/screens/home/home_screen.dart';
import '../../model/leaderboard.dart';
import '../../utils/color_constants.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Leaderboard> _leaderboardVideosList = [];

  @override
  void initState() {
    getLeaderboardVideos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.blackColor),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false,
            );
          },
        ),
        title: Text(
          'Leaderboard Screen',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                //leaderboard image
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.asset('assets/images/leaderboard.png',
                      fit: BoxFit.fill),
                ),

                SizedBox(
                  height: 40,
                ),

                //leaderboard gridview
                GridView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: _leaderboardVideosList.length,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                              _leaderboardVideosList[index].image),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  _leaderboardVideosList[index].title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.whiteColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.person_outline,
                                          color: ColorConstants.whiteColor,
                                          size: 20),
                                      SizedBox(width: 4),
                                      Text(
                                        _leaderboardVideosList[index].username,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstants.whiteColor),
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Icon(Icons.favorite_border,
                                          color: ColorConstants.whiteColor,
                                          size: 20),
                                      Text(
                                        _leaderboardVideosList[index].likes,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstants.whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: InkWell(
          onTap: () {},
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
                    "Record Review",
                    style: TextStyle(
                        color: ColorConstants.whiteColor, fontSize: 18),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  getLeaderboardVideos() {
    _leaderboardVideosList.add(
      Leaderboard('https://picsum.photos/200/300', 'title of review',
          'new_horizon', '1225'),
    );

    _leaderboardVideosList.add(
      Leaderboard('https://picsum.photos/200/300', 'title of review',
          'new_horizon', '1225'),
    );

    _leaderboardVideosList.add(
      Leaderboard('https://picsum.photos/200/300', 'title of review',
          'new_horizon', '1225'),
    );

    _leaderboardVideosList.add(
      Leaderboard('https://picsum.photos/200/300', 'title of review',
          'new_horizon', '1225'),
    );

    _leaderboardVideosList.add(
      Leaderboard('https://picsum.photos/200/300', 'title of review',
          'new_horizon', '1225'),
    );

    _leaderboardVideosList.add(
      Leaderboard('https://picsum.photos/200/300', 'title of review',
          'new_horizon', '1225'),
    );
  }
}
