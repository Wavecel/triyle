import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triyleapp/contants.dart';
class CustomButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final bool outlinedButton;
  final bool isloading;
  CustomButton({required this.text,required this.onPressed,required this.outlinedButton, required this.isloading});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    bool _outline = widget.outlinedButton;
    return GestureDetector(
      onTap: (){widget.onPressed();},
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: _outline ? Colors.transparent: Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
              borderRadius: BorderRadius.circular(12.0),
        ),

        margin: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: widget.isloading ? false:true,
              child: Center(
                child: Text(
                  widget.text,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: _outline ? Colors.black: Colors.white,
                ),
                ),
              ),
            ),
            Visibility(
              visible: widget.isloading ? true:false,
              child: Center(
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(color: widget.isloading?CupertinoColors.white:Colors.black,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
