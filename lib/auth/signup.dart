import 'package:iadvancedscout/conf/config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'email_login.dart';
import 'email_signup.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
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
          title: Text("",
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
                Container(color: Colors.black,
                  padding: EdgeInsets.only(top:30.0),
                  child: Image.asset(Config.icono,scale: 1,)
                ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text("InAdvanced",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,color: Colors.white,
                      fontSize: 30,
                      fontFamily:'Roboto')),
            ),
                Container(
                  width: 250,
                  height: 65,
                  padding: EdgeInsets.all(10),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(
                        width: 1,
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text("Regístrate con su email"),
                    color: Colors.blue.shade600,
                    textColor: Colors.white,
                    splashColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmailSignUp()),
                      );
                    },
                  ),
                ),
                Container(
                  width: 250,
                  height: 65,
                  padding: EdgeInsets.all(10),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text("Login"),
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EmailLogIn()),
                        );
                      },
                    ),
                ),

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
                            color: Colors.grey)),
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

