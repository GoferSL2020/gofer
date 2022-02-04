import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/pdf/pdfJugadorDatosScout2.dart';
import 'package:iadvancedscout/view/jugadores/scouting/tabCaracteristicas.dart';
import 'package:iadvancedscout/view/temporadas.dart';


class JugadoresFiltroPage extends StatefulWidget {
   JugadoresFiltroPage(this._jugadorFiltro,this.categoria,this.temporada,this.pais);

  @override
  _JugadoresFiltroPageState createState() => _JugadoresFiltroPageState();
  final Player _jugadorFiltro;
   final Temporada temporada;
   final Categoria categoria;
   final Pais pais;
}

class _JugadoresFiltroPageState extends State<JugadoresFiltroPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "jugadores";
  List<Player> jugadoresList = <Player>[];
  Player _playerAux = new Player();


// no need of the file extension, the name will do fine.

  @override
  void initState() {
    setState(() {
      _cogerJugadores();
    });

    //  _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    // _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  _cogerJugadores() async {
    //print("PAIS");
    //print(_temporadaAux.id);
    List<Player> datos = await CRUDJugador().fetchJugadoresFiltro(widget._jugadorFiltro,widget.temporada,widget.pais,widget.categoria);
    setState(() {
      //print(datos[0].id);
      jugadoresList=datos;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              height: 20,
              width: double.infinity,
              color:Colors.black,
              child:Text(
                "${jugadoresList.length} Jugadores",
                textAlign: TextAlign.center,
                style: TextStyle(color: Config.colorAPP,
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
              ),),

            Visibility(
              visible: jugadoresList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      defaultChild:Center(child: CircularProgressIndicator()),
                      query: _database.reference().child(nodeName),
                      itemBuilder: (query,  DataSnapshot snap,
                          Animation<double> animation, int index) {
                        itemCount: jugadoresList.length;

                        return index<jugadoresList.length?
                        ListTile(
                            onTap: () {
                              paginaJugador(
                                  context, jugadoresList[index]);
                            },
                            title:
                            Column(children: [Row(children: [
                              //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                              Text(
                                jugadoresList[index]
                                    .jugador==null?"":
                                jugadoresList[index]
                                    .jugador
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(width: 5,),

                            ]),
                              Column(children: [

                                Row(children: [
                                  //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                  Text(
                                    jugadoresList[index]
                                        .posicion==null?"":
                                    jugadoresList[index]
                                        .posicion
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ],),

                            ]),
                            trailing:
                            IconButton(
                                icon: new Icon(MyFlutterApp.file_pdf,size: 20,),
                                color: Colors.red[900],
                                onPressed: ()async{
                                  pdfJugador(context, jugadoresList[index]);
                                }),
                            subtitle:
                            Column(children: [

                            Row(children: [
                              //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                              Text(Config.categoriaMin(
                                jugadoresList[index]
                                    .categoria),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(width: 20,),
                              Text(
                                jugadoresList[index].equipo==null?"":jugadoresList[index].equipo,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              )]),
                              Row(children: [
                                //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                Text(
                                    jugadoresList[index]
                                        .paisNacimiento,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                ]),
                              Row(children: [
                                //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                Text(
                                  Config.edadSub(jugadoresList[index]
                                      .fechaNacimiento),
                                  style: TextStyle(
                                      color: Config.edadColorSub(Config.edadSub(jugadoresList[index]
                                          .fechaNacimiento)),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                              Row(children: [
                                new Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: new BoxDecoration(
                                      color: Player.nivelColor(jugadoresList[index].nivel),
                                      shape: BoxShape.circle,
                                      border: Border.all(color:Colors.black, width: 1.0)
                                  ),),
                                new Container(
                                  width: 5.0,
                                ),
                                new Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: new BoxDecoration(
                                      color: Player.nivelColor(jugadoresList[index].nivel2),
                                      shape: BoxShape.circle,
                                      border: Border.all(color:Colors.black, width: 1.0)
                                  ),),
                                new Container(
                                  width: 5.0,
                                ),new Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: new BoxDecoration(
                                      color: Player.nivelColor(jugadoresList[index].nivel3),
                                      shape: BoxShape.circle,
                                      border: Border.all(color:Colors.black, width: 1.0)
                                  ),),
                                new Container(
                                  width: 5.0,
                                ),new Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: new BoxDecoration(
                                      color:Player.nivelColor(jugadoresList[index].nivel4),
                                      shape: BoxShape.circle,border: Border.all(color:Colors.black, width: 1.0)
                                  ),),
                                new Container(
                                  width: 5.0,
                                ),
                                new Container(
                                  padding: EdgeInsets.only(top:2,right: 5),
                                  child: Text(
                                    "Tipo:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal),
                                  ),),new Container(
                                  padding: EdgeInsets.only(top:1,right: 5),

                                  height: 15.0,
                                  child: Text(
                                    jugadoresList[index].tipoLetra(),
                                    style: TextStyle(
                                        color: Colors.blue.shade800,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),),

                              ],),
                              new Container(
                                height: 15.0,
                              )

                            ]),
                            leading:CircleAvatar(
                              backgroundColor: Colors.grey,
                              child:
                              Text(jugadoresList[index].dorsal.toString()=="99"?"*":jugadoresList[index].dorsal.toString(),
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),),
                            ),
                          // , backgroundImage:  ExactAssetImage('assets/img/jugador.png')

                        )
                            :Container();

                      })),
            )
            //dataBody(),
          ],
        ),
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



  void paginaJugador(BuildContext context, Player jugador) {
    Equipo equipo=new Equipo();
    equipo.id=jugador.idEquipo;
    Pais pais=new Pais();
    pais.id=jugador.idPais;
    Categoria categoria=new Categoria();
    categoria.id=jugador.idCategoria;
    Temporada temporada=new Temporada();
    temporada.id=jugador.idTemporada;
    print(equipo.id);
    print(categoria.id);
    print(temporada.id);
    print(pais.id);
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TabCaracteristicas(
            equipo,
            temporada,
            categoria,
            pais,
            jugador),
      ));

  }

   pdfJugador(BuildContext context, Player jugador)  {
    Fluttertoast.showToast(
        msg: "Espera...\nEstamos haciendo el \ndocumento del jugador:\n${jugador.jugador}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 40,
        backgroundColor: Colors.red.shade900,
        textColor: Colors.white,
        fontSize: 12.0);
    Equipo equipo=new Equipo();
    equipo.id=jugador.idEquipo;
    equipo.equipo=jugador.equipo;
    Pais pais=new Pais();
    pais.id=jugador.idPais;
    Categoria categoria=new Categoria();
    categoria.id=jugador.idCategoria;
    Temporada temporada=new Temporada();
    temporada.id=jugador.idTemporada;

    PdfJugadorDatosScout2 pdf= PdfJugadorDatosScout2(
      temporada,
      equipo,
      jugador,
      pais,
      categoria,
    );
    pdf.generateInvoice();
  }

  
  @override
  void dispose() {
    super.dispose();
  }
}
