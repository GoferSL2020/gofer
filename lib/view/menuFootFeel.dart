import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iafootfeel/auth/signup.dart';
import 'package:iafootfeel/dao/CRUDJugador.dart';
import 'package:iafootfeel/main.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/my_flutter_app_icons.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/modelo/FiltroJugadores.dart';
import 'package:iafootfeel/view/nacionalidad/nacionalidadesView.dart';

import 'package:iafootfeel/view/pais/paisView.dart';

import 'package:iafootfeel/wigdet/compartirExcel.dart';

import 'package:iafootfeel/futbol_mio_icons.dart';
import 'package:iafootfeel/view/scouter/scouterView.dart';
import 'package:iafootfeel/wigdet/politica.dart';
import 'package:iafootfeel/wigdet/termino.dart';

import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/view/jugadores/jugadoresView.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/view/menuFootFeelScouter.dart';
import 'package:url_launcher/link.dart';

import '../custom_icon_icons.dart';

class MenuFootFeel extends StatefulWidget {
  MenuFootFeel();
  @override
  _MenuFootFeelState createState() => new _MenuFootFeelState();

}

class _MenuFootFeelState extends State<MenuFootFeel> {
  Key key = UniqueKey();
  bool _director = false;
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }



  List<Player> jugadoresDATA = [];
  getModificarJugadorAlgo()async{
    FirebaseFirestore _db = FirebaseFirestore.instance;
    jugadoresDATA.clear();
    jugadoresDATA=await CRUDJugador().fetchJugadores();
    for(var jug in jugadoresDATA){
      CRUDJugador().updateJugadorScouting(jug);
    }
  }


  void inicio() async {
    await BBDDService().getUsuarioIniciar();
    bool d =
    ((BBDDService().getUserScout().puesto == "FootFeel")||(BBDDService().getUserScout().puesto == "Marketing"))
        ? true : false;
    setState(() {
      _director = d;
    });
  }

  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });
    inicio();
    super.initState();
    //getImportar();
    //getCambioSenior();
    //getModificarJugadorAlgo();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        // backgroundColor: Colors.grey,

        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: new Image.asset(Config.icono),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.black,
          title: Text("FootFeel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Config.colorFootFeel,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        drawer: MenuLateral(),
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 1.0],
                  tileMode: TileMode.repeated),
            ),
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Material(
                    color: Colors.black,
                    child: Ink.image(
                      image: AssetImage('assets/img/logogrande.png'),
                      fit: BoxFit
                          .contain, //Add this line for center crop or use 2nd way
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Config.colorFootFeel,
                ),
                Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Material(
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(
                            splashColor: Colors.orange,
                            onTap: () {
                              Pais pais=new Pais("", "", "");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => JugadoresView(
                                          FiltroJugadores(
                                              "", true, "", "FootFeel", "", ""),pais
                                          )));
                            },
                            child: Ink.image(
                              image: AssetImage('assets/img/azul.png'),
                              fit: BoxFit
                                  .contain, //Add this line for center crop or use 2nd way
                              height: 125,
                              width: 125,
                            ),
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "FootFeel",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Config.colorFootFeel,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ))
                    ,
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.orange,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MenuFootFeelScouter()));
                        },
                        child: Ink.image(
                          image: AssetImage('assets/img/gris.png'),
                          fit: BoxFit
                              .contain, //Add this line for center crop or use 2nd way
                          height: 125,
                          width: 125,
                        ),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Agentes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                (BBDDService().getUserScout().puesto != "Marketing")?
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.orange,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PaisView(false)));
                        },
                        child: Ink.image(
                          image: AssetImage('assets/img/marron.png'),
                          fit: BoxFit
                              .contain, //Add this line for center crop or use 2nd way
                          height: 125,
                          width: 125,
                        ),
                      ),
                    )):  Container(),
                (BBDDService().getUserScout().puesto != "Marketing")?
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "World",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )):  Container(),

              ],
            )));
  }
}

class MenuLateral extends StatelessWidget {
  MenuLateral();

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              "assets/img/icono.png",
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          BBDDService().getUserScout().puesto == "FootFeel"
              ? Ink(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      "Descargar Excel",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      CompartirExcel compartir = new CompartirExcel();
                      compartir.generateExcel();
                    },
                    leading:
                        const Icon(CustomIcon.file_excel, color: Colors.green),
                  ),
                )
              : Ink(
                  color: Colors.white,
                  child: Container(),
                ),
          BBDDService().getUserScout().puesto == "FootFeel" ?
          Ink(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      "Agentes FootFeel",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => ScouterView()));
                    },
                    leading:
                        const Icon(FutbolMio.entrenador_1, color: Colors.white),
                  ),
                )
              : Ink(
                  color: Colors.white,
                  child: Container(),
                ),
          BBDDService().getUserScout().puesto != "Marketing" ? Ink(
            color: Colors.white,
            child: ListTile(
              title: Text(
                "Equipos",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => PaisView(true)));
              },
              leading: const Icon(FutbolMio.sustituir, color: Colors.white),
            ),
          ):Container(),
          BBDDService().getUserScout().puesto != "Marketing" ?
          Ink(
            color: Colors.white,
            child: ListTile(
              title: Text(
                "Nacionalidades",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => NacionalidadesView()));
              },
              leading: const Icon(CustomIcon.flag, color: Colors.white),
            ),
          ):Container(),
          /*
            BBDDService().getUserScout().categoria=="Todas"?
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: Text("Importar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            Migraciones()));
                  },
                  leading: const Icon(CustomIcon.file_import, color: Colors.white),
                ),

              ):null,
*/
          Container(
            height: 1,
            color: Colors.white,
          ),
          Ink(
            color: Colors.white,
            child: ListTile(
              title: Text(
                BBDDService().getUserScout().apellido,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
              leading: const Icon(Icons.person, color: Colors.white),
            ),
          ),
          Ink(
            color: Colors.white,
            child: ListTile(
              title: Text(
                BBDDService().getUserScout().email,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
              leading: const Icon(Icons.mail, color: Colors.white),
            ),
          ),
          Container(
            height: 1,
            color: Colors.white,
          ),
          Ink(
            color: Colors.white,
            child: ListTile(
              title: Text(
                "Politica de Privacidad",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => Politica()),
                );
              },
              leading: const Icon(Icons.assignment_turned_in_sharp,
                  color: Colors.white),
            ),
          ),
          Ink(
            color: Colors.white,
            child: ListTile(
              title: Text(
                "Término de Privacidad",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => Termino()),
                );
              },
              leading: const Icon(Icons.add_moderator, color: Colors.white),
            ),
          ),
          Container(
            height: 1,
            color: Colors.white,
          ),
          Ink(
            color: Colors.grey,
            child: ListTile(
                title: Text(
                  "Salir",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyApp()),
                          (route) => false));
                },
                leading: Icon(
                  MyFlutterApp.power_off,
                  size: 20,
                  color: Colors.red,
                )),
          ),
        ]),
      ),
    );
  }


  void closeApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }
}
