
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/modelo/categoria.dart';

import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';

import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/partidos/editPartido.dart';
import 'package:iadvancedscout/view/partidos/tabPuntuaciones.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import '../../my_flutter_app_icons.dart';

class PartidoCard extends StatelessWidget {
  final Partido partido;
  final Temporada temporada;
  final Pais pais;
  final Jornada jornada;
  final Categoria categoria;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


  PartidoCard(
      {@required this.partido,
        @required this.categoria,
        @required this.pais,
        @required this.jornada,
        @required this.temporada});

  final productProvider = new CRUDPartido();

  @override
  Widget build(BuildContext context) {

    Color resultadoColor = Config.colorAPP;
    if (partido.resultado == "GANADO")
      resultadoColor = Colors.green;
    else if (partido.resultado == "EMPATE")
      resultadoColor = Colors.blue[900];
    else
      resultadoColor = Colors.red;
    return GestureDetector(
      onTap: () {
        //print("${partido.equipoCASA}:${partido.equipoFUERA}:${partido.id}");
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => TabPuntuaciones(temporada,categoria,pais,partido,jornada)));

        },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: Card(
          color: Config.colorCard,
          elevation: 5,
          child: Container(
            height: 130,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,height: 20,
                  color: Colors.blue.shade900,
                  child:Center(
                  child:Text(
                    'Scouter: ${partido.observador}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.white),
                  )),
                ),
             Container(height: 5,),
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
                        Config.escudoClubes(partido.equipoCASA),
                        // "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2F${widget.equipoDetails.equipo}.png?alt=media",
                        height: 35
                    ),
                    Text(
                        "${partido.equipoCASA}",
                        style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    Text(
                        "${partido.equipoFUERA}",
                        style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    Image.network(
                        Config.escudoClubes(partido.equipoFUERA),
                        // "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2F${widget.equipoDetails.equipo}.png?alt=media",
                        height: 35
                    ),

                  ]),
                ]),
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
                         Container(),
                        Text(
                            partido.golesCASA!=""?"${partido.golesCASA}":"-",
                            style: TextStyle(fontSize: 20, color: Colors.green.shade900,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text(
                            partido.golesFUERA!=""?"${partido.golesFUERA}":"-",
                            style: TextStyle(fontSize: 20, color: Colors.green.shade900,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                          Container(),

                      ]),
                    ]),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
            SizedBox(
                height: 30,width: 100,
                child: RaisedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditPartido(
                      temporada: temporada,
                      pais: pais,
                      categoria: categoria,
                      partido: partido,
                      jornada: jornada,
                    )));
              },
              label: Text("Editar",
                style: TextStyle(color: Colors.black, fontSize: 11),),
              icon: Icon(CustomIcon.marcador, size: 20, color: Colors.black,),
              textColor: Colors.white,
              splashColor: Colors.blue,
              color: Colors.white,)),Container(width: 5,)
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

  _displaySnackBar(BuildContext context,String frase) {
    final snackBar = SnackBar(
        content: Container(
            height: 100,
            width: 350,
            color: Colors.red[900],
            child: Center(child: Text("No está la ${frase}", style: TextStyle(fontSize: 30)))),
        duration: Duration(seconds: 2));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, Temporada temporada,Pais pais,Categoria categoria,Jornada jornada,Partido partido) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('ATENCIÓN',style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,)),
          content:
              Column(children: [
                Container(height: 10,),
                Text('¿Quieres $action el partido?'),
                Container(height: 10,),
                Text('Eliminar los datos del partido',style: TextStyle(color: Colors.red, fontSize: 18,decoration: TextDecoration.underline,)),
                Container(height: 10,),
              ],),
          actions: <Widget>[
            FlatButton(
              child:  Text('Aceptar',style:TextStyle(fontSize: 12, color: Colors.green[900])),
              onPressed: () {
                Navigator.pop(context, true);
                true
                    ? productProvider.removePartido(temporada,pais,categoria,jornada,partido)
                    : "";
                return true; // showDialog() returns true
              },
            ),
            FlatButton(
              child: Text('Cancelar',style:TextStyle(fontSize: 12, color: Config.colorAPP),),
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
