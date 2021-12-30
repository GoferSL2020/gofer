
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:intl/intl.dart';

import 'notaPuntosJornada.dart';

class JugadoresJornadaPage extends StatefulWidget {
  const JugadoresJornadaPage(this._equipo, this._jornada);

  @override
  _JugadoresJornadaPageState createState() => _JugadoresJornadaPageState();
  final Equipo _equipo;
  final int _jornada;

}

class _JugadoresJornadaPageState extends State<JugadoresJornadaPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String nodeName = "jugadores";
  String nodeNameEquipos = "Equipos";
  String nodeNameEquipoContrario ="jornadas/${BBDDService().getUserScout().temporada}";
  List<Jugador> jugadoresList = <Jugador>[];
  String jornadaCategoria;
  String _jornadaEquipo;
  List<String> _equipos = List();
  bool isEquipos=false;
  bool _isCasa=true;


  var _fechaJornada;

  List<int> jornadas=new List();


  List<DropdownMenuItem<String>> listaEquipos=List();

// no need of the file extension, the name will do fine.

  @override
  void initState() {
    nodeName = "temporadas/${BBDDService().getUserScout().temporada}/paises/${widget._equipo.pais}"
        "/categorias/${widget._equipo.categoria}/"
        "equipos/${widget._equipo.equipo}/jugadores";
    nodeNameEquipos='temporadas/${BBDDService().getUserScout().temporada}/paises/${widget._equipo.pais}/categorias/${widget._equipo.categoria}/equipos';
    //_database.reference().child(nodeName).onChildChanged.listen(_putPuntuaciones);
    //_database.reference().child(nodeName).onValue.listen(_putPuntuaciones);
    nodeNameEquipoContrario="jornadas/${BBDDService().getUserScout().temporada}/${widget._equipo.equipo}";

    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
    jornadaCategoria=widget._equipo.categoria;
    _equiposLista();
    _jornadaFechaEquipo();
  }

  void _jornadaFechaEquipo() {
    List<String> res = List();
    _database.reference()
        .child(nodeNameEquipoContrario)
        .once()
        .then((DataSnapshot snapshotResult) {

      if (snapshotResult == null || snapshotResult.value == null) return null;
      Map<dynamic, dynamic> aux = snapshotResult.value;
      aux.forEach((key, value) {
        _database.reference()
            .child(nodeNameEquipoContrario+"/"+key+"/"+widget._jornada.toString())
            .once()
            .then((DataSnapshot snapshotResult2) {
                  if (snapshotResult2 == null || snapshotResult2.value == null) return null;
                  Map<dynamic, dynamic> aux2 = snapshotResult2.value;
                  if(aux2['equipoContrario']!=null){
                    setState(() {
                      _jornadaEquipo = aux2['equipoContrario'];
                      _fechaJornada = aux2['fecha'];
                      _isCasa=aux2['casaFuera']=="CASA"?true:false;

                    });
                  }
           });
       });
    });
  }


  void _equiposLista() {
     List<String> res = List();
     _database.reference()
        .child('temporadas/${BBDDService().getUserScout().temporada}/paises/${widget._equipo.pais}/categorias/${widget._equipo.categoria}/equipos')
        .once()
        .then((DataSnapshot snapshotResult) {
      if (snapshotResult == null || snapshotResult.value == null) return null;
      Map<dynamic, dynamic> aux = snapshotResult.value;
      aux.forEach((key, value) {
        if(value["equipo"]!=widget._equipo.equipo)
          _equipos.add(value["equipo"]);
      });
    });
  }


  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      _fechaJornada = DateFormat('dd-MM-yyyy').format(order);
    });
  }

    Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale : const Locale("es","ES"),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Container(

        color: Colors.white,
        child: Column(
          children: <Widget>[
              Padding(
                padding:
                EdgeInsets.only( top: 15.0, left: 10, right:20, bottom: 5),
                    child: new Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(200.0),
                      1: FixedColumnWidth(110.0),
                      2: FixedColumnWidth(40.0),
                    },
                    defaultVerticalAlignment:
                    TableCellVerticalAlignment.middle,
                    //border: TableBorder.all(),
                    children: [
                      TableRow(
                          children: [
                            FormField(
                                builder: (FormFieldState state) {
                                   return
                                     Container(height: 50,color: Colors.white,
                                       padding:
                                       EdgeInsets.only( top: 0, left: 0, right:0, bottom: 0),
                                       child:InputDecorator(
                                         decoration: InputDecoration(
                                        labelText: "Equipo",
                                        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 10.0),
                                        hintText: 'Please select expense',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0))
                                    ),
                                    isEmpty: _jornadaEquipo == '',

                                    child: new DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(

                                        value: _jornadaEquipo,
                                        isExpanded: true,
                                        isDense: true,
                                        style: new TextStyle(fontSize: 10, color: Colors.black),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _jornadaEquipo = newValue;
                                            state.didChange(newValue);
                                          });
                                        },
                                        items:
                                         _equipos.map((String value) {
                                          return DropdownMenuItem<String>(

                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),),
                                  );
                                }),
                            Container(height: 50,
                              decoration: BoxDecoration(color: Colors.black),
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                              child: _fechaJornada == null
                                  ? Text(
                                "",
                                textScaleFactor: 1.0,
                              )
                                  : Text(
                                "$_fechaJornada", style: TextStyle(fontSize: 15, color:Colors.white),
                              ),
                            ),
                            FlatButton(

                                onPressed:callDatePicker,
                                color: Colors.black,
                                padding: EdgeInsets.all(0.0),
                                child: Column( // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Container(height: 50,
                                    child:Icon(Icons.calendar_today_outlined, color:Colors.white,size: 25,),
                                    ),
                                  ],
                                ),
                            ),
                          ]),
                        TableRow(children: [
                          Row(children: [
                            new Text("Local",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,

                                )),
                            Switch(
                              value: _isCasa,
                              onChanged: (newValue) {
                                setState(() {
                                  _isCasa=newValue;
                                });
                              },
                              activeTrackColor: Colors.blue[900],
                              activeColor: Colors.blue[900],
                            ),
                            new Text("Visitante",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,

                                )),
                            Switch(
                              value: !_isCasa,
                              onChanged: (newValue) {
                                setState(() {
                                  _isCasa=!newValue;
                                });
                              },
                              activeTrackColor: Colors.blue[900],
                              activeColor: Colors.blue[900],
                            ),
                          ],),
                          Container(
                            padding: EdgeInsets.only(left:50),
                            child:new Text("Destacado",
                                style: TextStyle(

                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                )),
                          ),
                          Icon(CustomIcon.star,size: 20,
                              color: Colors.yellow[500])
                        ]),
                    ]),

            ),


            Visibility(
              visible: jugadoresList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
                Visibility(
                  visible: isFechaEquipo(),
                  child: Flexible(
                      child: FirebaseAnimatedList(
                          query: _database.reference().child(nodeName),
                          itemBuilder: (query, DataSnapshot snap,
                              Animation<double> animation, int index) {
                              String casa=_isCasa==true?"CASA":"FUERA";
                            itemCount: jugadoresList.length;
                                return ListTile(
                                      title:NotaPuntosJornada(jugadoresList[index]
                                            .jugador, widget._jornada, jugadoresList[index], true, _jornadaEquipo, _fechaJornada, casa)

                                 // , backgroundImage:  ExactAssetImage('assets/img/jugador.png')

                                );

                          })),
                )
            //dataBody(),
          ],
        ),
      ),
    );
  }


    bool isFechaEquipo(){
      return ((_fechaJornada!=null) && (_jornadaEquipo!=null));
    }
  _childAdded(Event event) {
    setState(() {
      jugadoresList.add(Jugador.fromSnapshot(event.snapshot));
      jugadoresList.sort((a, b) => a.dorsal.compareTo(b.dorsal));
    });
  }

  void _childRemoves(Event event) {
    //print("_childRemoves");
    var deletedPost = jugadoresList.singleWhere((post) {
      return post.pais == event.snapshot.key;
    });
    setState(() {
      jugadoresList.removeAt(jugadoresList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    //print("CHILDCHANGED");
    var changedPost = jugadoresList.singleWhere((jugador) {
      return jugador.id == event.snapshot.key;
    });
    setState(() {
      jugadoresList[jugadoresList.indexOf(changedPost)] =
          Jugador.fromSnapshot(event.snapshot);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


}
