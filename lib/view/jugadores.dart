import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iadvancedscout/conf/config.dart';

import 'package:iadvancedscout/dao/jugadorDao.dart';

import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/modelo/player.dart';

import 'package:iadvancedscout/my_flutter_app_icons.dart';

import 'package:iadvancedscout/pdf/pdfJugadorDatos.dart';
import 'package:iadvancedscout/pdf/pdfJugadorDatosAnt.dart';
import 'package:iadvancedscout/service/BBDDService.dart';

import 'package:iadvancedscout/view/addJugador.dart';
import 'package:iadvancedscout/view/caracteristicas/tabCaracteristicas.dart';

import 'package:iadvancedscout/view/editJugador.dart';

import 'package:iadvancedscout/view/paises.dart';
import 'package:iadvancedscout/view/temporadas.dart';

import 'package:iadvancedscout/wigdet/FireStorageService.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


import 'jugadoresList.dart';

class JugadoresPage extends StatefulWidget {
  const JugadoresPage(this._equipo);

  @override
  _JugadoresPageState createState() => _JugadoresPageState();
  final Equipo _equipo;
}

class _JugadoresPageState extends State<JugadoresPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "jugadores";
  List<Jugador> jugadoresList = <Jugador>[];

// no need of the file extension, the name will do fine.
  List<EquipoCloud> equipos=List();
  @override
  void setState(fn) {

    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }


  getMigrarJugadores()  async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;


    List<Player> lista = new List();
    print("getJugadores");
    for(var equiposBASEDATOS in equipos) {
        print("${equiposBASEDATOS.nombre}");
        String path2 =
            "temporadas/2021-2022/paises/ARGENTINA/categorias/1ª División Liga Argentina/equipos/${equiposBASEDATOS
            .nombre}/jugadores";
        print(path2);
        await FirebaseDatabase.instance.reference().child(
            path2).once().then((snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;
          //print(values.toString());
          values.forEach((k, v) {
            print("${v["jugador"]}:${equiposBASEDATOS.nombre}:${equiposBASEDATOS.key}");
            Jugador jugador = Jugador.fromJson(k, v);
            //print(jugador.jugador);
            //print(jugador.equipo);
            Player player=Player.fromJsonJugador(jugador);
            lista.add(player);
            _db.collection(""
                "/temporadas/BuJNv17ghCPGnq37P2ev/"
                "paises/FmUmyJV68ACrLHozX3oa/"
                "categorias/UtbfJN6CWzY0xnXzcMve/"
                "equipos/${equiposBASEDATOS.key}/jugadores")
                .add(player.toMap());
          });
        });
    }
    return lista;
  }

  cogerEquipos()async{
    equipos= await JugadorDao().getDataCollectionEquipos("UtbfJN6CWzY0xnXzcMve");

  }

  @override
  void initState() {
    cogerEquipos();


    nodeName = "temporadas/${BBDDService().getUserScout().temporada}/paises/${widget._equipo.pais}"
        "/categorias/${widget._equipo.categoria}/"
        "equipos/${widget._equipo.equipo}/jugadores";
    /*setState(() {
      getJugador();

    });*/
    _database.reference().child(nodeName).orderByChild("_dorsal").onChildAdded.listen(_childAdded);
    //  _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
     _database.reference().child(nodeName).orderByChild("_dorsal").onChildChanged.listen(_childChanged);
  }

  @override
  Widget build(BuildContext context) {
 //  cogerEquipos();
 //  getMigrarJugadores();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: new Image.asset(Config.icono),
            onPressed: () {
              //var a = singOut();
              //if (a != null) {
              Navigator.of(context).pop();

              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => TemporadasPage(),
              ));

              //}
            },
          )
        ],
        backgroundColor: Colors.black,
        title: Text("IAScout - Jugadores",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: jugadoresList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                color: Colors.black,
                padding: EdgeInsets.all(8.0),
                child:Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.network(Config.escudo(widget._equipo.equipo),
                              height:25),
                          Texto(Colors.white, "${widget._equipo.equipo}".toUpperCase(),
                              14, Colors.black, false)
                        ]))),


                Visibility(
                  visible: jugadoresList.isNotEmpty,
                  child: Flexible(
                      child: FirebaseAnimatedList(
                          query: _database.reference().child(nodeName),
                          itemBuilder: (query, DataSnapshot snap,
                              Animation<double> animation, int index) {
                            //print(snap.value);
                            itemCount: jugadoresList.length;
                            return index<jugadoresList.length?
                             Dismissible(
                               background: slideLeftBackground(),
                               //secondaryBackground: slideLeftBackground(),
                               key: jugadoresList[index]!=null?Key(jugadoresList[index].id):"",
                                 confirmDismiss: (DismissDirection dismissDirection) async {
                                   switch(dismissDirection) {
                                     case DismissDirection.endToStart:
                                       return await _showConfirmationDialog(context, 'Eliminar el jugador', jugadoresList[index]) == true;
                                    // case DismissDirection.startToEnd:
                                     //  return await _showConfirmationDialog(context, 'Cambiar el jugador',jugadoresList[index]) == true;
                                      case DismissDirection.horizontal:
                                     case DismissDirection.vertical:
                                     case DismissDirection.up:
                                     case DismissDirection.down:
                                       assert(false);
                                   }
                                   return false;
                                 },
                                onDismissed: (direction) {
                                  //_showAlert(context,jugadoresList[index]);
                                  // Remove the item from the data source.
                                  //print(direction);
                                      setState(() {
                                        JugadorDao con=JugadorDao();
                                        con.deleteJugadorIAScout(jugadoresList[index]);
                                        jugadoresList.removeAt(index);
                                      });

                                  /*if (direction == DismissDirection.startToEnd) {
                                    Navigator.of(context).pop();
                                          Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) => EditJugador(jugador: jugadoresList[index], equipo: widget._equipo,),
                                    ));


                                  }*/},
                                child:  ListTile(
                                      onTap: () {
                                        paginaJugador(
                                            context, jugadoresList[index]);
                                      },
                                      title: Row(children: [
                                        //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                        Text(
                                          jugadoresList[index]
                                              .jugador
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      trailing:
                                      FittedBox(
                                          fit: BoxFit.fill,
                                      child:Row(
                                          children: [
                                            IconButton(
                                                icon: new Icon(MyFlutterApp.file_pdf,size: 20,),
                                                color: Colors.red[900],
                                                onPressed: ()async{
                                                  pdfJugador(context, jugadoresList[index]);
                                                }),
                                        IconButton(
                                        icon: new Icon(MyFlutterApp.user_edit,size: 20,),
                                        color: Colors.black,
                                        onPressed: ()async{
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              EditJugador(jugador: jugadoresList[index], equipo: widget._equipo,)));
                                        }
                                        ),
                                      ])),

                                    subtitle: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                      //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                      Text(
                                      jugadoresList[index]
                                          .posicion
                                          .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                 Text(Config.edadSub(jugadoresList[index].fechaNacimiento),
                                   style: TextStyle(
                                       color: Config.edadColorSub(Config.edadSub(jugadoresList[index]
                                           .fechaNacimiento)),
                                       fontSize: 10.0,
                                       fontWeight: FontWeight.bold),
                                 )]),
                                  leading:CircleAvatar(
                                      backgroundColor: jugadoresList[index].getColor(),
                                    child:
                                    Text(jugadoresList[index].dorsal==-2?"*":jugadoresList[index].dorsal.toString(),
                                      style: TextStyle(
                                          color:Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),),
                                     //  Image.network("https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/dorsal%2F2.png?alt=media",
                                     //     height:25),
                                      //ExactAssetImage('assets/img/1.png',scale: 1)
                                  )
                                   // , backgroundImage:  ExactAssetImage('assets/img/jugador.png')

                                    ),
                            )
                            :Container();

                          })),
                )
            //dataBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Jugador jugador=new Jugador("", widget._equipo.equipo, widget._equipo.categoria, widget._equipo.pais, "","");
          jugador.posicionalternativa="";
          jugador.dorsal=0;
          jugador.lateral="";
          jugador.prestamo="no";
          //Jugador jugador = new Jugador();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>EditJugador(jugador:jugador,equipo: widget._equipo)));
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
  Future<bool> _showConfirmationDialog(BuildContext context, String action, Jugador jugador) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Quieres $action el jugador\n${jugador.jugador}?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true); // showDialog() returns true
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }

  Future _showAlert(BuildContext context, Jugador jugador) async {
    return showDialog(
        context: context,
        builder: (ctxt) => new AlertDialog(
          title: Text(
            "Puedes eliminar el jugador\n${jugador.jugador}",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            RaisedButton.icon(
              color: Config.colorAPP,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text(
                "Aceptar",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              icon: Icon(
                Icons.loop_outlined,
                color: Config.botones,
              ),
              textColor: Colors.white,
              splashColor: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton.icon(
              color: Config.colorAPP,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text(
                "Cancelar",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              icon: Icon(
                Icons.arrow_forward,
                color: Config.botones,
              ),
              textColor: Colors.white,
              splashColor: Colors.red,
              onPressed: () {
                 {
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }


  void paginaJugador(BuildContext context, Jugador jugador) {

      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TabCaracteristicas(jugador),
      ));

  }

  void pdfJugador(BuildContext context,Jugador jugador) {


      PdfJugadorDatosAnt pdf= PdfJugadorDatosAnt(jugador);
      pdf.generateInvoice();
    /*if (jugador.posicion.toUpperCase().contains("MEDIO CENTRO")) {
      PivoteCreatePdf pdf= PivoteCreatePdf(jugador);
      pdf.generateInvoice();
    } else if (jugador.posicion.toUpperCase().contains("LATERAL")) {
      LateralCreatePdf pdf= LateralCreatePdf(jugador);
      pdf.generateInvoice();
    } else if (jugador.posicion.toUpperCase().contains("EXTREMO")) {
      LateralCreatePdf pdf= LateralCreatePdf(jugador);
      pdf.generateInvoice();
    } else if (jugador.posicion.toUpperCase().contains("INTERIOR")) {
      VolanteCreatePdf pdf= VolanteCreatePdf(jugador);
      pdf.generateInvoice();
    } else if (jugador.posicion.toUpperCase().contains("PIVOTE")) {
      PivoteCreatePdf pdf= PivoteCreatePdf(jugador);
      pdf.generateInvoice();
    }else if (jugador.posicion.toUpperCase().contains("PUNTA")) {
      MediaPuntaCreatePdf pdf= MediaPuntaCreatePdf(jugador);
      pdf.generateInvoice();
    }else if (jugador.posicion.toUpperCase().contains("DELANTERO")) {
      DelanteroCreatePdf pdf= DelanteroCreatePdf(jugador);
      pdf.generateInvoice();
    }else if (jugador.posicion.toUpperCase().contains("VOLANTE")) {
      VolanteCreatePdf pdf= VolanteCreatePdf(jugador);
      pdf.generateInvoice();
    }else if (jugador.posicion.toUpperCase().contains("CARRILERO")) {
      LateralCreatePdf pdf= LateralCreatePdf(jugador);
      pdf.generateInvoice();
    }*/
  }

  _childAdded(Event event) {
    //print(event.snapshot.value);
    setState(() {
      jugadoresList.add(Jugador.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    //print("_childRemoves");
    var deletedPost = jugadoresList.singleWhere((post) {
      return post.pais == event.snapshot.key;
    });

    setState(() {
      jugadoresList.removeAt(jugadoresList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    //print("CHILDCHANGED");
    var changedPost = jugadoresList.singleWhere((jugador) {
      return jugador.id == event.snapshot.key;
    });

    setState(() {
      jugadoresList[jugadoresList.indexOf(changedPost)] =
          Jugador.fromSnapshot(event.snapshot);
    });
  }




  Future<Widget> _getImage(BuildContext context, String image) async {
    Image m;
    await FireStorageService.loadFromStorage(context, image).then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return m;
  }
  @override
  void dispose() {
    super.dispose();
  }


}
