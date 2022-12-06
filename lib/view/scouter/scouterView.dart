import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/dao/CRUDCategoria.dart';
import 'package:iafootfeel/dao/CRUDPartido.dart';
import 'package:iafootfeel/dao/CRUDScout.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/jornada.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/partido.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/userScout.dart';
import 'package:iafootfeel/view/scouter/scoutCard.dart';
import 'package:iafootfeel/view/scouter/scoutEquiposView.dart';
import 'package:iafootfeel/wigdet/abajo.dart';

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
      categorias.addAll(datos);
    });
  }

  _cogerScout() async {
    List<UserScout> datos =
    await CRUDUserScout().fetchUserScouts();
    setState(() {
      scoutList.addAll(datos);
    });
  }


  @override
  void initState() {
       _cogerScout();
        //  _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
     // _database.reference().child(nodeName).orderByChild("_dorsal").onChildChanged.listen(_childChanged);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDUserScout();
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Container(
              width: 50,
              child: IconButton(
                icon: new Image.asset(Config.icono),
                onPressed: () {},
              )),
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
                child:Text('Lista de Agente FootFeel',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),),
              Visibility(
                  visible: scoutList.isNotEmpty,
                  child: Flexible(
                    child:
                    ListView.separated(
                        itemCount: scoutList.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 0,
                            color: Colors.green,
                          );
                        },
                        itemBuilder: (buildContext, index) {
                          return
                            ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                      ScoutEquiposView(scoutList[index])));
                                },

                                title: Row(children: [
                                  //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                  Expanded(child: Text("Agente FootFeel",
                                    style: TextStyle(

                                        color: Colors.blue.shade800,
                                        fontSize: 12.0,fontWeight: FontWeight.bold
                                    ),
                                  ),),
                                ]),
                                trailing: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 1, right: 5),
                                      height: 15.0,
                                      child: Text("",

                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Container(
                                        padding:
                                        EdgeInsets.only(top: 1, right: 5),
                                        height: 25.0,
                                        child: Text(
                                          "${scoutList[index].apellido}",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage("assets/img/scouter.png"),
                                ));
                        }),
                  )
              )

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
