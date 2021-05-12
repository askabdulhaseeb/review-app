import 'package:flutter/material.dart';
import '../../database/users_firebase_methods.dart';
import '../../pages/AllCategories/all_categories_page.dart';
import '../../pages/posted_video_page.dart';
import '../../pages/profile_page.dart';
import '../../screens/add_product/add_product_screen.dart';
import '../../screens/product_search/product_search_screen.dart';
import '../../services/user_local_data.dart';
import '../../utils/color_constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _myPage = PageController(initialPage: 0);

  int selectedPosition = 0;

  final tabs = ['All Category', 'Video', 'Direct Text', 'Profile'];
  updateUserInfo() async {
    print('updated in home page');
    await UsersFirebaseMethods()
        .updateUserLocalData(uid: UserLocalData.getUID());
    print(UserLocalData.getIdOfFavCategoriesList());
  }

  @override
  void initState() {
    updateUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _myPage,
          onPageChanged: (int) {
            print('Page Changes to index $int');
          },
          children: <Widget>[
            AllCategoriesPage(),
            PostedVideoPage(),
            Center(
              child: Container(
                child: Text('Empty Body 2'),
              ),
            ),
            ProfilePage(),
          ],
          physics:
              NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addFABPressed();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomTab(),
    );
  }

  _buildBottomTab() {
    return BottomAppBar(
      color: ColorConstants.whiteColor,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: Icons.dashboard,
            isSelected: selectedPosition == 0,
            onTap: () {
              setState(() {
                selectedPosition = 0;
                _myPage.jumpToPage(0);
              });
            },
          ),
          TabItem(
            text: tabs[1],
            icon: Icons.camera_alt_rounded,
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
                _myPage.jumpToPage(1);
              });
            },
          ),
          // SizedBox(
          //   width: 48,
          // ),
          Spacer(),
          TabItem(
            text: tabs[2],
            icon: Icons.send,
            isSelected: selectedPosition == 2,
            onTap: () {
              setState(() {
                selectedPosition = 2;
                _myPage.jumpToPage(2);
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.person,
            isSelected: selectedPosition == 3,
            onTap: () {
              setState(() {
                selectedPosition = 3;
                _myPage.jumpToPage(3);
              });
            },
          ),
        ],
      ),
    );
  }

  void _addFABPressed() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Column(
            children: [
              _buildBottomSheetListItem(
                context,
                title: Text('Write a review'),
                leading: Icon(Icons.edit),
                callback: () {
                  Navigator.pop(context);
                  //open review screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductSearchScreen(),
                    ),
                  );
                },
              ),
              _buildBottomSheetListItem(
                context,
                title: Text('Add a Product'),
                leading: Icon(Icons.shopping_bag),
                callback: () {
                  Navigator.pop(context);
                  //open add product screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddProductScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetListItem(BuildContext context,
      {Widget title, Widget leading, VoidCallback callback}) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (leading != null) leading,
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: DefaultTextStyle(
                  child: title,
                  style: theme.textTheme.headline6,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  const TabItem({Key key, this.text, this.icon, this.isSelected, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.grey,
            ),
            Text(
              text,
              style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 12),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

class Popover extends StatelessWidget {
  const Popover({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildHandle(context), if (child != null) child],
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}
