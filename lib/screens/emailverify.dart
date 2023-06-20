import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  final String email;
  final String pass;

  Verify({required this.email, required this.pass});

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  late Timer timer2;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmail(widget.email, widget.pass);
    });
    timer2 = Timer.periodic(Duration(minutes: 2), (timer2) {
      if (auth.currentUser!.emailVerified) {
      } else {
        auth.currentUser!.delete();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(24),
        child: Center(
          child: Text(
              'An Email has been sent to your account please verify within 2 minutes'),
        ),
      ),
    );
  }

  Future<void> checkEmail(String email, String pass) async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      return Navigator.pop(context);
    }
  }
}
