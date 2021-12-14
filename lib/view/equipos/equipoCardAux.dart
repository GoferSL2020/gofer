import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/futbol_mio_icons.dart';
import 'package:iadvancedscout/icon_mio_icons.dart';

import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/entrenadores/entrenadoresView.dart';
import 'package:iadvancedscout/view/equipos/editEquipo.dart';
import 'package:iadvancedscout/view/equipos/equiposOpcionesViewAux.dart';
import 'package:iadvancedscout/view/jugadores/jugadoresView.dart';
import 'package:iadvancedscout/view/partidos/partidosJornadaView.dart';


class EquipoCardAux extends StatefulWidget {
  final Equipo equipoDetails;
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;

  EquipoCardAux({@required this.equipoDetails,@required this.temporada,@required this.categoria,@required this.pais});

  @override
  _EquipoCardAuxState createState() => new _EquipoCardAuxState();
}

class _EquipoCardAuxState extends State<EquipoCardAux> {

  var empate=0;
  var ganado=0;
  var perdido=0;
  var jugo=true;

  Future getGanados() async {
    final productProvider = new CRUDEquipo();
    var empateAux=0;
    var ganadoAux=0;
    var perdidoAux=0;
    await productProvider.empateContar(widget.temporada, widget.equipoDetails).then((value){
      empateAux= value.docs.length;

    });
    await productProvider.ganadoContar(widget.temporada, widget.equipoDetails).then((value){
      ganadoAux= value.docs.length;
    });
    await productProvider.perdidoContar(widget.temporada, widget.equipoDetails).then((value){
      perdidoAux= value.docs.length;
    });

    setState(() {
      empate= empateAux==null?0:empateAux;
      ganado= ganadoAux==null?0:ganadoAux;
      perdido= perdidoAux==null?0:perdidoAux;
      jugo=empate+ganado+perdido!=0?true:false;

    });
  }

  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
// no need of the file extension, the name will do fine.

  @override
  void initState() {
    getGanados();

  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDEquipo();

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            JugadoresView(temporada: widget.temporada, equipo: widget.equipoDetails,categoria: widget.categoria, pais:widget.pais)));

      },
      child: Padding(
        padding: EdgeInsets.only(left: 5,right: 5, top: 0,bottom: 0),
        child: Card(
          color: Config.colorCard,
          elevation: 5,
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start ,
                    children: <Widget>[
                      new  Image.network(
                        Config.escudoClubes(widget.equipoDetails.equipo),
                       // "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2F${widget.equipoDetails.equipo}.png?alt=media",
                        height: 35
                      ),
                      Expanded(
                          flex:3,
                          child:
                          Container(padding: EdgeInsets.all(10),
                            child:Text("${widget.equipoDetails.equipo}",
                              style: TextStyle(
                                color: Config.colorCardLetra, fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),),
                          )
                      ),
                      SizedBox.fromSize(
                        size: Size(50, 50), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.grey.shade700,// button color
                            child: InkWell(
                              splashColor: Colors.blue, // splash color
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                    PartidosJornadaView(temporada: widget.temporada,
                                      equipo: widget.equipoDetails,categoria:
                                      widget.categoria, pais:widget.pais,)));
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(CustomIcon.marcador,size: 23, color: Colors.white,), // icon
                                  //Text("Res.",style: TextStyle(color:Colors.white,fontSize: 10,fontWeight: FontWeight.bold),), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),Container(width: 5,),
                      SizedBox.fromSize(
                        size: Size(50, 50), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.grey.shade800, // button color
                            child: InkWell(
                              splashColor: Colors.blue, // // splash color
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                    EntrenadoresView(temporada: widget.temporada,
                                      equipo: widget.equipoDetails,categoria:
                                      widget.categoria, pais:widget.pais,)));
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(FutbolMio.entrenador_1,size: 25, color: Colors.white,), // icon
                                  //Text("",style: TextStyle(color:Colors.white,fontSize: 10,fontWeight: FontWeight.bold),), // text
                                ],
                              ),
                            ),
                          ),
                        ),
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
  List<Partido> partidoAUX;

   cogerPartidos()  async {
    CRUDEquipo dao=CRUDEquipo();
    partidoAUX= await dao.getEquipoPartidos(widget.temporada,widget.pais,widget.categoria,widget.equipoDetails);

  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, Equipo equipo) {
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

