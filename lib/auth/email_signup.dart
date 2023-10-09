
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:gls/service/UserService.dart';
import 'package:gls/conf/config.dart';
import 'package:gls/view/menuGLS.dart';



class EmailSignUp extends StatefulWidget {
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lugarController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar:new  AppBar(actions: <Widget>[
          IconButton(
            icon: new Image.asset(Config.icono),onPressed: () {
          },
          )
        ],

          title: Text("GLS - Sign up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
                  Container(
                      padding: EdgeInsets.only(left:20,top:30.0,right: 20),
                      child:Image.asset(Config.icono, width: 200, height: 200,)
                  ),
                  //#6ea9dc
                  
                      Padding(
                      padding: EdgeInsets.only(top:20.0, left:10, right: 30, bottom: 5),
                      child: TextFormField(

                      style: TextStyle(
                      color: Config.fondo,
                      ),controller: nameController,
                      decoration: InputDecoration(
                      icon: Icon(Icons.map_outlined,color: Config.fondo,size: 20,),
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
                    labelText: "Oficina",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Oficina';
                    }
                    return null;
                  },
                ),
              ),
                  Padding(
                    padding: EdgeInsets.only(top:20.0, left:10, right: 30, bottom: 5),
                    child: TextFormField(
                      style: TextStyle(
                        color: Config.fondo,
                      ),controller: lugarController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.map_outlined,color: Config.fondo,size: 20,),
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
                        labelText: "lugar",
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'lugar';
                        }
                        return null;
                      },
                    ),
                  ),
              Padding(
                padding: EdgeInsets.only(top:5.0, left:10, right: 30, bottom: 5),
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
                        color: Config.letras,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text("Enviar"),
                    color:  Config.fondo,
                    textColor: Config.letras,
                    splashColor: Config.fondo,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        var a= registerToFb();
                        //print("a"+a.toString());
                        if (a==null) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                  ),
                ),
              )
            ]))));
  }


  Future<void> registerToFb() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) => putUsuario(value.user!.uid));
      await UserService().getUsuarioIniciar();
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuGLS()));
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message!),
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
    }
  }

  putUsuario(String uid) async{
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("users").doc(uid).set({
      'nombre': nameController.text.toUpperCase(), // John Doe
      'lugar': lugarController.text.toUpperCase(), // Stokes and Sons
    }).then((value){
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    lugarController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
