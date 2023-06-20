import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:triyleapp/tabs/hometab.dart';
import 'package:triyleapp/tabs/meambershiptab.dart';
import 'package:triyleapp/tabs/regesteredtab.dart';
import 'package:triyleapp/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _tabspagecontroler;
  int _slectedTab = 0;

  @override
  void initState() {
    _tabspagecontroler = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabspagecontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: PageView(
                controller: _tabspagecontroler,
                onPageChanged: (num) {
                  setState(() {
                    _slectedTab = num;
                  });
                },
                children: [
                  HomeTab(),
                  RegisteredEvents(),
                  Membership(),
                ],
              ),
            ),
          ),
          BottomTabs(
            tabclicked: (num) {
              setState(() {
                _tabspagecontroler.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              });
            },
            selectdtab: _slectedTab,
          ),
        ],
      ),
    );
  }
}
