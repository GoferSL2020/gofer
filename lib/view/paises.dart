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
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/sheets/gsheets.dart';
import 'package:iadvancedscout/sheets/sheets_controller.dart';
import 'package:iadvancedscout/userScout.dart';
import 'package:iadvancedscout/view/addPais.dart';
import 'package:iadvancedscout/view/categorias.dart';
import 'package:iadvancedscout/view/filtroJugadores.dart';
import 'package:iadvancedscout/view/filtroOnceJornadaJugadores.dart';
import 'package:iadvancedscout/view/jugadoresFiltros.dart';
import 'package:iadvancedscout/wigdet/politica.dart';
import 'package:iadvancedscout/wigdet/termino.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:iadvancedscout/wigdet/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'categoriasList.dart';

class PaisesPage extends StatefulWidget {
  const PaisesPage(this._temporada);
  @override
  _PaisesPageState createState() => _PaisesPageState();
  final Temporada _temporada;
}

class _PaisesPageState extends State<PaisesPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "";
  List<Pais> paisList = <Pais>[];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Jugador> jugadoresList = <Jugador>[];


  @override
  void initState() {
    nodeName = "temporadas/${BBDDService().getUserScout().temporada}/paises";
    /*setState(() {
      getPais();

    });*/
   // getJugadores();
   // _database.reference().child('temporadas/2021-2022').onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
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
        title: Text("IAScout - Paises",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: paisList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Container(color:Colors.black,
                padding: EdgeInsets.all(1.0),
                child: Texto(Colors.red,"${BBDDService().getUserScout().temporada}".toUpperCase()
                    ,14, Colors.black, false)),
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


  void pageCategoria(BuildContext context, Pais id) {
    //print("ID:${id.pais}");
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => CategoriasPage(id),
      ));
  }


  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(duration:  Duration(seconds: 1), content: Text(message),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }



  getJugadores() async{
    FirebaseDatabase _database = FirebaseDatabase.instance;
    String nodeName = "jugadores";
    _database.reference()
        .child('jugadores')
        .once()
        .then((DataSnapshot snapshotResult) {
      if (snapshotResult == null || snapshotResult.value==null ) return;
      Map<dynamic, dynamic> paisesMap = snapshotResult.value;
      paisesMap.forEach((key, value) {
        jugadoresList.add(Jugador.fromJson(key, value));
      });
    });


    /// Async function which loads feedback from endpoint URL and returns List.
    /* Future<List<FeedbackForm>> getFeedbackList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
    });*/
  }
subirNube()async {
  SheetController sheetController=new SheetController();
  await ProductManager().insertTodos(jugadoresList);
  _showSnackbar("Jugadores Submitted");
}
  Visibility dataBody2(){
    return Visibility(
      visible: paisList.isNotEmpty,
      child: Flexible(
          child: FirebaseAnimatedList(
              query: _database.reference().child(nodeName),
              itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: new RaisedButton(
                        elevation: 0.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        onPressed: ()  async {
                          Pais pais=new Pais('${snap.value["pais"]}', null);
                          pais.temporada=widget._temporada.temporada;
                          pageCategoria(context, pais);

                        },
                        child: Column(children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              /*child:

                                "https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/jugadores%2F${jugador[index].id}?alt=media",
                                height: 30,
                              ),*/
                               new Image.network("https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/paises%2F${snap.value['pais'].toString().replaceAll("Ñ", "N")}.png?alt=media",
                                   height:20),

                              //new Image.asset('assets/pais/${snap.value['pais']}.png', height: 25.0, width: 25.0),

                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  "${snap.value['pais'].toString().toUpperCase()}",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                      fontSize: 15.0),textAlign: TextAlign.center,
                                ),),

                              Spacer(),
                              /*FlatButton(
                                onPressed: () async {
                                  setState(() {
                                    /*Jugador jugador=new Jugador(
                                        '${snap.value['jugador']}',
                                        '${snap.value['equipo']}',
                                        '${snap.value['categoria']}',
                                        '${snap.value['pais']}',
                                        '${snap.value['posicion']}',
                                        null);*/
                                //    Navigator.of(context).push(new MaterialPageRoute(
                                  //    builder: (BuildContext context) => CategoriasPage(element),
                                   // ));
                                    // JugadorService(widget.).deleteJugador(jugadoresList[index]);
                                    // jugadoresList.removeAt(index);
                                  });
                                },
                                padding: EdgeInsets.all(10.0),
                                child: Row( // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(Icons.restore_from_trash_outlined,
                                      color: Colors.white,),
                                  ],
                                ),
                              ),*/],
                          ),
                        ]),
                        textColor: Colors.black,
                        color: Colors.white),
                  ),
                );
              })),
    );
  }


  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(headingRowHeight:20,dataRowHeight: 55,
        columns: [
          DataColumn(label: Text('')),
          //DataColumn(label: Text('Action')),
        ],
        rows:
        paisList // Loops through dataColumnText, each iteration assigning the value to element
            .map(
          ((element) => DataRow(
            cells: <DataCell>[
              DataCell(
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: new RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      onPressed: ()  async {

                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => CategoriasPage(element),
                        ));

                      },
                      child: Column(children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: new Text(
                                element.pais.toString(),
                                style: TextStyle(

                                  // fontWeight: FontWeight.bold,
                                    fontSize: 15.0),textAlign: TextAlign.center,
                              ),
                            ),
                            Spacer(),
                            new Image.asset('assets/pais/${element.pais}.png', height: 25.0, width: 25.0),
                          ],
                        ),
                      ]),
                      textColor: Colors.white,
                      color: Colors.white),
                ),
              )],
          )),
        )
            .toList(),
      ),
    );
  }

  _childAdded(Event event) {
    setState(() {
      paisList.add(Pais.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    //print("_childRemoves");
    var deletedPost = paisList.singleWhere((post){
      return post.pais == event.snapshot.key;
    });

    setState(() {
      paisList.removeAt(paisList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = paisList.singleWhere((post){
      return post.pais == event.snapshot.key;
    });

    setState(() {
      paisList[paisList.indexOf(changedPost)] = Pais.fromSnapshot(event.snapshot);
    });
  }

}
