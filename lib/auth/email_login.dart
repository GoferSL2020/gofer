
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gls/auth/email_password.dart';
import 'package:gls/conf/config.dart';

import 'package:gls/service/UserService.dart';
import 'package:gls/view/menuGLS.dart';
class EmailLogIn extends StatefulWidget {
  @override
  _EmailLogInState createState() => _EmailLogInState();
}

/*************************/
class _EmailLogInState extends State<EmailLogIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor:Config.colorCard,
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

          title: Text("GLS - Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Config.letras,
              )),
          elevation: 0,
          centerTitle: true,
          backgroundColor:Config.fondo,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(color: Config.colorCard,
                      padding: EdgeInsets.only(left:20,top:30.0,right: 20),
                      child: Image.asset(Config.icono, width: 200, height: 200,)
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:25.0, left:10, right: 30, bottom: 5),
                    child: TextFormField(
                      style: TextStyle(
                        color: Config.fondo,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.mail,color: Config.fondo,size: 20,),
                        hintStyle: TextStyle(
                            color: Config.fondo
                        ),
                        labelStyle: new TextStyle(
                            color: Config.fondo
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Config.fondo),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Config.fondo),
                        ),
                        labelText: "Correo eléctronico",
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Correo eléctronico';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:5.0, left:10, right: 30, bottom: 0),
                    child: TextFormField(
                      style: TextStyle(
                        color: Config.fondo,
                      ),

                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key_sharp,color: Config.fondo,size: 20,),
                        hintStyle: TextStyle(
                            color: Config.fondo
                        ),
                        labelStyle: new TextStyle(
                            color: Config.fondo
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Config.fondo),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Config.fondo),
                        ),
                        labelText: "Password",
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Contraseñas';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10, left:20, right: 20, bottom: 0),
                    child: isLoading
                        ? CircularProgressIndicator()
                        :
                    Container(
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
                        child: Text("Enviar"),
                        color:  Config.letras,
                        textColor: Config.fondo,
                        splashColor: Config.fondo,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            logInToFb();
                          }
                        },
                      ),
                    ),
                  )
             ,
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: Text("Olvidó la contraseña",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue)),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => EmailPassword()),
                            );
                          }))
            ]))));
  }


    void logInToFb() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) async {
       await UserService().getUsuarioIniciar();
       setState(() {
        isLoading = false;
      });
       Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuGLS()));
    }).catchError((err) {
      setState(() {
        isLoading =false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.toString()),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}
