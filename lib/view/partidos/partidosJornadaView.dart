import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDJornada.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/partidos/tabPuntuaciones.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';

class PartidosJornadaView extends StatefulWidget {
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;
  final Jornada jornada;
  final Equipo equipo;

  PartidosJornadaView({
    @required this.temporada,
    @required this.pais,
    @required this.categoria,
    @required this.jornada,
    @required this.equipo,
  });
  @override
  _PartidosJornadaViewState createState() => new _PartidosJornadaViewState();
}

class _PartidosJornadaViewState extends State<PartidosJornadaView> {
  CRUDEquipo dao = CRUDEquipo();


  @override
  void initState() {
    //_cogerPartidos();
  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }


  Future<List<Partido>> partidosJornada() async {
    var partidos = dao.getEquipoPartidos(
        widget.temporada, widget.pais, widget.categoria, widget.equipo);
    await new Future.delayed(new Duration(seconds: 2));
    return partidos;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
                width: 50,
                child: IconButton(
                  icon: new Image.asset(Config.icono),
                  onPressed: () {
                    //var a = singOut();
                    //if (a != null) {

                    //}
                  },
                ))
          ])
        ],
        backgroundColor: Colors.black,
        title: Text("IAScout -Partidos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: Abajo(
        temporada: widget.temporada,
      ),
      body: Column(children: <Widget>[
        Container(
          height: 20,
          width: double.infinity,
          color: Colors.black,
          child: Text(widget.temporada.temporada,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Config.colorAPP,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),
        ),
        Container(
          height: 20,
          width: double.infinity,
          color: Colors.black,
          child: Text(
            widget.categoria.categoria,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Config.colorAPP,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child:Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(Config.escudoClubes(widget.equipo.equipo),height: 25,),
           Text(
            '${widget.equipo.equipo}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Config.color,
              fontSize: 15,
              fontWeight: FontWeight.bold,),
            ),

          ]),
        ),
        
        
        Expanded(

          child: jornadasPartidos(),
        ),
      ]),
    );
  }



  Widget jornadasPartidos() {
    return FutureBuilder<List<Partido>>(
        future: partidosJornada(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
                child: Text(
              "Espere...",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ));
          }
          if (snapshot.hasError) {
            // return: show error widget
          }
          List<Partido> values = snapshot.data;
          values.sort((a, b) => a.jornada.compareTo(b.jornada));
           return ListView.builder(
              itemCount: values.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:

                  Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                          "Jornada ${values[index].jornada} (${values[index].fecha})",style:TextStyle(color:Config.colorCardLetra2,fontSize: 12),)),
                  subtitle:
                GestureDetector(
                onTap: () async{
                  /*CRUDJornada dao=CRUDJornada();
                  String key=await dao.getJornadaByNumero(widget.temporada,widget.pais,widget.categoria,values[index].jornada);
                  Jornada jornada=new Jornada(values[index].jornada, values[index].fecha);
                  jornada.id=key;
                 // print("${values[index].equipoCASA}:${values[index].equipoFUERA}:${values[index].id}");
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => TabPuntuaciones(widget.temporada,widget.categoria,widget.pais,values[index],jornada)));
*/
                },
                  //AD Ceuta:Villanovense:2DvtLnNubpkJkuE66mWE
                  //AD Ceuta:Villanovense:2DvtLnNubpkJkuE66mWE
                child:
                  Card(

                    color: Config.colorCard,
                    elevation: 5,
                    child:Column(children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: 2, top: 10, left: 2, bottom: 10),
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: new Table(
                          columnWidths: {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(9),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                            4: FlexColumnWidth(1),
                            5: FlexColumnWidth(9),
                            6: FlexColumnWidth(2),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(children: [
                              new Image.network(Config.escudoClubes(
                                  values[index].equipoCASA)),
                              Text("${values[index].equipoCASA}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                  textAlign: TextAlign.center),
                              Text("${values[index].golesCASA}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  textAlign: TextAlign.center),
                              Text("-",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                  textAlign: TextAlign.center),
                              Text("${values[index].golesFUERA}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  textAlign: TextAlign.center),
                              Text("${values[index].equipoFUERA}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                  textAlign: TextAlign.center),
                              new Image.network(Config.escudoClubes(
                                  values[index].equipoFUERA)),
                            ]),
                          ]),
                    ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.all(4.0),
                          width: 180,
                          height: 20,
                          child: Center(
                              child:
                              Text(values[index].accion,
                                  style: TextStyle(
                                      color: values[index].accion== "Evaluado" ? Colors.green.shade700 : values[index].accion== "Sin evaluar"?Colors.red.shade900:Colors.black,
                                      fontSize: 12,
                                  fontWeight: FontWeight.bold)))),


                      Container(height: 5,)
                    ]),
                  ),),
                );
              });
        });
  }
}
