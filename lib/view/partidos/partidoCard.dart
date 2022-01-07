
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

class PartidoCard extends StatefulWidget {
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
  _PartidoCardState createState() => new _PartidoCardState();
}

class _PartidoCardState extends State<PartidoCard> {


  @override
  void initState() {
    //_cogerPartidos();
  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        //print("${partido.equipoCASA}:${partido.equipoFUERA}:${partido.id}");
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => TabPuntuaciones(widget.temporada,widget.categoria,widget.pais,widget.partido,widget.jornada)));

        },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: Card(
          color: Config.colorCard,
          elevation: 5,
          child: Container(
            height: 133,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,height: 20,
                  color: Colors.blue.shade900,
                  child:Center(
                  child:Text(
                    'Scouter: ${widget.partido.observador}',
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
                        Config.escudoClubes(widget.partido.equipoCASA),
                        height: 35
                    ),
                    Text(
                        "${widget.partido.equipoCASA}",
                        style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    Text(
                        "${widget.partido.equipoFUERA}",
                        style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    Image.network(
                        Config.escudoClubes(widget.partido.equipoFUERA),
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
                            widget.partido.golesCASA!=""?"${widget.partido.golesCASA}":"-",
                            style: TextStyle(fontSize: 20, color: Colors.green.shade900,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text(
                            widget.partido.golesFUERA!=""?"${widget.partido.golesFUERA}":"-",
                            style: TextStyle(fontSize: 20, color: Colors.green.shade900,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                          Container(),

                      ]),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Text("Evaluado",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,

                        )),
                    Switch(
                      value: widget.partido.accion=="Evaluado"?true:false,
                      onChanged: (newValue) {
                        setState(() {
                          newValue==true?widget.partido.accion="Evaluado":widget.partido.accion="Sin evaluar";
                          CRUDPartido().updatePartidoAccion(widget.temporada,widget.pais,widget.categoria,widget.jornada,widget.partido);
                        });
                      },
                      activeTrackColor: Colors.green[900],
                      activeColor: Colors.green[900],
                    ),
                    new Text("Sin evaluar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,

                        )),
                    Switch(
                      value: widget.partido.accion=="Sin evaluar"?true:false,
                      onChanged: (newValue) {
                        setState(() {
                          newValue==true?widget.partido.accion="Sin evaluar":widget.partido.accion="Evaluado";
                          CRUDPartido().updatePartidoAccion(widget.temporada,widget.pais,widget.categoria,widget.jornada,widget.partido);
                        });
                      },
                      activeTrackColor: Colors.red[900],
                      activeColor: Colors.red[900],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                              height: 30,width: 100,
                              child: RaisedButton.icon(
                                elevation: 20,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditPartido(
                                        temporada: widget.temporada,
                                        pais: widget.pais,
                                        categoria: widget.categoria,
                                        partido: widget.partido,
                                        jornada: widget.jornada,
                                      )));
                                },
                                label: Text("Editar",
                                  style: TextStyle(color: Colors.black, fontSize: 11),),
                                icon: Icon(CustomIcon.marcador, size: 20, color: Colors.black,),
                                textColor: Colors.white,
                                hoverColor: Colors.black,
                                splashColor: Colors.blue,
                                color: Colors.white,)),Container(width: 5,)
                        ],
                      ),
                    ),
                  ],),


              ],
            ),
          ),
        ),
      ),
    );
  }

}
