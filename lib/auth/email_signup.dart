
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/icon_mio_icons.dart';
import 'package:iadvancedscout/view/temporada/temporadaView.dart';



class EmailSignUp extends StatefulWidget {
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String language;
  String color='gris';
  List<String> languages = <String>['es-ES'];
  List<String> colores = <String>['azul','rojo','gris'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Colors.black,
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

          title: Text("IAScout - Sign up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
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


                  Padding(
                  padding: EdgeInsets.only(top:20.0, left:10, right: 30, bottom: 5),
                child: TextFormField(

                  style: TextStyle(
                    color: Colors.white,
                  ),controller: nameController,
                  decoration: InputDecoration(
                    icon: Icon(IconMio.person,color: Colors.white,size: 20,),
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    labelStyle: new TextStyle(
                        color: Colors.white
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Nombre",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nombre';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:5.0, left:10, right: 30, bottom: 5),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(IconMio.mail,color: Colors.white,size: 20,),
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    labelStyle: new TextStyle(
                        color: Colors.white
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Correo eléctronico",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
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
                    color: Colors.white,
                  ),

                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key_sharp,color: Colors.white,size: 20,),
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    labelStyle: new TextStyle(
                        color: Colors.white
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Password",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Contraseñas';
                    } else if (value.length < 6) {
                      return 'Password must be atleast 6 characters!';
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
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text("Enviar"),
                    color: Colors.blue.shade600,
                    textColor: Colors.white,
                    splashColor: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
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

  Future _getLanguages() async {
    if (languages != null) setState(() => languages);

  }


  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (dynamic type in languages) {
      items.add(
          DropdownMenuItem(value: type as String, child: Text(type as String)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String selectedType) {
    setState(() {
      language = selectedType;
    });
  }

  Widget _languageDropDownSection() => Container(
      padding: EdgeInsets.only(top: 0.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguageDropDownMenuItems(),
          onChanged: changedLanguageDropDownItem,
        ),
      ]));

  List<DropdownMenuItem<String>> getColorDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (dynamic type in colores) {
      items.add(
          DropdownMenuItem(value: type as String, child: Text(type as String)));
    }
    return items;
  }

  void changedColorDropDownItem(String selectedType) {
    setState(() {
      color = selectedType;
    });
  }

  Widget _colorDropDownSection() => Container(
      padding: EdgeInsets.only(top: 0.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: color,
          items: getColorDropDownMenuItems(),
          onChanged: changedColorDropDownItem,

        )
      ]));



  Future<void> registerToFb() async {

    return firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      dbRef.child(result.user.uid).set({
        "email": emailController.text,
        "nombre": nameController.text,
      }).then((res) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TemporadaView()));
      });
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      return null;
    });

  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
