import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/PaisService.dart';
import 'package:iadvancedscout/dao/categoriaDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/main.dart';
import 'package:iadvancedscout/model/categoria.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/model/temporada.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/notifications.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/sheets/gsheets.dart';
import 'package:iadvancedscout/sheets/sheets_controller.dart';
import 'package:iadvancedscout/userScout.dart';
import 'package:iadvancedscout/view/addPais.dart';
import 'package:iadvancedscout/view/categorias.dart';
import 'package:iadvancedscout/view/filtroJugadores.dart';
import 'package:iadvancedscout/view/filtroOnceJornadaJugadores.dart';
import 'package:iadvancedscout/view/jugadoresFiltros.dart';
import 'package:iadvancedscout/view/paises.dart';
import 'package:iadvancedscout/view/temporada/temporadaView.dart';
import 'package:iadvancedscout/wigdet/migraciones.dart';
import 'package:iadvancedscout/wigdet/politica.dart';
import 'package:iadvancedscout/wigdet/termino.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:iadvancedscout/wigdet/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'categoriasList.dart';

class TemporadasPage extends StatefulWidget {
  @override
  _TemporadasPageState createState() => _TemporadasPageState();
}

class _TemporadasPageState extends State<TemporadasPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "temporadas";
  List<Temporada> temporadaList = <Temporada>[];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  @override
  void initState() {
    temporadaList.clear();
    nodeName = "temporadas";
    //name();
    _database.reference().child(nodeName).orderByChild("temporada").onChildAdded.listen(_childAdded);
   //_database.reference().child(nodeName).orderByChild("temporada").once().then((value) => _childAdded);


  }

  void name() async {
    DatabaseReference dbRef =  FirebaseDatabase.instance.reference().child("temporadas/2021-2022");
     dbRef.set({
      "temporada": "2021-2022",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:
      AppBar(actions: <Widget>[
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
        title: Text("IAScout - Temporadas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: MenuLateral(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: temporadaList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            dataBody2(),

          ],
        ),
      ),
     /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>AddPais()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        tooltip: "add a post",
      ),*/
    );
  }


  void pagePais(BuildContext context, Temporada id) {
    //print("ID:${id.pais}");
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => PaisesPage(id),
      ));
  }


  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(duration:  Duration(seconds: 1), content: Text(message),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }



  Visibility dataBody2(){
    return Visibility(
      visible: temporadaList.isNotEmpty,
      child: Flexible(
          child: FirebaseAnimatedList(
              query: _database.reference().child(nodeName),
              itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                return index<temporadaList.length?
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: new RaisedButton(
                        elevation: 0.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        onPressed: ()  async {
                          Temporada temporada=new Temporada('${temporadaList[index].temporada}', null);
                          BBDDService().getUserScout().temporada='${temporadaList[index].temporada}';
                          pagePais(context, temporada);
                        },
                        child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Card(
                                  elevation: 10,
                                  child: Container(color: Colors.black,
                                    height: 60,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.9,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                "Temporada "
                                                    "${temporadaList[index].temporada.toString().toUpperCase()}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 16,
                                                    fontStyle: FontStyle.italic),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ]
                          ),
                        textColor: Colors.black,
                        color: Colors.white),
                  ),
                 ):Container();
              })
      ),
    );
  }


  _childAdded(Event event) {
    setState(() {
      if(BBDDService().getUserScout().categoria=="Todas"){
        print(event.snapshot.value);
        print(BBDDService().getUserScout().categoria);
        temporadaList.add(Temporada.fromSnapshot(event.snapshot));
      }
      else {
        if(event.snapshot.value['temporada']!="2020-2021") {
          print("DENTRO2"+event.snapshot.value['temporada']);
          temporadaList.add(Temporada.fromSnapshot(event.snapshot));
        }
      }

    });
    print("lista:"+temporadaList.length.toString());
  }

  void _childRemoves(Event event) {
    //print("_childRemoves");
    var deletedPost = temporadaList.singleWhere((post){
      return post.temporada == event.snapshot.key;
    });

    setState(() {
      temporadaList.removeAt(temporadaList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = temporadaList.singleWhere((post){
      return post.temporada == event.snapshot.key;
    });

    setState(() {
      temporadaList[temporadaList.indexOf(changedPost)] = Temporada.fromSnapshot(event.snapshot);
    });
  }
}


class MenuLateral extends StatelessWidget {

  MenuLateral();

  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return new Drawer(
      child: Container(color: Colors.black,
        child: ListView(
            children: <Widget>[
              DrawerHeader(
                 child: Image.asset(
                    "assets/img/icono.png",),
                decoration: BoxDecoration(
                    color: Colors.black
                ),
              ),
              BBDDService().getUserScout().categoria=="Todas"?
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: Text("ANTIGUA",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TemporadasPage()));
                  },
                  leading: const Icon(Icons.person, color: Colors.white),
                ),

              ):null,
              BBDDService().getUserScout().categoria=="Todas"?
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: Text("NUEVA",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TemporadaView()));
                  },
                  leading: const Icon(Icons.person, color: Colors.white),
                ),

              ):null,
              BBDDService().getUserScout().categoria=="Todas"?
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: Text("MIGRACIONES",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Migraciones()));
                  },
                  leading: const Icon(Icons.person, color: Colors.white),
                ),

              ):null,
              Container(height: 1,color: Colors.white,),
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    BBDDService().getUserScout().name,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                     Navigator.pop(context);
                   Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UserView()));
                  },
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
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UserView()));
                  },
                  leading: const Icon(Icons.mail, color: Colors.white),
                ),

              ),
              Container(height: 1,color: Colors.white,),
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
                          builder: (BuildContext context) =>
                              Politica()),
                    );
                  },
                  leading: const Icon(Icons.assignment_turned_in_sharp, color: Colors.white),
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
                          builder: (BuildContext context) =>
                              Termino()),
                    );
                  },
                  leading: const Icon(Icons.add_moderator, color: Colors.white),
                ),
              ),
              Container(height: 1,color: Colors.white,),
              Ink(
                color:Colors.grey,
                child: ListTile(
                    title: Text("Búsqueda de jugadores", style: TextStyle(color:Colors.white, fontSize: 14),),
                    onTap: () {

                      //Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => FiltroJugadores(),
                      ));
                    },
                    leading: Icon(Icons.star, color: Colors.white,)
                ),),
              Container(height: 1,color: Colors.white,),
              Ink(
                color:Colors.grey,
                child: ListTile(
                    title: Text("Jugadores destacados por jornada", style: TextStyle(color:Colors.white, fontSize: 14),),
                    onTap: () {

                      //Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => FiltroOnceJugadores(),
                      ));
                    },
                    leading: Icon(CustomIcon.camiseta, size:20, color: Colors.white,)
                ),),
            ]),
      ),
    );
  }


}
