import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:triyleapp/contants.dart';
import 'package:triyleapp/screens/emailverify.dart';
import 'package:triyleapp/screens/loginpage.dart';
import 'package:triyleapp/widgets/custom_button.dart';
import 'package:triyleapp/widgets/inputfeild.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _registerFormloading = false;
  //form input field values;
  String _regesteredEmail="";
  String _registeredPassword1="";
  String _registeredPassword2="";
  //focus node for input fields
  late FocusNode _passwordFocusnode;
  late FocusNode _userFocusnode;
  late FocusNode _conformpasswordFocusnode;


  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("ERROR",
            style: Constants.boltHeading,),
            content: Container(
                child: Text(error),
            ),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text("exit"))
            ],
          );
        });
  }
  //create a new user

  Future<String?> _createAccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _regesteredEmail, password: _registeredPassword2);
      return null;
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    }catch(e){return e.toString();}
  }
  void _subitForm()async{
    bool _verify = false;
    setState(() {
      _registerFormloading = true;
    });
    String? _createAccountFeedBack = await _createAccount();
    if(_createAccountFeedBack != null){
      _alertDialogBuilder(_createAccountFeedBack);
      setState(() {
        _registerFormloading = false;
      });
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Verify(email: _regesteredEmail, pass: _registeredPassword2)));
    }

  }
  @override
  void initState() {
    _passwordFocusnode = FocusNode();
    _conformpasswordFocusnode = FocusNode();
    _userFocusnode = FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _passwordFocusnode.dispose();
    _userFocusnode.dispose();
    _conformpasswordFocusnode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children :[ SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Text(
                    "Create a New Account",
                    style: Constants.boltHeading,
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Email",
                      onSubmitted: (nll){
                        _passwordFocusnode.requestFocus();
                      },
                      onChanged: (val){
                        _regesteredEmail = val;
                      },
                      focusNode: _userFocusnode,
                      ispassword: false,


                    ),
                    CustomInput(
                      hintText: "Password",
                      onSubmitted: (nll){
                        _subitForm();
                      },
                      onChanged: (val){
                        _registeredPassword1 = val;
                      },
                      focusNode: _passwordFocusnode,
                      ispassword: true,

                    ),
                    CustomInput(hintText: "conform Password",
                        onChanged: (val){
                          _registeredPassword2 = val;
                        },
                        onSubmitted: (nll){
                          _subitForm();
                        },
                        focusNode: _conformpasswordFocusnode,
                        ispassword: true),

                    CustomButton(
                        text: "Create a New Account",
                        onPressed: () {
                          if(_registeredPassword2 == _registeredPassword1){
                          _subitForm();
                          }
                          else{
                            _alertDialogBuilder("wrong password!");
                          }
                        },
                        outlinedButton: false,
                    isloading: _registerFormloading,),
                  ],
                ),
                Column(
                  children: [
                    Text("Already a User?..."),
                    CustomButton(
                      text: "Back to LogIn",
                      onPressed: () {
                        Navigator.push((context), MaterialPageRoute(builder: (_)=>LoginPage()));
                      },
                      outlinedButton: true,
                      isloading: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),

    );
  }
}
