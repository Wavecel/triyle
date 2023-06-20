import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triyleapp/contants.dart';
import 'package:triyleapp/screens/forgotpassword.dart';
import 'package:triyleapp/screens/landingpage.dart';
import 'package:triyleapp/screens/regis_page.dart';
import 'package:triyleapp/widgets/custom_button.dart';
import 'package:triyleapp/widgets/inputfeild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _regesteredEmail = "";
  String _registeredPassword = "";
  bool _registerFormloading = false;
  late FocusNode _passwordFocusnode;
  late FocusNode _userFocusnode;

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

  //create a new user
  Future<String?> _Accountlogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _regesteredEmail, password: _registeredPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Invalid Login credentials';
      } else if (e.code == 'wrong-password') {
        return 'Invalid Login credentials';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _subitForm() async {
    setState(() {
      _registerFormloading = true;
    });

    String? _createAccountFeedBack = await _Accountlogin();
    if (_createAccountFeedBack != null) {
      _alertDialogBuilder(_createAccountFeedBack);
      setState(() {
        _registerFormloading = false;
      });
    } else {
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => LandingPage()));
    }
  }

  @override
  void initState() {
    _passwordFocusnode = FocusNode();
    _userFocusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusnode.dispose();
    _userFocusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/triyle.jpeg",
                    height: 300,
                    width: 300,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "Welcome User,\n Verify You Are A TRIYLE User",
                      style: Constants.boltHeading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    children: [
                      CustomInput(
                        hintText: "Email",
                        onSubmitted: (nll) {
                          _passwordFocusnode.requestFocus();
                        },
                        onChanged: (val) {
                          _regesteredEmail = val;
                        },
                        focusNode: _userFocusnode,
                        ispassword: false,
                      ),
                      CustomInput(
                        hintText: "Password",
                        onSubmitted: (nll) {
                          _subitForm();
                        },
                        onChanged: (val) {
                          _registeredPassword = val;
                        },
                        focusNode: _passwordFocusnode,
                        ispassword: true,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            (context),
                            MaterialPageRoute(
                                builder: (_) => ForgotPasswordScreen()),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        text: "Sign In",
                        onPressed: () {
                          _subitForm();
                        },
                        outlinedButton: false,
                        isloading: _registerFormloading,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Not a Triyle user?..."),
                      CustomButton(
                        text: "Create new account",
                        onPressed: () {
                          setState(() {
                            _registerFormloading = true;
                          });
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        outlinedButton: true,
                        isloading: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
