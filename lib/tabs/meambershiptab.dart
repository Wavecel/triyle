import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Membership extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: [
              Card(
                child: Center(child: Text("THIS IS A CARD")),
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.orange.shade700,

              ),
              Card(
                child: Center(child: Text("THIS IS A CARD")),
                elevation: 50,
              ),
              Card(
                child: Center(child: Text("THIS IS A CARD")),
                elevation: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
