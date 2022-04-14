import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/pdf/pdfJugadorDatosScout2.dart';
import 'package:iadvancedscout/view/jugadores/scouting/tabCaracteristicas.dart';
import 'package:iadvancedscout/view/temporadas.dart';


class JugadoresFiltroPage extends StatefulWidget {
   JugadoresFiltroPage(this._jugadorFiltro,this.categoria,this.temporada,this.pais, this.todos);

  @override
  _JugadoresFiltroPageState createState() => _JugadoresFiltroPageState();
  final Player _jugadorFiltro;
   final Temporada temporada;
   final Categoria categoria;
   final Pais pais;
   final bool todos;
}

class _JugadoresFiltroPageState extends State<JugadoresFiltroPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "jugadores";
  List<Player> jugadoresList = <Player>[];
  Player _playerAux = new Player();
  int _contarJUGADORES=0;

// no need of the file extension, the name will do fine.

  @override
  void initState() {
    super.initState();

    Fuente: https://www.iteramos.com/pregunta/88344/flutter-ejecutar-el-metodo-en-la-construccion-del-widget-completa
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {

      if(widget.todos==true) {
        SchedulerBinding.instance.addPostFrameCallback((_) =>
            _cogerJugadoresTodos(context));
      }else{
        SchedulerBinding.instance.addPostFrameCallback((_) =>
            _cogerJugadores(context));
      }

    }

    //Fuente: https://www.iteramos.com/pregunta/88344/flutter-ejecutar-el-metodo-en-la-construccion-del-widget-completa

    //  _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    // _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  _cogerJugadores(BuildContext context) async {
    //print("PAIS");
    //print(_temporadaAux.id);
    List<Player> datos = await CRUDJugador().fetchJugadoresFiltro(widget._jugadorFiltro,widget.temporada,widget.pais,widget.categoria);
    setState(() {
      //print(datos[0].id);
      jugadoresList=datos;
    });
  }

  _cogerJugadoresTodos(BuildContext context) async {
    //print("PAIS");
    //print(_temporadaAux.id);
    Partido partido=new Partido();
    partido.jornada=widget._jugadorFiltro.jornada;
    List<Player> datos = await CRUDJugador().fetchJugadoresOnce(widget._jugadorFiltro,widget.temporada,widget.pais,widget.categoria);
    setState(() {
        jugadoresList = datos;
    });
  }

  //Jugadores  Nombre del club
  Future<List<Player>> fetchJugadoresOnce(Player jugadorFiltro,Temporada temporada, Pais pais, Categoria categoria ) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> jugadoresDATA=[];
        jugadoresDATA.clear();
    Partido partido=new Partido();
    _contarJUGADORES=0;
    partido.jornada=jugadorFiltro.jornada;
    CRUDEquipo dao=CRUDEquipo();
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/jugadoresDATA
    print("temporadas/${temporada.id}/paises/${pais.id}/jugadoresDATA");
    var result = await _db.
    collection("temporadas/${temporada.id}/paises/${pais.id}/jugadoresDATA").
    orderBy("equipo").
    get().then((value){
      value.docs.forEach((element) {

        Player jug=Player.fromJson(element.id, element.data());
        bool puede=true;
        bool estrella=estrellaJornada(partido, jug);

          jugadoresDATA.add(jug);

      });
    });
    return jugadoresDATA;
  }


  bool estrellaJornada(Partido p, Player jug) {
    bool s=false;
    if(p.jornada==1) s=jug.estrella_jornada_1;
    if(p.jornada==2) s=jug.estrella_jornada_2;
    if(p.jornada==3) s=jug.estrella_jornada_3;
    if(p.jornada==4) s=jug.estrella_jornada_4;
    if(p.jornada==5) s=jug.estrella_jornada_5;
    if(p.jornada==6) s=jug.estrella_jornada_6;
    if(p.jornada==7) s=jug.estrella_jornada_7;
    if(p.jornada==8) s=jug.estrella_jornada_8;
    if(p.jornada==9) s=jug.estrella_jornada_9;
    if(p.jornada==10) s=jug.estrella_jornada_10;
    if(p.jornada==11) s=jug.estrella_jornada_11;
    if(p.jornada==12) s=jug.estrella_jornada_12;
    if(p.jornada==13) s=jug.estrella_jornada_13;
    if(p.jornada==14) s=jug.estrella_jornada_14;
    if(p.jornada==15) s=jug.estrella_jornada_15;
    if(p.jornada==16) s=jug.estrella_jornada_16;
    if(p.jornada==17) s=jug.estrella_jornada_17;
    if(p.jornada==18) s=jug.estrella_jornada_18;
    if(p.jornada==19) s=jug.estrella_jornada_19;
    if(p.jornada==20) s=jug.estrella_jornada_20;
    if(p.jornada==21) s=jug.estrella_jornada_21;
    if(p.jornada==22) s=jug.estrella_jornada_22;
    if(p.jornada==23) s=jug.estrella_jornada_23;
    if(p.jornada==24) s=jug.estrella_jornada_24;
    if(p.jornada==25) s=jug.estrella_jornada_25;
    if(p.jornada==26) s=jug.estrella_jornada_26;
    if(p.jornada==27) s=jug.estrella_jornada_27;
    if(p.jornada==28) s=jug.estrella_jornada_28;
    if(p.jornada==29) s=jug.estrella_jornada_29;
    if(p.jornada==30) s=jug.estrella_jornada_30;
    if(p.jornada==31) s=jug.estrella_jornada_31;
    if(p.jornada==32) s=jug.estrella_jornada_32;
    if(p.jornada==33) s=jug.estrella_jornada_33;
    if(p.jornada==34) s=jug.estrella_jornada_34;
    if(p.jornada==35) s=jug.estrella_jornada_35;
    if(p.jornada==36) s=jug.estrella_jornada_36;
    if(p.jornada==37) s=jug.estrella_jornada_37;
    if(p.jornada==38) s=jug.estrella_jornada_38;
    if(p.jornada==39) s=jug.estrella_jornada_39;
    if(p.jornada==40) s=jug.estrella_jornada_40;
    if(p.jornada==41) s=jug.estrella_jornada_41;
    if(p.jornada==42) s=jug.estrella_jornada_42;
    if(p.jornada==43) s=jug.estrella_jornada_43;
    if(p.jornada==44) s=jug.estrella_jornada_44;
    if(p.jornada==45) s=jug.estrella_jornada_45;
    if(p.jornada==46) s=jug.estrella_jornada_46;
    if(s==null)s=false;
    return s;
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
              child:Text("${jugadoresList.length} Jugadores ",
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
                             // paginaJugador(
                               //   context, jugadoresList[index]);
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
            jugador,false),
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
