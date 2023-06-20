import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triyleapp/contants.dart';
class CustomInput extends StatelessWidget {
final String hintText;
final Function(String) onChanged;
final Function(String) onSubmitted;
final FocusNode focusNode;
final bool ispassword;
CustomInput({required this. hintText,required this.onChanged,required this.onSubmitted,required this.focusNode,required this.ispassword});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(

        color: Colors.grey[350],
            borderRadius: BorderRadius.circular(12.0),
        ),
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 10,
      ),

      child: TextField(
        obscureText: ispassword,
        focusNode: focusNode,
        onChanged: (onChanged),
        onSubmitted: (onSubmitted),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 18.0
          )

        ),
        style: Constants.RegularDarkTExt,

      ),
    );
  }
}
