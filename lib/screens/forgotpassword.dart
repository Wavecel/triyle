import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triyleapp/contants.dart';
import 'package:triyleapp/widgets/custom_button.dart';
import 'package:triyleapp/widgets/inputfeild.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "ERROR",
              style: Constants.boltHeading,
            ),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("exit"))
            ],
          );
        });
  }

  void Resetpass(String email) async {
    if (email.length == 0 || !email.contains('@')) {
      _alertDialogBuilder("Enter a valid email");
    } else {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pop(context);
    }
  }

  Widget build(BuildContext context) {
    String email = "";
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/triyle.jpeg'),
              SizedBox(
                height: 10,
              ),
              Text(
                "TRIYLE",
                style: Constants.boltHeading,
              ),
              Text(
                'Check Your Email.\n Once You click on Reset Password',
                textAlign: TextAlign.center,
                style: Constants.regularHeading,
              ),
              CustomInput(
                  hintText: "Enter Email",
                  onChanged: (text) {
                    email = text;
                  },
                  onSubmitted: (vari) {},
                  focusNode: FocusNode(),
                  ispassword: false),
              CustomButton(
                  text: "Rest Password",
                  onPressed: () {
                    Resetpass(email);
                  },
                  outlinedButton: true,
                  isloading: false),
              CustomButton(
                  text: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlinedButton: false,
                  isloading: false),
            ],
          ),
        ),
      ),
    );
  }
}
