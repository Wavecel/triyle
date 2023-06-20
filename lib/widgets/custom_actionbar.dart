import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomActionBar extends StatelessWidget {

  final String title;
  final bool hasbackarrow;
  final bool hastitle;
  final bool hasregsiterno;
  CustomActionBar({required this.title,required this.hasbackarrow,required this.hastitle,required this.hasregsiterno});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24)
      ),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange.shade700,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            )
          ),
          padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(hasbackarrow)
                GestureDetector(
                  onTap: (){Navigator.pop(context);},
                  child: Container(
                    width: 42.0,
                    height: 42.0,

                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(
                        'assets/images/back_arrow.png'
                      ),
                      color: Colors.white,
                      width: 16,
                      height: 16,
                    ),

                  ),
                ),
              if(hastitle)
              Container(

                child: Text(title,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,

                ),),
              ),
              if(hasregsiterno)
                Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0)),
                  alignment: Alignment.center,
                  child: Text(
                    "0",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),
                ),
              if(!hasregsiterno)
                SizedBox(width: 1,),

            ],
          ),
        ),
      ),
    );
  }
}
