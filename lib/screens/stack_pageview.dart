import 'package:flutter/material.dart';
import 'package:tabbar/tabbar.dart';


class StackPageView extends StatefulWidget {
  @override
  _StackPageViewState createState() => _StackPageViewState();
}

class _StackPageViewState extends State<StackPageView> {

  PageController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  controller: controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),

                  ],
                ),
              ),
              Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: TabbarHeader(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    indicatorColor: Colors.white.withOpacity(0.1),
                    controller: controller,
                    tabs: [
                      Tab(
                        child: Icon(Icons.table_chart),
                      ),
                      Tab(
                        child: Icon(Icons.table_chart),
                      ),
                      Tab(
                        child: Icon(Icons.table_chart),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),

    );
  }
}
