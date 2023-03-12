import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/dao/CRUDEquipoJugador.dart';
import 'package:iafootfeel/dao/CRUDScout.dart';
import 'package:iafootfeel/icon_mio_icons.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/modelo/userScout.dart';

import 'package:iafootfeel/view/categoria/categoriasView.dart';
import 'package:iafootfeel/view/equipos/editEquipoJugador.dart';
import 'package:iafootfeel/view/jugadores/jugadoresView.dart';
import 'package:iafootfeel/wigdet/abajo.dart';

class ScoutEquiposView extends StatefulWidget {
  final UserScout _scout;

  ScoutEquiposView(this._scout);
  @override
  _ScoutEquiposViewState createState() => new _ScoutEquiposViewState();
}

class _ScoutEquiposViewState extends State<ScoutEquiposView> {
  List<EquipoJugador> _equipoJugador=[];
  List<EquipoJugador> _equipoJugadorScout=[];


  _cogerEquipos() async {
    List<EquipoJugador> datosTodos = [];
    List<EquipoJugador> datosScout = [];
    //todos los equipos
    datosScout = await CRUDUserScout().fetchEquiposTieneScout(widget._scout.id);
    datosTodos = await CRUDUserScout().fetchEquiposPaisesScout();
    print("LO TIENE: ${datosTodos.length}");
    //cojo los equipos de agentes
    print("LO TIENE SCOUT: ${datosScout.length}");
    setState(() {
      _equipoJugador = datosTodos;
      _equipoJugadorScout=datosScout;
      for(var datoT in _equipoJugador){
        for (var datoS in _equipoJugadorScout) {
          print("LO TIENE: ${datoT.equipo}");
          print("EQUIPO: ${datoS.equipo}");
          if (datoT.equipo==datoS.equipo) {
            datoT.lotiene = true;
          }
        }
      }
      _equipoJugador.sort((a,b)=>a.equipo.compareTo(b.equipo));
    });



  }
  @override
  void initState() {
    setState(() {
      _cogerEquipos();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDEquipoJugador();
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
                width: 50,
                child: IconButton(
                  icon: new Image.asset(Config.icono),
                  onPressed: () {},
                )),
          ])
        ],
        backgroundColor: Colors.black,
        title: Text("FootFeel - ${widget._scout.name}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Config.colorFootFeel,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        //backgroundColor: widget.jugador.getColor(),
        backgroundColor: Colors.blue.shade900,
        child: const Icon(CustomIcon.save),
        onPressed: () {
            _showGrabar(context);

        },
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

              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.black,
            child: Text(
              "Lista de equipos",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),

          Visibility(
              visible: _equipoJugador.isNotEmpty,
              child: Flexible(
                child: ListView.builder(
                    itemCount: _equipoJugador.length,
                    itemBuilder: (buildContext, index) {
                      return ListTile(
                        onTap: () {

                        },
                        focusColor: Colors.black,
                        title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                          Container(
                                  child: Text(
                            _equipoJugador[index].equipo,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          )),
                          Container(
                              child: Text(
                                _equipoJugador[index].equipo,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              )),
                        ]),
                        leading: Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(width: 1.0, color: Colors.white),
                            image: new DecorationImage(
                              image: NetworkImage(Config.escudoClubesFF(
                                  _equipoJugador[index].equipo)),
                              fit: BoxFit.contain,
                              scale: 1,
                            ),
                          ),
                        ),
                          trailing:  Container(
                            padding: EdgeInsets.all(0.0),
                            child: Column(
                              children: <Widget>[
                                new Checkbox(value: _equipoJugador[index].lotiene,
                                    activeColor: Colors.green,
                                    onChanged:(bool? newValue){
                                      setState(() {
                                        _equipoJugador[index].lotiene = newValue!;
                                      });
                                    }),
                              ],
                            ),
                          ),

                      );
                    }),
              )),
        ]),
      ),
    );
  }

  Future<void> _showGrabar(BuildContext context)  {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return  CupertinoAlertDialog(
          title: Text('ATENCIÓN',
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
              )),
          content: Column(
            children: [
              Container(
                height: 10,
              ),
              Text(
                '¿Quieres grabar los equipos?',
              ),
              Container(
                height: 10,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar',
                  style: TextStyle(fontSize: 16, color: Colors.green.shade900)),
              onPressed: ()  async {
                Navigator.pop(context, true);
                CRUDUserScout con = CRUDUserScout();
                //widget.jugador.firmado=true;
                  await con.grabarEquipos(_equipoJugador,widget._scout);
                // showDialog() returns true
              },
            ),
            TextButton(
              child: Text('Cancelar',
                  style: TextStyle(fontSize: 16, color: Colors.green.shade900)),
              onPressed: () {
                Navigator.pop(context, false);// showDialog() returns true
              },
            )
          ],
        );
      },
    );

  }

}
