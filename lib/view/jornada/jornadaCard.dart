import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDJornada.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/filtro/destacadosJornada.dart';
import 'package:iadvancedscout/view/partidos/partidosView.dart';

class JornadaCard extends StatelessWidget {
  final Jornada jornada;
  final Temporada temporada;
  final Pais pais;
  final Categoria categoria;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


  JornadaCard(
      {@required this.jornada,
      @required this.categoria,
        @required this.pais,
      @required this.temporada});

  final dao = new CRUDJornada();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PartidosView(
                  temporada: temporada,
                  pais: pais,
                  categoria: categoria,
                  jornada:jornada
                )));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: Card(
          color: Config.colorCard,
          elevation: 5,
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 5, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                      child:
                        Text(
                          'Jornada: ${jornada.jornada.toString()}',
                        style: TextStyle(fontSize: 17, color: Config.colorCardLetra),
                      ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 30),
                        child:
                        Text(
                          '(${jornada.fecha})',
                          style: TextStyle(fontSize: 14, color: Config.colorCardLetra2),
                        ),
                      ),
                      /*IconButton(
                        icon: new Icon(
                          MyFlutterApp.pencil_alt,
                          color: Config.colorCardLetra,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditJornada(
                                    temporada: temporada,
                                    pais: pais,
                                    categoria: categoria,
                                    jornada: jornada,
                                  )));
                        },
                      ),
                      IconButton(
                          icon: Icon(Icons.restore_from_trash,
                              size: 25, color: Colors.red),
                          onPressed: () async {
                            //await  productProvider.update(temporada, equipo,jornada, jornada.id);
                            _showConfirmationDialog(context, "Eliminar", jornada);
                            //pdfJugador(context, jugadoresList[index]);
                          }),*/
                      IconButton(
                        icon: new Icon(
                          CustomIcon.medal,
                          color: Colors.orange,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DestacadosJornada(
                                    categoria,
                                    jornada,
                                    temporada,
                                    pais,
                                  )));
                        },
                      ),
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
      BuildContext context, String action, Jornada jornada) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('ATENCIÓN',style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,)),
          content:
              Column(children: [
                Container(height: 10,),
                Text('¿Quieres $action la jornada\n${jornada.jornada}?'),
                Container(height: 10,),
                Text('Eliminar los datos de la jornada y\nlos partidos',style: TextStyle(color: Colors.red, fontSize: 18,decoration: TextDecoration.underline,)),
                Container(height: 10,),
              ],),
          actions: <Widget>[
            FlatButton(
              child:  Text('Aceptar',style:TextStyle(fontSize: 16, color: Colors.green[900])),
              onPressed: () {

                Navigator.pop(context, true);
                true
                    ? dao.removeJornada(
                    temporada, categoria, pais, jornada)
                    : "";
                return true; // showDialog() returns true
              },
            ),
            FlatButton(
              child: Text('Cancelar',style:TextStyle(fontSize: 16, color: Config.colorAPP),),
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
