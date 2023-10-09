import 'package:gls/conf/config.dart';

import 'package:flutter/material.dart';

import 'email_login.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Config.colorCard,
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
          backgroundColor:Config.fondo,
          title: Text("GLS - General Logistics Systems",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Config.letras,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        body:   SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
                Container(
                    padding: EdgeInsets.only(left:20,top:30.0,right: 20),
                  child: Image.asset(Config.icono, width: 200, height: 200,)
                ),
                Padding(
                  padding: EdgeInsets.only(top:25.0,bottom: 30),
                  child: Text("General Logistics Systems",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,color: Config.fondo,
                          fontSize: 20,
                          fontFamily:'Roboto')),
                ),
                /*Container(
                  width: 250,
                  height: 65,
                  padding: EdgeInsets.all(10),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(
                        width: 1,
                        color: Config.fondo,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text("Regístrate con su email"),
                    color:  Config.letras,
                    textColor: Config.fondo,
                    splashColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmailSignUp()),
                      );
                    },
                  ),
                ),*/
                Container(
                  width: 250,
                  height: 65,
                  padding: EdgeInsets.all(10),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(
                          width: 1,
                          color: Config.letras,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text("Login"),
                      color:  Config.fondo,
                      textColor: Config.letras,
                      splashColor: Colors.black,
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
                        "la Política de Privacida de inadvanced.",textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black)),
                    )),


            ],)),
        ]),
    ));
  }
}

