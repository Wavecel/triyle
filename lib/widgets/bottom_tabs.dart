import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {

  final int selectdtab;
  final Function(int) tabclicked;
  BottomTabs({required this.selectdtab,required this.tabclicked});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {

    _selectedTab = widget.selectdtab;
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4.0,
            blurRadius: 30.0
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(imagepath: "assets/images/tab_home.png",
          onPressed: (){
            widget.tabclicked(0);
          },
          selected: _selectedTab == 0? true:false,),
          BottomTabBtn(imagepath: "assets/images/tab_saved.png",
            onPressed: (){
              widget.tabclicked(1);
            },
            selected: _selectedTab == 1? true:false,),
          Container(

            child: BottomTabBtn(imagepath: "assets/images/membership-card.png",
              onPressed: (){
                widget.tabclicked(2);
              },
              selected: _selectedTab == 2? true:false,),
          ),

          BottomTabBtn(imagepath: "assets/images/tab_logout.png",
            onPressed: (){
              widget.tabclicked(3);
              FirebaseAuth.instance.signOut();
            },
            selected: _selectedTab == 3? true:false,),
        ],
      ),
    );
  }
}
class BottomTabBtn extends StatelessWidget {
  final String imagepath;
  final bool selected;
  final Function onPressed;
  BottomTabBtn({required this.imagepath,required this.selected,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected;
    return GestureDetector(
      onTap: (){onPressed();},
      child: Container(
        padding: EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 24,
        ),
        decoration: BoxDecoration(

          border: Border(
            top: BorderSide(
              color: _selected ? Colors.orange.shade700:Colors.transparent,
              width: 2.0,
            ),
            ),


          ),
        child:Image(
          image: AssetImage(imagepath),
          width: 24,
          height: 24,
          color: _selected ? Colors.orange.shade700:Colors.white,
        ),
      ),
    );
  }
}

