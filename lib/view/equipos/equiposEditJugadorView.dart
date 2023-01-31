import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/dao/CRUDEquipoJugador.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/service/BBDDService.dart';

import 'package:iafootfeel/view/categoria/categoriasView.dart';
import 'package:iafootfeel/view/equipos/editEquipoJugador.dart';
import 'package:iafootfeel/wigdet/abajo.dart';


class EquipoEditJugadorView extends StatefulWidget {

  final Pais _pais;
  final bool menu;

  EquipoEditJugadorView(this._pais,this.menu);
  @override
  _EquipoEditJugadorViewState createState() => new _EquipoEditJugadorViewState();
}

class _EquipoEditJugadorViewState extends State<EquipoEditJugadorView> {
  List<EquipoJugador> equipoJugador;
  
  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDEquipoJugador();
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 50,
                    child: IconButton(
                      icon: new Image.asset(Config.icono),
                      onPressed: () {
                      },
                    )),])
        ],
        backgroundColor: Colors.black,
        title: Text("FootFeel - Equipos",
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
      floatingActionButton: widget.menu==true?FloatingActionButton(
        //backgroundColor: widget.jugador.getColor(),
        onPressed: () {
          EquipoJugador equipo=new EquipoJugador();
          equipo.pais=widget._pais.pais;
          equipo.equipo="";

          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              EditEquipoJugador(
                  equipo,widget._pais)));
        },
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        tooltip: "Añadir un jugador",
      ):null,
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
                child:Text(
                 "Lista de equipos",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),),

             Expanded(
            child: StreamBuilder(
                stream: productProvider.getDataCollectionEquipos(widget._pais),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    equipoJugador = snapshot.data.docs
                        .map((doc) => EquipoJugador.fromMap(doc.data(), doc.id))
                        .toList();
                    return ListView.builder(
                        itemCount: equipoJugador.length,
                        itemBuilder: (buildContext, index) {
                          return
                            (BBDDService().getUserScout().tengoEquipo(equipoJugador[index].equipo))==true?
                            ListTile(focusColor: Colors.black,
                            onTap: () {
                              if(widget.menu==false)
                                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                  CategoriasView(pais:widget._pais,equipo:equipoJugador[index])));
                            },
                            title: Row(children: [
                              //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                              Expanded(
                                  child:Container
                                    (
                                      child:
                                  Text(
                                equipoJugador[index].equipo,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),

                              ))),
                            ]),
                              trailing: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                        icon: new Icon(
                                          CustomIcon.pencil_alt,
                                          size: 20,
                                        ),
                                        color: Colors.black,
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (buildContext) => EditEquipoJugador(equipoJugador[index],widget._pais)));
                                        }),

                                  ],
                                ),
                              ),
                            leading:
                            Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 1.0, color: Colors.white),

                                image: new DecorationImage(
                                  image:  NetworkImage(
                                    Config.escudoClubesFF(equipoJugador[index].equipo)),
                                  fit: BoxFit.contain,scale: 1,

                                ),
                              ),
                            ),):Container();
                        });
                  } else {
                    return Text('fetching');
                  }
                }),
          ),
            ]),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, EquipoJugador equipo) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('ATENCIÓN',style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,)),
          content:
          Column(children: [
            Container(height: 10,),
            Text('¿Quieres $action el equipo\n${equipo.equipo}?'),
            Container(height: 10,),
            Text('Eliminar el equipo',style: TextStyle(color: Colors.red, fontSize: 18,decoration: TextDecoration.underline,)),
            Container(height: 10,),
          ],),
          actions: <Widget>[
            FlatButton(
              child:  Text('Aceptar',style:TextStyle(fontSize: 16, color: Colors.green[900])),
              onPressed: () {
                Navigator.pop(context, true);
                return true; // showDialog() returns true
              },
            ),
            FlatButton(
              child: Text('Cancelar',style:TextStyle(fontSize: 16, color: Config.colorFootFeel),),
              onPressed: () {
                Navigator.pop(context, false);
                return false; // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }
}
