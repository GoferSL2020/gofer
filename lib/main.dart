
import 'dart:convert';
import 'dart:io';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
//token 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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' show get;
import 'package:iafootfeel/auth/signup.dart';
import 'package:iafootfeel/conf/config.dart';

import 'package:iafootfeel/locale/app_localization.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/view/menuFootFeel.dart';
import 'package:iafootfeel/wigdet/splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

//import 'package:flutter_localizations/flutter_localizations.dart';

bool login=false;
//@dart=2.9
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      await Firebase.initializeApp(options:
      const FirebaseOptions(
          apiKey: "AIzaSyDqzeOV70MPD5Mz1OkXc5PdxwvC0EiS6HE",
          authDomain: "iafootfeel.firebaseapp.com",
          projectId: "iafootfeel",
          storageBucket: "iafootfeel.appspot.com",
          messagingSenderId: "651389934981",
          appId: "1:651389934981:web:00aeb4651027c03c10b8ec",
          measurementId: "G-VDW47PKMHN"));
    }else{
      await Firebase.initializeApp();
    }
 // await Firebase.initializeApp();


  login = false;
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      //print("USER NULL:");
      login = true;
    } else {
      login = false;
      BBDDService().getUsuarioIniciar();
      //print("USER NO NULL:");

    }
  });


  runApp(
     MyApp());
}


class MyApp extends StatefulWidget {


  MyAppState createState() => MyAppState();

}


class MyAppState extends State<MyApp> {
  String jugadorAux="";

// This widget is the root of your application.

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    //print("MAIN:");
    FirebaseAuth auth=FirebaseAuth.instance;
    AppLocalizationDelegate _localeOverrideDelegate =
    AppLocalizationDelegate(Locale('es', 'ES'));

    //FirebaseAuth.instance.setPersistence(Persistence.NONE);
    

    return MaterialApp(
     localizationsDelegates: [
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
       _localeOverrideDelegate
       ], supportedLocales: [
       const Locale('es', 'ES'),
       const Locale('en', 'US')
     ],

     title: 'iafootfeel',
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primaryColor:Colors.black,backgroundColor: Config.fondo


      ),

      routes: <String, WidgetBuilder>{
        "SPLASH_SCREEN": (BuildContext context) => SplashScreen(),
        "HOME_SCREEN": (BuildContext context) => login == true ? SignUp():MenuFootFeel(),
      },

    );
  }



  @override
  void initState() {
    inicio();
    jugadorAux="";
    // TODO: implement initState
    super.initState();
    imagenesStorageClubes();
  }

  imagenesStorageClubes() async{
    final _storage = FirebaseStorage.instance;
    await _storage.ref('clubes/').listAll().then((value) {
      value.items.forEach((element) async {
        ImagenStorage img = new ImagenStorage();
        var escudo=element.name.replaceAll(".png", "");
        var imgequipo;
          imgequipo = await get(Uri.parse(
              Config.escudo(escudo)));
          img.imagen = imgequipo;
          img.club =escudo;
        Config.imagenesClubes.add(img);

          });
        });
  }
  imagenesStorageClubes2() async{
      final _storage = FirebaseStorage.instance;
      await _storage.ref('clubes/').listAll().then((value) {
        value.items.forEach((element) async {
          print(element.name);
          var escudo=element.name.replaceAll(".png", "");
          ImagenStorage img=new ImagenStorage();
          print(Config.escudoClubes(escudo));
          var imgequipo= await get(Uri.parse(Config.escudoClubes(escudo)));
          //element.getData().then((value) => img.imagen= value.buffer.asUint8List().toList());
          img.imagen=imgequipo;
          img.club=element.name.replaceAll(".png", "");
          Config.imagenesClubes.add(img);
        });
      });
    }

    void inicio() async{
      setState(() {

      });
    }






  }








