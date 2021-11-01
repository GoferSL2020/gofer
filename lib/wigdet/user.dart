import 'package:iadvancedscout/auth/signup.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/paises.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/politica.dart';
import 'package:iadvancedscout/wigdet/termino.dart';
import 'package:iadvancedscout/wigdet/texto.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class UserView extends StatefulWidget {
  UserView({Key key}) : super(key: key);

  @override
  UserViewState createState() => UserViewState();
}

class UserViewState extends State<UserView> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String language;
  String color = 'gris';
 // List<String> languages = <String>['es-ES', 'en-US','es-CO','es-CR','es-DO','es-EC','es-GT','es-HN','es-MX','es-NI','es-PA','es-PR','es-PY','es-SV','es-UY','es-VE'];
  //List<String> languages;
  List<String> languages = <String>['es-ES', 'en-US','es-MX','en-GB','fr-FR'];
  List<String> colores = <String>['azul', 'rojo', 'gris'];
/*
const Language('Francais', 'fr_FR'),
  const Language('English', 'en_US'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),en-GB
  fr-FR
 */
  void initState() {
    nameController.text = BBDDService().getUserScout().name;
     super.initState();
  }
  Future<void> singOut() async {
    try {
      return FirebaseAuth.instance.signOut();
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message),
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
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.fondo,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios , color: Colors.white),
          onPressed: () => Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => TemporadasPage(),
          )),
        ),
        //backgroundColor: Config.colorAPP,
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.power_settings_new_sharp),
            onPressed: () {
              //var a = singOut();
              //if (a != null) {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => SignUp(),
              ));
              //}
            },
          ),
            IconButton(
                icon: new Image.asset(Config.icono),
          ),

        ],
        title: Text("Perfil",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Texto(Colors.black,
                    BBDDService().getUserScout().email, 14.0, null,false)),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return "Nombre";
                  }
                  return null;
                },
              ),
            ),
            /*    Padding(
                    padding: EdgeInsets.only(top:5.0, left:20, right: 20, bottom: 5),
                    child: Row(children: [
                      Texto(Colors.black, "Color", 12, Config.fondo),
                      _colorDropDownSection(),
                    ]),
                  ),*/
            Padding(
              padding: EdgeInsets.all(5.0),
              child: isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      color: Config.colorAPP,
                      shape: Border.all(color: Config.fondo, width: 1.0),
                      child: Text("Aceptar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          )),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          var a = registerToFb();
                          if (a == null) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                    ),
            ),

            Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 40.0, right: 10),
                    child: GestureDetector(
                        child: Text("Termino",
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
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: GestureDetector(
                      child: Text("|",
                          style: TextStyle(fontSize: 10, color: Colors.blue)),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 40.0, left: 10),
                    child: GestureDetector(
                        child: Text("Politica",
                            style: TextStyle(
                                fontSize:10,
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Politica()),
                          );
                        })),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  /* SizedBox(
                width: double.infinity,
                height: 48.0,
                child: FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text('Phoenix.rebirth(context);'),
                  /// 2. Call Phoenix.rebirth(context) to rebuild your app
                  onPressed: () => Phoenix.rebirth(context),
                ),
              ),*/



  Future<void> registerToFb() async {

    User result = FirebaseAuth.instance.currentUser;
    dbRef.child(result.uid).update({
      "año": ageController.text,
      "nombre": nameController.text,
      "idioma": language,
      "color": color
    }).then((res) {
      setState(() {
        isLoading = false;
        BBDDService().getUserScout().name = nameController.text;
          setState(() {


        });
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
    ageController.dispose();
    language="";
  }
}
