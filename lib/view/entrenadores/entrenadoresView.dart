import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDEntrenador.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/pdf/pdfEntrenadorDatos.dart';
import 'package:iadvancedscout/pdf/pdfJugadorDatos.dart';
import 'package:iadvancedscout/pdf/pdfJugadorDatosScout2.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/entrenadores/scouting/editEntrenador.dart';
import 'package:iadvancedscout/view/entrenadores/scouting/tabEntrenadores.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:url_launcher/url_launcher.dart';


class EntrenadoresView extends StatefulWidget {
  final Equipo equipo;
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;

  EntrenadoresView(
      {@required this.equipo,
      @required this.temporada,
      @required this.categoria,
      @required this.pais});

  @override
  _EntrenadoresViewState createState() => new _EntrenadoresViewState();
}

class _EntrenadoresViewState extends State<EntrenadoresView> {
  List<Entrenador> entrenadores;

  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDEntrenador();

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
        title: Text("IAScout - Entrenadores",
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
                stream: productProvider.getDataCollectionEntrenadores(
                    widget.temporada,
                    widget.equipo,
                    widget.pais,
                    widget.categoria),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    entrenadores = snapshot.data.docs
                        .map((doc) => Entrenador.fromJson(doc.id,doc.data()))
                        .toList();
                    return ListView.separated(
                        itemCount: entrenadores.length,
                        separatorBuilder: (context, index) {
                          return Container(height: 1,color: Colors.black,);
                        },
                        itemBuilder: (buildContext, index) {
                          return ListTile(
                              onTap: () {
                                paginaEntrenador(context, entrenadores[index]);
                              },
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start ,
                                  children: [
                                //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['entrenadores'].toString()}.png', height: 25.0, width: 25.0),
                                Expanded(
                                    child:
                                    Text(
                                  entrenadores[index].entrenador.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold),
                                )),
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
                                        onPressed: () {
                                          pdfEntrenador(context, entrenadores[index]);
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
                                                      EditEntrenador(
                                                        temporada: widget.temporada,
                                                        categoria: widget.categoria,
                                                        pais: widget.pais,
                                                        entrenador: entrenadores[index],
                                                        equipo: widget.equipo,
                                                      )));
                                        }),
                                  ])),
                              subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['entrenadores'].toString()}.png', height: 25.0, width: 25.0),
                                    Text("${entrenadores[index].nacionalidad} (${entrenadores[index].ccaa})",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Config.edadSub(
                                          entrenadores[index].fechaNacimiento),
                                      style: TextStyle(
                                          color: Config.edadColorSub(
                                              Config.edadSub(entrenadores[index]
                                                  .fechaNacimiento)),
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${entrenadores[index].activo}",
                                      style: TextStyle(
                                          color: entrenadores[index].activo=="Activo"?Colors.green.shade700:Colors.red,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child:
                                    Text("Fec.Fichaje: ${entrenadores[index].fechaFichaje}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child:
                                    Text("Fec.Fin contrato: ${entrenadores[index].fechaFinContrato}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child:
                                    GestureDetector(
                                        onTap: () {_sendingHTML(entrenadores[index].scout);},
                                        child: Image.network(
                                          Config.escudoImages("transfer.png"),
                                          fit: BoxFit.cover,height: 25,
                                        )
                                    ),),
                                  ]),
                              leading: Container(
                                width: 55.0,
                                height: 55.0,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 1.0, color: Colors.black),
                                  image: new DecorationImage(
                                    image:  NetworkImage(Config.imagenEntrenador(entrenadores[index])),
                                    fit: BoxFit.contain,scale: 1.5,

                                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Entrenador entrenador=new Entrenador();
          //Jugador jugador = new Jugador();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              EditEntrenador(
                temporada: widget.temporada,
                categoria: widget.categoria,
                pais: widget.pais,
                entrenador: entrenador,
                equipo: widget.equipo,
              )));
        },
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        tooltip: "Añadir un jugador",
      ),
    );
  }

  _sendingHTML(String url) async {
     if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  void paginaEntrenador(BuildContext context, Entrenador entrenador) {
    print(entrenador.key);
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => TabEntrenadores(widget.equipo,widget.temporada,widget.categoria,widget.pais,entrenador),
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
              " Cambiar el entrenadores",
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
              " Eliminar el entrenadores",
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


  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, Entrenador entrenador) {
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
              Text('¿Quieres $action el entrenadores\n${entrenador.entrenador}?'),
              Container(
                height: 10,
              ),
              Text('Eliminar los datos del entrenadores',
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

  void pdfEntrenador(BuildContext context, Entrenador entrenador) {
    Fluttertoast.showToast(
        msg: "Espera...\nEstamos haciendo el \ndocumento del entrenador:\n${entrenador.entrenador}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red.shade900,
        textColor: Colors.white,
        fontSize: 12.0);
    PdfEntrenadorDatos pdf =
    PdfEntrenadorDatos(widget.temporada, widget.equipo, entrenador);
    pdf.generateInvoice();
  }
}
