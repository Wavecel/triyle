import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:triyleapp/screens/homepage.dart';
import 'package:triyleapp/screens/loginpage.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streemsnapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${streemsnapshot.error}"),
                      ),
                    );
                  }
                  if (streemsnapshot.connectionState ==
                      ConnectionState.active) {
                    User? user = streemsnapshot.data as User?;
                    //not loged in
                    if (user == null) {
                      return LoginPage();
                    } else {
                      //user loged in head to home page
                      return HomePage();
                    }
                  }
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                });
          }
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        });
  }
}
