
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/icon_mio_icons.dart';
import 'package:iafootfeel/view/menuFootFeel.dart';



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
  TextEditingController apellidoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String language="";
  String color='gris';
  List<String> languages = <String>['es-ES'];
  List<String> colores = <String>['azul','rojo','gris'];
  List<String> _puestos = <String>['FootFeel','Agenda FootFeel','Marketing'];
  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentPuesto="";
  @override

  @override
  void initState(){
    _dropDownMenuItems = getDropDownMenuItems();
    _currentPuesto= _dropDownMenuItems[0].value!;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(){
    List<DropdownMenuItem<String>> items = [];
    for (String item in _puestos){
      items.add(new DropdownMenuItem(
        value: item,
        child: new Text(
            item,
            style: TextStyle(
              fontSize:12,
            )
        ),
      ));
    }
    return items;
  }

  void changedDropDownItem(String selected){
    setState(() {
      _currentPuesto = selected;
    });
  }
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

          title: Text("FootFeel - Sign up",
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
                      child: Image.asset(Config.icono)
                  ),
                  //#6ea9dc
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("FootFeel",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,color: Color.fromRGBO(110,169,220,1.0),
                            fontSize: 40,
                            fontFamily:'Roboto')),
                  ),
                  Row(children: [
                    Padding(
                        padding: EdgeInsets.only(top:0.0, left:20, right: 30, bottom: 5),
                        child:Text("Puesto:",
                            style: TextStyle(
                            fontSize:20, color:Colors.white))
                    ),
                    Container(color:Colors.white,height: 30,
                      padding: EdgeInsets.only(top:0.0, left:30, right: 20, bottom: 0),
                      child:DropdownButton(
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        value: _currentPuesto,
                        items: _dropDownMenuItems,
                        onChanged: (String? value) {
                        setState(() {
                            _currentPuesto = value!;
                        });
                        },
                      ),
                      ),

                      ]),
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
                    if (value!.isEmpty) {
                      return 'Nombre';
                    }
                    return null;
                  },
                ),
              ),
                  Padding(
                    padding: EdgeInsets.only(top:20.0, left:10, right: 30, bottom: 5),
                    child: TextFormField(

                      style: TextStyle(
                        color: Colors.white,
                      ),controller: apellidoController,
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
                        labelText: "Apellido",
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Apellido';
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
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text("Enviar"),
                    color: Colors.blue.shade600,
                    textColor: Colors.white,
                    splashColor: Colors.black,
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



  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems() {
    var items = <DropdownMenuItem<String>>[];
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



  List<DropdownMenuItem<String>> getColorDropDownMenuItems() {
    var items = <DropdownMenuItem<String>>[];
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




  Future<void> registerToFb() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) => putUsuario(value.user!.uid));
      BBDDService().getUsuarioIniciar();
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuFootFeel()));
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

  putUsuario(String uid){
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("users").doc(uid).set({
      'nombre': nameController.text.toUpperCase(), // John Doe
      'apellido': apellidoController.text.toUpperCase(), // Stokes and Sons
      'puesto': _currentPuesto,
    }).then((value){
    });
    BBDDService().getUsuarioIniciar();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    apellidoController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
