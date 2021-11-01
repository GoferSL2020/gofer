import 'package:iadvancedscout/conf/config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'email_login.dart';
import 'email_signup.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:new  AppBar(actions: <Widget>[
          IconButton(
            icon: new Image.asset(Config.icono),onPressed: () {
            //subirNube();
            //var a = singOut();
            //if (a != null) {
            //}
          },
          )
        ],
          backgroundColor:Colors.black,
          title: Text("IAScout - Iniciar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        body:   SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("IAScout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto')),
            ),
            Padding(
                padding: EdgeInsets.all(5),
                child: SignInButton(
                  Buttons.Email,
                  text: "Regístrate con su email",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailSignUp()),
                    );
                  },
                )),
            /*Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {},
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Twitter,
                  text: "Sign up with Twitter",
                  onPressed: () {},
                )),*/
            Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                    child: Text("Iniciar con su Email",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmailLogIn()),
                      );
                    })),
                Align(
                  alignment: Alignment.bottomCenter,
            child: Column(children: [
            Padding(
                padding: EdgeInsets.all(40.0),
                child: GestureDetector(
                    child: Text("Al crear su cuenta, acepta los Término y Condiciones y "
                        "la Política de Privacida de IAScout - InAdvanced.",textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.black)),
                    )),

              /*Center(
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 40.0, right:10),
                        child: GestureDetector(
                            child: Text("Términos y condiciones",
                                style: TextStyle(
                                    fontSize: 10,
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Termino()),
                              );
                            })),
                   Padding(
                       padding:  EdgeInsets.only(bottom: 40.0),
                       child: GestureDetector(
                           child: Text("|",
                               style: TextStyle(
                                   fontSize: 10,
                                   color: Colors.blue)),
                           )),
                    Padding(
                        padding:  EdgeInsets.only(bottom: 40.0, left:10),
                        child: GestureDetector(
                            child: Text("Política de Privacidad",
                                style: TextStyle(
                                    fontSize: 10,
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Politica()),
                              );
                            })),

                ],)
           ),*/
            ],)),
        ]),
    ));
  }
}

