import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/modules/Authentication/AuthScreen.dart';
import 'package:travel/modules/HomeScreen/home_Screen.dart';
import 'package:travel/modules/HomeScreen/tab_screen.dart';
import 'package:travel/shared/Components.dart';






class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _MySplashScreenState extends State<MySplashScreen>
{
  startTimer()
  {
    Timer(const Duration(seconds: 1), () async
    {
      //if rider is loggedin already
      if(firebaseAuth.currentUser != null)
      {
       // navigateAndFinish(context, TabScreen);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=> const TabScreen()),(route) {
        return false;
        },);
      }
      //if rider is NOT loggedin already
      else
      {

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=> const AuthScreen()),(route) {
          return false;
        },);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/images/logo.png"),
              ),

              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Travel app for easy life",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 24,
                    fontFamily: "Signatra",
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
