import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/dao/CRUDScout.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/userScout.dart';
import 'package:iadvancedscout/view/scouter/scoutCard.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';

class ScouterView extends StatefulWidget {

  ScouterView();
  @override
  _ScouterViewState createState() => new _ScouterViewState();
}

class _ScouterViewState extends State<ScouterView> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "Users";
  List<UserScout> scoutList = <UserScout>[];
  List<Categoria> categorias = List();
  Categoria _categoriaAux = new Categoria();


  _cogerCategorias() async {
    List<Categoria> datos =
    await CRUDCategoria().fetchCategoriasScout();
    setState(() {
      _categoriaAux = datos[0];
      categorias.addAll(datos);
    });
  }


  @override
  void initState() {
       _cogerCategorias();
      nodeName = "Users";
      _database.reference().child(nodeName).orderByChild("name").onChildAdded.listen(_childAdded);
      //  _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
     // _database.reference().child(nodeName).orderByChild("_dorsal").onChildChanged.listen(_childChanged);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDUserScout();
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Container(
                    width: 50,
                    child: IconButton(
                      icon:
                      new Image.asset(Config.icono),

                      onPressed: () {
                        //var a = singOut();
                        //if (a != null) {

                        //}
                      },
                    ))]
          )
        ],
        backgroundColor: Colors.black,
        title: Text("IAScout -Scouter",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => Abajo(),
                ));
              },
            ),
          ],
        ),
      ),
      body:
      Container(
        child: Column(
            children: <Widget>[
              Container(
                height: 20,
                width: double.infinity,
                color:Colors.black,
                child:Text("Scouter",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.colorAPP,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),),
              Container(
                height: 20,
                width: double.infinity,
                color:Colors.black,
                child:Text('Lista de Scouter',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.colorAPP,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),),
                Flexible(
            child:
            FirebaseAnimatedList(
                  query: _database.reference().child(nodeName),
                  itemBuilder: (query, DataSnapshot snap,
                      Animation<double> animation, int index) {
                    //print(snap.value);
                    itemCount: scoutList.length;
                    return index<scoutList.length?
                    new ScoutCard(
                        scout: scoutList[index],categorias:categorias)
                        :Container();

                    },
                    ),),
                    //dataBody(),
                ]
         ),
      ),
    );
  }

    _childAdded(Event event) {
      //print(event.snapshot.value);
      setState(() {
        scoutList.add(UserScout.fromSnapshot(event.snapshot));
      });
}
}
