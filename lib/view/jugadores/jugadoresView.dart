import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/pdf/pdfJugadorDatos.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/jugadores/scouting/editJugador.dart';
import 'package:iadvancedscout/view/jugadores/scouting/tabCaracteristicas.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';

class JugadoresView extends StatefulWidget {
  final Equipo equipo;
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;

  JugadoresView(
      {@required this.equipo,
      @required this.temporada,
      @required this.categoria,
      @required this.pais});

  @override
  _JugadoresViewState createState() => new _JugadoresViewState();
}

class _JugadoresViewState extends State<JugadoresView> {
  List<Player> jugador;

  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDJugador();

    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Container(
              width: 50,
              child: IconButton(
                icon: new Image.network(
                  Config.escudoClubes(widget.equipo.equipo),
                ),
                onPressed: () {
                  //var a = singOut();
                  //if (a != null) {

                  //}
                },
              )),
        ],
        backgroundColor: Colors.black,
        title: Text("IAClub - Jugadores",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: Abajo(
        temporada: widget.temporada,
      ),
      body: Container(
        child: Column(children: <Widget>[
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
            width: double.infinity,
            height: 20,
            color: Colors.black,
            child: Text(
              widget.equipo.equipo,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Config.colorAPP,
                  fontSize: 12,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: productProvider.getDataCollectionJugadores(
                    widget.temporada,
                    widget.equipo,
                    widget.pais,
                    widget.categoria),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    jugador = snapshot.data.docs
                        .map((doc) => Player.fromJson(doc.id,doc.data()))
                        .toList();
                    return ListView.builder(
                        itemCount: jugador.length,
                        itemBuilder: (buildContext, index) {
                          return ListTile(
                              onTap: () {
                                paginaJugador(context, jugador[index]);
                              },
                              title: Row(children: [
                                //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                Text(
                                  jugador[index].jugador.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                              trailing: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Row(children: [
                                    IconButton(
                                        icon: new Icon(
                                          CustomIcon.file_pdf,
                                          size: 20,
                                        ),
                                        color: Colors.red[900],
                                        onPressed: () async {
                                          pdfJugador(context, jugador[index]);
                                        }),
                                    IconButton(
                                        icon: new Icon(
                                          MyFlutterApp.user_edit,
                                          size: 20,
                                        ),
                                        color: Colors.black,
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      EditJugador(
                                                        jugador: jugador[index],
                                                        equipo: widget.equipo,
                                                      )));
                                        }),
                                  ])),
                              subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                    Text(
                                      jugador[index].posicion.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Config.edadSub(
                                          jugador[index].fechaNacimiento),
                                      style: TextStyle(
                                          color: Config.edadColorSub(
                                              Config.edadSub(jugador[index]
                                                  .fechaNacimiento)),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                               /*     Text(
                                          jugador[index].key,
                                      style: TextStyle(
                                          color: Config.edadColorSub(
                                              Config.edadSub(jugador[index]
                                                  .fechaNacimiento)),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    )*/
                                  ]),
                              leading: CircleAvatar(
                                backgroundColor: jugador[index].getColor(),
                                child: Text(
                                  jugador[index].dorsal == -2
                                      ? "*"
                                      : jugador[index].dorsal.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ));
                        });
                  } else {
                    return Text('fetching');
                  }
                }),
          )
        ]),
      ),
      /*  floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Jugador jugador = new Jugador();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => EditJugador(
                      jugador: jugador,
                      temporada: widget.temporada,
                      equipo: widget.equipo)));
        },
      ),*/
    );
  }

  void paginaJugador(BuildContext context, Player jugador) {
    print("VOUYYYY");
    print(jugador.key);
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => TabCaracteristicas(widget.equipo,widget.temporada,widget.categoria,widget.pais,jugador),
    ));

  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green[900],
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Cambiar el jugador",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red[900],
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Eliminar el jugador",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  void pdfJugador(BuildContext context, Player jugador) {
    print(jugador.nacionalidad);
    PdfJugadorDatos pdf =
        PdfJugadorDatos(widget.temporada, widget.equipo, jugador);
    pdf.generateInvoice();
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, Player jugador) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
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
              Text('¿Quieres $action el jugador\n${jugador.jugador}?'),
              Container(
                height: 10,
              ),
              Text('Eliminar los datos del jugador',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                  )),
              Container(
                height: 10,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar',
                  style: TextStyle(fontSize: 16, color: Colors.green[900])),
              onPressed: () {
                Navigator.pop(context, true);
                return true; // showDialog() returns true
              },
            ),
            FlatButton(
              child: Text(
                'Cancelar',
                style: TextStyle(fontSize: 16, color: Config.colorAPP),
              ),
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
