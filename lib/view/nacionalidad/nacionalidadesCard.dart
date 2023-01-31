import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/dao/CRUDEquipoJugador.dart';

import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/my_flutter_app_icons.dart';
import 'package:iafootfeel/view/categoria/categoriasView.dart';
import 'package:iafootfeel/view/equipos/editEquipoJugador.dart';

class EquipoContrarioCard extends StatefulWidget {
  final EquipoJugador equipo;
  final Pais pais;
  EquipoContrarioCard({@required this.equipo,@required this.pais});

  @override
  _EquipoContrarioCardState createState() => new _EquipoContrarioCardState();
}

class _EquipoContrarioCardState extends State<EquipoContrarioCard> {



// no need of the file extension, the name will do fine.

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDEquipoJugador();

    return GestureDetector(
      onTap: (){


      },
      child: Padding(
        padding: EdgeInsets.only(left: 5,right: 5, top: 0,bottom: 0),
        child: Card(
          color: Config.colorCard,
          elevation: 5,
          child: Container(
            height: 150,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("${widget.equipo.equipo}",
                        style: TextStyle(
                            color: Config.colorCardLetra2,
                            fontSize: 14,
                            ),
                      ),

                      Text(
                        '${widget.equipo.pais}',
                        style: TextStyle(
                            fontSize: 14,
                            color: Config.colorCardLetra),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top:10),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: new Icon(
                          MyFlutterApp.pencil_alt, color: Config.colorCardLetra,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) =>
                              EditEquipoJugador(widget.equipo,widget.pais)));
                        },
                      ),
                      IconButton(
                          icon: Icon(MyFlutterApp.trash_alt,color: Colors.red,
                            size: 20,
                          ),
                          onPressed: () async {
                            await  _showConfirmationDialog(context,"Eliminar",widget.equipo) == true?
                            productProvider.removeEquipo(widget.pais,widget.equipo.id):"";
                            //pdfJugador(context, jugadoresList[index]);
                          }),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
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
            Text('Eliminar los datos del equipo (jugadores y partidos)',style: TextStyle(color: Colors.red, fontSize: 18,decoration: TextDecoration.underline,)),
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

