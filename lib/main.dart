//@dart2.0
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triyleapp/screens/landingpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.textMeOneTextTheme(
          Theme.of(context).textTheme,
        ),
        hintColor: Colors.grey
      ),
      home: LandingPage()
    );
  }
}

