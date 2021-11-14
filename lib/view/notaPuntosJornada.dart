
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/locale/app_localization.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/jugadorJornada.dart';
import 'package:iadvancedscout/model/jugadorJornadaColumna.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/sheets/gsheets.dart';
import 'package:iadvancedscout/sheets/gsheetsSCOUT.dart';
import 'package:iadvancedscout/view/jugadoresJornada.dart';

import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../conf/config.dart';

class NotaPuntosJornada extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotaPuntosJornada();
  }

  NotaPuntosJornada(this._texto, this._jornada, this._jugador, this._vertical, this._jornadaEquipo, this._fecha, this._casaFuera);


  final String _texto;
  final int _jornada;
  final Jugador _jugador;
  final bool _vertical;
  final String _jornadaEquipo;
  final String _fecha;
  final String _casaFuera;
}




class _NotaPuntosJornada extends State<NotaPuntosJornada> {
  int puntoAux = 1;
  String nodeName = "jornadas";
  FirebaseDatabase _database = FirebaseDatabase.instance;
  int puntuaciones;
  int estrella;
  @override
  void initState() {
    if(mounted) {
      nodeName = "jornadas/${BBDDService().getUserScout().temporada}/${widget._jugador.equipo}/${widget._jugador
          .id}/${widget._jornada}";
      //_database.reference().child(nodeName).onChildChanged.listen(_putPuntuaciones);
      _database
          .reference()
          .child(nodeName)
          .onValue
          .listen(_putPuntuaciones);
      _database
          .reference()
          .child(nodeName)
          .onValue
          .listen(_putEstrella);
      //putPuntuaciones();
    }
  }

  @override
  void setState(fn) {
    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }
  _putEstrella(Event event) async{

    setState(() {
      _database.reference().child(nodeName).once().then((
          snapshotResult) {
        if (snapshotResult == null || snapshotResult.value==null ) return;
        Map<dynamic, dynamic> values = snapshotResult.value;
        estrella= values['estrella'];
      });
    });
    return estrella;

  }

   _putPuntuaciones(Event event) async{

     setState(() {
        _database.reference().child(nodeName).once().then((
          snapshotResult) {
        if (snapshotResult == null || snapshotResult.value==null ) return;
        Map<dynamic, dynamic> values = snapshotResult.value;
        puntuaciones= values['puntuaciones'];
      });
    });
  return puntuaciones;

  }


  Widget build(BuildContext context) {
    JugadorJornada jugadorJornada;
    JugadorJornadaColumna jugadorJornadaColumna;
    bool auxEstrella=false;
   // puntoAux=dameLosPuntos();
    // TODO: implement build
    return Container(
            padding: EdgeInsets.all(0),
            child: Column(children: [
              Row(crossAxisAlignment:
                  CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Texto(
                     Config.edadColorSub(Config.edadSub(widget._jugador.fechaNacimiento)), "${widget._jugador.dorsal}. ${widget._jugador.jugador} (${Config.edad(widget._jugador.fechaNacimiento)})", 12,
                       Colors.white, false),
                  Texto(
                        Colors.blue[900], "${widget._jugador.posicion.toUpperCase()}",7, Colors.white, false),
                  Switch(
                    value: estrella==1?true:false,
                    onChanged: (newValue) {
                      setState(() {
                        estrella=newValue==true?1:0;
                        ponerLosPuntosFireBaseEstrella(estrella);
                        ponerLosPuntosExcel(puntuaciones, jugadorJornada, jugadorJornadaColumna, estrella);
                      });
                    },
                    activeTrackColor: Colors.yellow[500],
                    activeColor: Colors.yellow[500],
                  ),

                  /*IconButton(
                    icon: Icon(CustomIcon.star,size: 20,  ),
                    color: estrella==1?Colors.yellow:Colors.grey,
                    tooltip: 'Estrella',
                    onPressed: () {
                      estrella==1?estrella=0:estrella=1;
                      ponerLosPuntosFireBaseEstrella(estrella);
                      ponerLosPuntosExcel(puntuaciones, jugadorJornada, jugadorJornadaColumna, estrella);
                      setState(() {
                        estrella==0?estrella=1:estrella=0;
                      });
                    },
                  )*/
                ],
              ),
              CupertinoSegmentedControl(
                  borderColor: Colors.black,
                  pressedColor: Colors.blue,
                  selectedColor: Colors.black,
                  unselectedColor: Colors.white,
                  groupValue: puntuaciones,
                  children: <int, Widget>{
                    4: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "4",
                          style: TextStyle(fontSize: 10),
                        )),
                    5: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "5",
                          style: TextStyle(fontSize: 10),
                        )),
                   6: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "6",
                          style: TextStyle(fontSize: 10),
                        )),
                    7: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "7",
                          style: TextStyle(fontSize: 10),
                        )),
                    8: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "8",
                          style: TextStyle(fontSize: 10),
                        )),
                    9: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "9",
                          style: TextStyle(fontSize: 10),
                        )),
                    10: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "10",
                          style: TextStyle(fontSize: 10),
                        )),
                    11: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "NA",
                          style: TextStyle(fontSize: 10),
                        )),
                    12: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "SC",
                          style: TextStyle(fontSize: 10),
                        )),
                  },
                  onValueChanged: (value) {
                    puntuaciones = value;
                    ponerLosPuntosFireBase(value);
                    ponerLosPuntosExcel(value, jugadorJornada, jugadorJornadaColumna, estrella);
                  }
                  ),
            ]));
  }

  ponerLosPuntosFireBaseEstrella(int value) async {

    _database.reference().child(nodeName).set({
      "fecha": widget._fecha,
      "equipoContrario": widget._jornadaEquipo,
      "jornada": widget._jornada,
      "casaFuera": widget._casaFuera,
      "estrella": value,
      "puntuaciones": puntuaciones,
      "categoria":widget._jugador.categoria,
      "jugador":widget._jugador.jugador,
      "equipo":widget._jugador.equipo,
      "posicion":widget._jugador.posicion,
      "fechaNacimiento":widget._jugador.fechaNacimiento,

    }).then((res) {}).catchError((err) {
      print(err);
    });
  }
  ponerLosPuntosFireBase(int value) async {

    _database.reference().child(nodeName).set({
      "puntuaciones": value,
      "fecha": widget._fecha,
      "equipoContrario": widget._jornadaEquipo,
      "jornada": widget._jornada,
      "casaFuera": widget._casaFuera,
      "estrella": estrella,
      "categoria":widget._jugador.categoria,
      "jugador":widget._jugador.jugador,
      "equipo":widget._jugador.equipo,
      "posicion":widget._jugador.posicion,
      "fechaNacimiento":widget._jugador.fechaNacimiento,

    }).then((res) {}).catchError((err) {
      print(err);
    });
  }
  ponerLosPuntosExcel(int value, JugadorJornada jugadorJornada,JugadorJornadaColumna jugadorJornadaColumna, int estrella) async{
        jugadorJornada=new JugadorJornada(
        value, widget._fecha,widget._jornada, widget._jugador.jugador,widget._jugador.posicion,
        widget._jugador.equipo,widget._casaFuera, widget._jornadaEquipo,estrella, widget._jugador.fechaNacimiento);
        jugadorJornadaColumna=new JugadorJornadaColumna(puntuaciones,
            widget._jornada, widget._jugador.jugador,widget._jugador.posicion,
            widget._jugador.equipo, 0,0,0,0,0,0);

        await  ProductManager().insertJugadorHojaJornadaEquipo(jugadorJornada);
        await  ProductManagerEXCELSCOUT().insertJugadorHojaJornadaEquipo(jugadorJornada);
        int fila=0;
        await ProductManager().filaById(jugadorJornadaColumna.id).then((value) {
          fila=value;
        });
        await ProductManagerEXCELSCOUT().filaById(jugadorJornadaColumna.id).then((value) {
          fila=value;
        });
        await ProductManager().insertJugadorHojaPuntuacionesJornada(jugadorJornadaColumna,fila);
        await ProductManagerEXCELSCOUT().insertJugadorHojaPuntuacionesJornada(jugadorJornadaColumna,fila);
  }


   _showAlert(BuildContext context)  {
    return showDialog(
        context: context,
        builder: (ctxt) => new AlertDialog(
          title: Text(
            "No hay la fecha o el Equipo",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            RaisedButton.icon(
              color: Config.colorAPP,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text(
                "Aceptar",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              icon: Icon(
                Icons.loop_outlined,
                color: Config.botones,
              ),
              textColor: Colors.white,
              splashColor: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
