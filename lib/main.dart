
import 'dart:convert';
import 'dart:io';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gls/view/menuGLS.dart';
import 'package:gls/auth/signup.dart';
import 'package:gls/conf/config.dart';

import 'package:gls/service/UserService.dart';

import 'package:gls/wigdet/splash.dart';

bool login=false;
//@dart=2.9
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  login = false;
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      login = true;
    } else {
      login = false;
    }
  });


  runApp(
     MyApp());
}


class MyApp extends StatefulWidget {


  MyAppState createState() => MyAppState();

}


class MyAppState extends State<MyApp> {


// This widget is the root of your application.

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
  //FirebaseAuth.instance.setPersistence(Persistence.NONE);


    return MaterialApp(

     title: 'gls',
      home: login == true ? SignUp():MenuGLS(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primaryColor:Colors.black,backgroundColor: Config.fondo
      ),

    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }




  }








