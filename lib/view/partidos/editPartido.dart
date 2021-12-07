
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/modelo/categoria.dart';

import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';

import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/scout.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import '../../my_flutter_app_icons.dart';

class EditPartido extends StatefulWidget {
  final Partido partido;
  final Temporada temporada;
  final Pais pais;
  final Jornada jornada;
  final Categoria categoria;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


  EditPartido(
      {@required this.partido,
        @required this.categoria,
        @required this.pais,
        @required this.jornada,
        @required this.temporada});

  @override
  _EditPartidoState createState() => new _EditPartidoState();
}

class _EditPartidoState extends State<EditPartido> {
  final _golCasa = TextEditingController();
  final _golFuera = TextEditingController();


  final productProvider = new CRUDPartido();
  final dao2 = new CRUDCategoria();
  List<String> _observadores = List();
  List<Scout> _observadoresAUX = List();
  String _observador ="";

  String _accion="";
  List<String> _acciones = <String>[
    '',//45, 90
    'EVALUAR',//45, 90
    'SIN IMÁGENES',//45, 90
    'SIN VISUALIZAR',//40, 80
    'APLAZADO',//35 ,70
  ];

  String _golesCasa = "";
  String _golesFuera = "";
  List<String> _goles = <String>[
    '', //45, 90
    '0', //45, 90
    '1', //45, 90
    '2', //45, 90
    '3', //40, 80
    '4', //35 ,70
    '5', //35 ,70
    '6', //35 ,70
    '7', //35 ,70
    '8', //35 ,70
    '9', //35 ,70
    '10', //35 ,70
    '11', //35 ,70
  ];

  @override
  void initState() {
    cogerScouting();
    _accion=widget.partido.accion;
    _observador=widget.partido.observador;
    _golesFuera=widget.partido.golesFUERA.toString();
    _golesCasa=widget.partido.golesCASA.toString();

    // TODO: implement initState
    super.initState();
  }

  cogerScouting() async {
    _observadores.clear();
    _observadoresAUX =
    await dao2.fetchScouting(widget.temporada, widget.pais, widget.categoria);
    _observadores.add("");
    for (var d in _observadoresAUX) {
      setState(() {
        _observadores.add(d.scout);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FormField inputObservaciones = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Selecciona el scouter",
        ),
        isEmpty: _observador == '',
        child: new DropdownButtonFormField(
          items: _observadores.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          value: _observador,
          validator: (value) => value == null ? 'Poner el scouter' : null,
          isDense: true,
          onChanged: (value) {
            _observador=value;
            state.didChange(value);
          },
        ),
      );
    });

    FormField inputAccion= new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Selecciona la accion",
        ),
        isEmpty: _accion == '',
        child: new DropdownButtonFormField(
          items: _acciones.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          value: _accion,
          validator: (value) => value == null ? 'Poner la accion' : null,
          isDense: true,
          onChanged: (value) {
            _accion=value;
            state.didChange(value);
          },
        ),
      );
    });

    TextFormField inputGolCasa = TextFormField(
      controller: _golCasa,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
      ],
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 30, color: Colors.black),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );

    TextFormField inputGolFuera = TextFormField(
      controller: _golFuera,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30, color: Colors.black),

      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );
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
          title: Text("IAScout -Jornada",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBar: Abajo(temporada: widget.temporada,),
        body:
        Column(
          children: <Widget>[
          Container(
          height: 20,
          width: double.infinity,
          color:Colors.black,
          child:Text(
            widget.temporada.temporada,
            textAlign: TextAlign.center,
            style: TextStyle(color: Config.colorAPP,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),),
        Container(
          height: 20,
          width: double.infinity,
          color:Colors.black,
          child:Text(
            widget.categoria.categoria,
            textAlign: TextAlign.center,
            style: TextStyle(color: Config.colorAPP,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),),
        Container(
          height: 20,
          width: double.infinity,
          color:Colors.black,
          child:Text('Jornada: ${widget.jornada.jornada} - ${widget.jornada.fecha}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Config.colorAPP,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),),
            Container(
          child: Padding(
           padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 0),
            child: Column(
              children: <Widget>[
             new Table(
            columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(6),
            2: FlexColumnWidth(6),
              3: FlexColumnWidth(2),
            },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    Image.network(
                        Config.escudoClubes(widget.partido.equipoCASA),
                        height: 35
                    ),
                    Text(
                        "${widget.partido.equipoCASA}",
                        style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    Text(
                        "${widget.partido.equipoFUERA}",
                        style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    Image.network(
                        Config.escudoClubes(widget.partido.equipoFUERA),
                        // "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2F${equipoDetails.equipo}.png?alt=media",
                        height: 35
                    ),

                  ]),
                ]),
                Container(height: 20,),
                new Table(
                    columnWidths: {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(7),
                      2: FlexColumnWidth(6),
                      3: FlexColumnWidth(7),
                      4: FlexColumnWidth(3),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                         Container(),
                           Container(
                          height: 60,
                          padding: EdgeInsets.only(
                              top: 15, left: 25.0, right: 10.0),
                          decoration: BoxDecoration(

                              border: Border.all()),
                          //isEmpty: _equipo1 == null,
                          child: new DropdownButton(
                            icon: Icon(Icons.arrow_drop_down, size: 25,
                              color: Colors.black,),
                            value: _golesCasa,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,

                              fontWeight: FontWeight.normal,
                            ),
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _golesCasa = newValue;
                              });
                            },
                            items: _goles.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(),
                        Container(
                          height: 60,
                          padding: EdgeInsets.only(
                              top: 15, left: 25.0, right: 10.0),
                          decoration: BoxDecoration(

                              border: Border.all()),
                          //isEmpty: _equipo1 == null,
                          child: new DropdownButton(
                            icon: Icon(Icons.arrow_drop_down, size: 25,
                              color: Colors.black,),
                            value: _golesFuera,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,

                              fontWeight: FontWeight.normal,
                            ),
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _golesFuera = newValue;
                              });
                            },
                            items: _goles.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                          Container(),

                      ]),
                    ]),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10,bottom: 20),
                    child:inputObservaciones
                ),

                RaisedButton.icon(
                  onPressed: () {
                      CRUDPartido dao=new CRUDPartido();
                      try {
                        widget.partido.golesCASA = _golesCasa;
                        widget.partido.golesFUERA = _golesFuera;
                        widget.partido.observador = _observador;
                        widget.partido.fecha = widget.jornada.fecha;
                        widget.partido.jornada = widget.jornada.jornada;
                        dao.updatePartido(
                            widget.temporada, widget.pais, widget.categoria, widget.jornada, widget.partido);
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Se ha grabado",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green.shade900,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }catch(e){
                        Fluttertoast.showToast(
                            msg: "No se ha grabado",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red.shade900,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }
                  },
                  label: Text("Aceptar",
                    style: TextStyle(color: Colors.white,fontSize: 12),),
                  icon: Icon(Icons.save,size: 20, color:Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.black,
                  color: Colors.grey.shade700,),
              ],
            ),
      ),
    )
    ]));

  }


}
