import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/pdf/pdfJugadorDatosAnt.dart';
import 'package:iadvancedscout/view/caracteristicas/tabCaracteristicas.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

class JugadoresFiltroPage extends StatefulWidget {
   JugadoresFiltroPage(this._jugadorFiltro);

  @override
  _JugadoresFiltroPageState createState() => _JugadoresFiltroPageState();
  final Jugador _jugadorFiltro;
}

class _JugadoresFiltroPageState extends State<JugadoresFiltroPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "jugadores";
  List<Jugador> jugadoresList = <Jugador>[];

// no need of the file extension, the name will do fine.

  @override
  void initState() {

        String temporada=widget._jugadorFiltro.temporada=="2020-2021"?"":widget._jugadorFiltro.temporada;
       nodeName =
      "jugadores${temporada}";
      _database
        .reference()
        .child(nodeName).orderByChild("jugador")
        .onChildAdded
        .listen(_childAdded);

    //  _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    // _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
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
            /*Visibility(
              visible: jugadoresList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),*/
            Container(
                alignment: Alignment.center,
                color: Colors.black,
                padding: EdgeInsets.all(8.0),
                child:Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Texto(Colors.white, "${widget._jugadorFiltro.posicion==null?"":widget._jugadorFiltro.posicion}",
                              14, Colors.black, false)
                        ]))),


            Visibility(
              visible: jugadoresList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.reference().child(nodeName),
                      itemBuilder: (query, DataSnapshot snap,
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
                                ])

                            ]),
                            leading:CircleAvatar(
                              backgroundColor: jugadoresList[index].getColor(),
                              child:
                              Text(jugadoresList[index].dorsal.toString()=="-2"?"*":jugadoresList[index].dorsal.toString(),
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


  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        headingRowHeight: 0,
        dataRowHeight: 55,
        columns: [
          DataColumn(label: Text('')),
          DataColumn(label: Text('')),
          DataColumn(label: Text('')),
          //DataColumn(label: Text('Action')),
        ],
        rows:
            jugadoresList // Loops through dataColumnText, each iteration assigning the value to element
                .map(
                  ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(
                            new Image.asset(
                                'assets/${element.equipo}/${element.jugador}.png',
                                height: 25.0,
                                width: 25.0),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.all(2.0),
                              child: FlatButton(
                                  onPressed: () {
                                    paginaJugador(context, element);
                                  },
                                  child: Text(element.jugador)),
                            ),
                          ),
                          DataCell(
                            new Text(
                              element.posicion.toString(),
                              style: TextStyle(

                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )),
                )
                .toList(),
      ),
    );
  }



  void paginaJugador(BuildContext context, Jugador jugador) {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TabCaracteristicas(jugador),
      ));

  }

  void pdfJugador(BuildContext context, Jugador jugador) {
      PdfJugadorDatosAnt pdf= PdfJugadorDatosAnt(jugador);
      pdf.generateInvoice();

  }

  _childAdded(Event event) {
    int edad;
    String edadStr=Config.edad(event.snapshot.value['fechaNacimiento']);
    edad=edadStr=="Sin fecha"?0:int.parse(edadStr);
     setState(() {
      if
      (

      (widget._jugadorFiltro.posicion.toString().trim()=="TODOS"?true:
      (event.snapshot.value['posicion'].toString().toUpperCase().trim().contains(
          widget._jugadorFiltro.posicion.toString().trim().toUpperCase()))
      )

            &&
            (widget._jugadorFiltro.categoria.toString().trim()==""?true:
            (event.snapshot.value['categoria'].toString().toUpperCase().trim().contains(
                widget._jugadorFiltro.categoria.toString().trim().toUpperCase()))
            )
          &&
          (widget._jugadorFiltro.jugador.toString().trim()==""?true:
          (event.snapshot.value['jugador'].toString().toUpperCase().trim().contains(
              widget._jugadorFiltro.jugador.toString().trim().toUpperCase()))
          )
          &&
          (widget._jugadorFiltro.paisNacimiento.toString().trim()==""?true:
          (event.snapshot.value['_paisNacimiento'].toString().toUpperCase().trim().contains(
              widget._jugadorFiltro.paisNacimiento.toString().trim().toUpperCase()))
          )
          &&
          ((edad>=widget._jugadorFiltro.edadRange1)&&(edad<=widget._jugadorFiltro.edadRange2))
            &&
            (widget._jugadorFiltro.nivel.toString().trim()==""?true:
            (event.snapshot.value['nivel'].toString().toUpperCase().trim().contains(
                widget._jugadorFiltro.nivel.toString().trim().toUpperCase()))
            )
          &&
          (widget._jugadorFiltro.nivel2.toString().trim()==""?true:
          (event.snapshot.value['nivel2'].toString().toUpperCase().trim().contains(
              widget._jugadorFiltro.nivel2.toString().trim().toUpperCase()))
          )
          &&
          (widget._jugadorFiltro.nivel3.toString().trim()==""?true:
          (event.snapshot.value['nivel3'].toString().toUpperCase().trim().contains(
              widget._jugadorFiltro.nivel3.toString().trim().toUpperCase()))
          )
          &&
          (widget._jugadorFiltro.nivel4.toString().trim()==""?true:
          (event.snapshot.value['nivel4'].toString().toUpperCase().trim().contains(
              widget._jugadorFiltro.nivel4.toString().trim().toUpperCase()))
          )
            &&
            (widget._jugadorFiltro.tipo.toString().trim()==""?true:
            (event.snapshot.value['tipo'].toString().toUpperCase().trim().contains(
                widget._jugadorFiltro.tipo.toString().trim().toUpperCase()))
              )
            &&

            (widget._jugadorFiltro.fis_velocidaddereaccion==true?
      (event.snapshot.value['_fis_velocidaddereaccion'] ==
      widget._jugadorFiltro.fis_velocidaddereaccion):true
      &&

      widget._jugadorFiltro.fis_velocidaddedesplazamiento==true?
      (event.snapshot.value['_fis_velocidaddedesplazamiento'] ==
      widget._jugadorFiltro.fis_velocidaddedesplazamiento):true
      &&

      widget._jugadorFiltro.fis_agilidad==true?
      (event.snapshot.value['_fis_agilidad'] ==
      widget._jugadorFiltro.fis_agilidad):true &&

      widget._jugadorFiltro.fis_fuerza_potencia==true?
      (event.snapshot.value['_fis_fuerza_potencia'] ==
      widget._jugadorFiltro.fis_fuerza_potencia):true &&

      widget._jugadorFiltro.fis_cuerpoacuerpo==true?
      (event.snapshot.value['_fis_cuerpoacuerpo'] ==
      widget._jugadorFiltro.fis_cuerpoacuerpo):true &&

      widget._jugadorFiltro.fis_capacidaddesalto==true?
      (event.snapshot.value['_fis_capacidaddesalto'] ==
      widget._jugadorFiltro.fis_capacidaddesalto):true &&

      widget._jugadorFiltro.fis_explosividad==true?
      (event.snapshot.value['_fis_explosividad'] ==
      widget._jugadorFiltro.fis_explosividad):true &&

      widget._jugadorFiltro.fis_potenciadesaltolateralyvertical==true?
      (event.snapshot.value['_fis_potenciadesaltolateralyvertical'] ==
      widget._jugadorFiltro.fis_potenciadesaltolateralyvertical):true
      &&

      widget._jugadorFiltro.fis_resistencia_idayvuelta==true?
      (event.snapshot.value['_fis_resistencia_idayvuelta'] ==
      widget._jugadorFiltro.fis_resistencia_idayvuelta):true &&

      widget._jugadorFiltro.fis_cambioderitmo==true?
      (event.snapshot.value['_fis_cambioderitmo'] ==
      widget._jugadorFiltro.fis_cambioderitmo):true &&
         widget._jugadorFiltro.ofe_niveltecnico==true?
          (event.snapshot.value['_ofe_niveltecnico'] ==
          widget._jugadorFiltro.ofe_niveltecnico):true &&

          widget._jugadorFiltro.ofe_profundidad==true?
          (event.snapshot.value['_ofe_profundidad'] ==
              widget._jugadorFiltro.ofe_profundidad):true &&

          widget._jugadorFiltro.ofe_capacidaddegenerarbuenoscentrosalarea==true?
          (event.snapshot.value['_ofe_capacidaddegenerarbuenoscentrosalarea'] ==
          widget._jugadorFiltro.ofe_capacidaddegenerarbuenoscentrosalarea):true &&

          widget._jugadorFiltro.ofe_capacidaddeasociacion==true?
          (event.snapshot.value['_ofe_capacidaddeasociacion'] ==
          widget._jugadorFiltro.ofe_capacidaddeasociacion):true &&

          widget._jugadorFiltro.ofe_desborde==true?
          (event.snapshot.value['_ofe_desborde'] ==
          widget._jugadorFiltro.ofe_desborde):true &&

          widget._jugadorFiltro.ofe_superioridadpordentro==true?
          (event.snapshot.value['_ofe_superioridadpordentro'] ==
          widget._jugadorFiltro.ofe_superioridadpordentro):true &&

          widget._jugadorFiltro.ofe_finalizacion==true?
          (event.snapshot.value['_ofe_finalizacion'] ==
          widget._jugadorFiltro.ofe_finalizacion):true &&

          widget._jugadorFiltro.ofe_saquedebanda_longitud==true?
          (event.snapshot.value['_ofe_saquedebanda_longitud'] ==
              widget._jugadorFiltro.ofe_saquedebanda_longitud):true &&

      widget._jugadorFiltro.ofe_lanzadordeabps==true?
      (event.snapshot.value['_ofe_lanzadordeabps'] ==
              widget._jugadorFiltro.ofe_lanzadordeabps):true &&

      widget._jugadorFiltro.ofe_salidadebalon==true?
      (event.snapshot.value['_ofe_salidadebalon'] ==
              widget._jugadorFiltro.ofe_salidadebalon):true &&

          widget._jugadorFiltro.ofe_paselargo_medio==true?
      (event.snapshot.value['_ofe_paselargo_medio'] ==
              widget._jugadorFiltro.ofe_paselargo_medio):true &&

          widget._jugadorFiltro.ofe_cambiosdeorientacion==true?
      (event.snapshot.value['_ofe_cambiosdeorientacion'] ==
              widget._jugadorFiltro.ofe_cambiosdeorientacion):true &&

          widget._jugadorFiltro.ofe_batelineasconpaseinterior==true?
      (event.snapshot.value['_ofe_batelineasconpaseinterior'] ==
              widget._jugadorFiltro.ofe_batelineasconpaseinterior):true &&

          widget._jugadorFiltro.ofe_conduccionparadividir==true?
      (event.snapshot.value['_ofe_conduccionparadividir'] ==
              widget._jugadorFiltro.ofe_conduccionparadividir):true &&

          widget._jugadorFiltro.ofe_primerpasetrasrecuperacion==true?
      (event.snapshot.value['_ofe_primerpasetrasrecuperacion'] ==
              widget._jugadorFiltro.ofe_primerpasetrasrecuperacion):true &&

          widget._jugadorFiltro.ofe_intervieneenabps==true?
      (event.snapshot.value['_ofe_intervieneenabps'] ==
              widget._jugadorFiltro.ofe_intervieneenabps):true &&

          widget._jugadorFiltro.ofe_incorporacionazonasderemate==true?
      (event.snapshot.value['_ofe_incorporacionazonasderemate'] ==
              widget._jugadorFiltro.ofe_incorporacionazonasderemate):true &&

          widget._jugadorFiltro.ofe_incorporacionazonasderemate==true?
      (event.snapshot.value['_ofe_incorporacionazonasderemate'] ==
              widget._jugadorFiltro.ofe_incorporacionazonasderemate):true &&

          widget._jugadorFiltro.ofe_amplitud==true?
      (event.snapshot.value['_ofe_amplitud'] ==
              widget._jugadorFiltro.ofe_amplitud):true &&

          widget._jugadorFiltro.ofe_desmarquesdeapoyo==true?
      (event.snapshot.value['_ofe_desmarquesdeapoyo'] ==
              widget._jugadorFiltro.ofe_desmarquesdeapoyo):true &&

          widget._jugadorFiltro.ofe_desmarquesderuptura==true?
      (event.snapshot.value['_ofe_desmarquesderuptura'] ==
              widget._jugadorFiltro.ofe_desmarquesderuptura):true &&

          widget._jugadorFiltro.ofe_capacidaddegenerarbuenoscentroslateralesalarea==true?
      (event.snapshot
              .value['_ofe_capacidaddegenerarbuenoscentroslateralesalarea'] ==
              widget._jugadorFiltro
                  .ofe_capacidaddegenerarbuenoscentroslateralesalarea):true &&

          widget._jugadorFiltro.ofe_habilidad1vs1==true?
      (event.snapshot.value['_ofe_habilidad1vs1'] ==
              widget._jugadorFiltro.ofe_habilidad1vs1):true &&

          widget._jugadorFiltro.ofe_realizaciondelultimopase==true?
      (event.snapshot.value['_ofe_realizaciondelultimopase'] ==
              widget._jugadorFiltro.ofe_realizaciondelultimopase):true &&

          widget._jugadorFiltro.ofe_goleador==true?
      (event.snapshot.value['_ofe_goleador'] == widget._jugadorFiltro
              .ofe_goleador):true &&

          widget._jugadorFiltro.ofe_explotaciondeespacios==true?
      (event.snapshot.value['_ofe_explotaciondeespacios'] == widget._jugadorFiltro
              .ofe_explotaciondeespacios):true &&

          widget._jugadorFiltro.ofe_duelosaereos==true?
      (event.snapshot.value['_ofe_duelosaereos'] ==
              widget._jugadorFiltro.ofe_duelosaereos):true &&

          widget._jugadorFiltro.ofe_desbordeporvelocidad==true?
      (event.snapshot.value['_ofe_desbordeporvelocidad'] ==
              widget._jugadorFiltro.ofe_desbordeporvelocidad):true &&

          widget._jugadorFiltro.ofe_dominiode2vs1_pared==true?
      (event.snapshot.value['_ofe_dominiode2vs1_pared'] ==
              widget._jugadorFiltro.ofe_dominiode2vs1_pared):true &&

          widget._jugadorFiltro.ofe_ambidextro==true?
      (event.snapshot.value['_ofe_ambidextro'] ==
              widget._jugadorFiltro.ofe_ambidextro):true &&

          widget._jugadorFiltro.ofe_juegodecara==true?
      (event.snapshot.value['_ofe_juegodecara'] ==
              widget._jugadorFiltro.ofe_juegodecara):true &&

          widget._jugadorFiltro.ofe_protecciondelbalon==true?
      (event.snapshot.value['_ofe_protecciondelbalon'] ==
              widget._jugadorFiltro.ofe_protecciondelbalon):true &&

          widget._jugadorFiltro.ofe_caidasabanda==true?
      (event.snapshot.value['_ofe_caidasabanda'] ==
              widget._jugadorFiltro.ofe_caidasabanda):true &&

          widget._jugadorFiltro.ofe_prolongacionesaereas==true?
      (event.snapshot.value['_ofe_prolongacionesaereas'] ==
              widget._jugadorFiltro.ofe_prolongacionesaereas):true &&

          widget._jugadorFiltro.ofe_dominiodelarea==true?
      (event.snapshot.value['_ofe_dominiodelarea'] ==
              widget._jugadorFiltro.ofe_dominiodelarea):true &&

          widget._jugadorFiltro.ofe_llegadaaposicionesderemate==true?
      (event.snapshot.value['_ofe_llegadaaposicionesderemate'] ==
              widget._jugadorFiltro.ofe_llegadaaposicionesderemate):true &&

          widget._jugadorFiltro.ofe_juegoesespacioreducido==true?
      (event.snapshot.value['_ofe_juegoesespacioreducido'] ==
              widget._jugadorFiltro.ofe_juegoesespacioreducido):true &&

          widget._jugadorFiltro.ofe_definidor_anteelportero==true?
      (event.snapshot.value['_ofe_definidor_anteelportero'] ==
              widget._jugadorFiltro.ofe_definidor_anteelportero):true &&

          widget._jugadorFiltro.ofe_rematador_finalizador==true?
      (event.snapshot.value['_ofe_rematador_finalizador'] ==
              widget._jugadorFiltro.ofe_rematador_finalizador):true &&

          widget._jugadorFiltro.ofe_capacidadasociativa_apoyosalalineadefensiva==true?
      (event.snapshot
              .value['_ofe_capacidadasociativa_apoyosalalineadefensiva'] ==
              widget._jugadorFiltro
                  .ofe_capacidadasociativa_apoyosalalineadefensiva):true &&

          widget._jugadorFiltro.ofe_desplazamientoenlargo==true?
      (event.snapshot.value['_ofe_desplazamientoenlargo'] ==
              widget._jugadorFiltro.ofe_desplazamientoenlargo):true
        &&

          widget._jugadorFiltro.psic_liderazgo==true?
      (event.snapshot.value['_psic_liderazgo'] ==
              widget._jugadorFiltro.psic_liderazgo):true &&

          widget._jugadorFiltro.psic_comunicacion==true?
      (event.snapshot.value['_psic_comunicacion'] ==
              widget._jugadorFiltro.psic_comunicacion):true &&

          widget._jugadorFiltro.psic_seguridad==true?
      (event.snapshot.value['_psic_seguridad'] ==
              widget._jugadorFiltro.psic_seguridad):true &&

          widget._jugadorFiltro.psic_tomadedecisiones==true?
      (event.snapshot.value['_psic_tomadedecisiones'] ==
              widget._jugadorFiltro.psic_tomadedecisiones):true &&

          widget._jugadorFiltro.psic_agresividad==true?
      (event.snapshot.value['_psic_agresividad'] ==
              widget._jugadorFiltro.psic_agresividad):true &&

          widget._jugadorFiltro.psic_polivalencia==true?
      (event.snapshot.value['_psic_polivalencia'] ==
              widget._jugadorFiltro.psic_polivalencia):true &&

          widget._jugadorFiltro.psic_competitividad==true?
      (event.snapshot.value['_psic_competitividad'] ==
              widget._jugadorFiltro.psic_competitividad):true &&

          widget._jugadorFiltro.psic_agresividad_contundencia==true?
      (event.snapshot.value['_psic_agresividad_contundencia'] ==
              widget._jugadorFiltro.psic_agresividad_contundencia):true &&

          widget._jugadorFiltro.psic_noasumeriesgosextremos==true?
      (event.snapshot.value['_psic_noasumeriesgosextremos'] ==
              widget._jugadorFiltro.psic_noasumeriesgosextremos):true &&

          widget._jugadorFiltro.psic_entendimientodeljuego_inteligencia==true?
      (event.snapshot.value['_psic_entendimientodeljuego_inteligencia'] ==
              widget._jugadorFiltro.psic_entendimientodeljuego_inteligencia):true &&

          widget._jugadorFiltro.psic_creatividad==true?
      (event.snapshot.value['_psic_creatividad'] ==
              widget._jugadorFiltro.psic_creatividad):true &&

          widget._jugadorFiltro.psic_confianza==true?
      (event.snapshot.value['_psic_confianza'] ==
              widget._jugadorFiltro.psic_confianza):true &&

          widget._jugadorFiltro.psic_compromiso==true?
      (event.snapshot.value['_psic_compromiso'] ==
              widget._jugadorFiltro.psic_compromiso):true &&

          widget._jugadorFiltro.psic_valentia==true?
      (event.snapshot.value['_psic_valentia'] ==
              widget._jugadorFiltro.psic_valentia):true &&

          widget._jugadorFiltro.psic_oportunismo==true?
      (event.snapshot.value['_psic_oportunismo'] ==
              widget._jugadorFiltro.psic_oportunismo):true &&

          widget._jugadorFiltro.def_acoso_presionsobreeloponente==true?
      (event.snapshot.value['_def_acoso_presionsobreeloponente'] ==
              widget._jugadorFiltro.def_acoso_presionsobreeloponente):true &&

          widget._jugadorFiltro.def_actituddefensiva==true?
      (event.snapshot.value['_def_actituddefensiva'] ==
              widget._jugadorFiltro.def_actituddefensiva):true &&

          widget._jugadorFiltro.def_activaciondelosmecanismosdepresion==true?
      (event.snapshot.value['_def_activaciondelosmecanismosdepresion'] ==
              widget._jugadorFiltro.def_activaciondelosmecanismosdepresion):true &&

          widget._jugadorFiltro.def_anticipacion==true?
      (event.snapshot.value['_def_anticipacion'] ==
              widget._jugadorFiltro.def_anticipacion):true &&

          widget._jugadorFiltro.def_ayudaspermanentesallateral==true?
      (event.snapshot.value['_def_ayudaspermanentesallateral'] ==
              widget._jugadorFiltro.def_ayudaspermanentesallateral):true &&

          widget._jugadorFiltro.def_capacidaddemarcaje==true?
      (event.snapshot.value['_def_capacidaddemarcaje'] ==
              widget._jugadorFiltro.def_capacidaddemarcaje):true &&

          widget._jugadorFiltro.def_capacidadparataparcentros==true?
      (event.snapshot.value['_def_capacidadparataparcentros'] ==
              widget._jugadorFiltro.def_capacidadparataparcentros):true &&

          widget._jugadorFiltro.def_cerrarelladodebil_basculaciones==true?
      (event.snapshot.value['_def_cerrarelladodebil_basculaciones'] ==
              widget._jugadorFiltro.def_cerrarelladodebil_basculaciones):true &&

          widget._jugadorFiltro.def_cierralineasdepase==true?
      (event.snapshot.value['_def_cierralineasdepase'] ==
              widget._jugadorFiltro.def_cierralineasdepase):true &&

          widget._jugadorFiltro.def_coberturadecentrales==true?
      (event.snapshot.value['_def_coberturadecentrales'] == widget._jugadorFiltro
              .def_coberturadecentrales):true &&

          widget._jugadorFiltro.def_coberturas==true?
      (event.snapshot.value['_def_coberturas'] == widget._jugadorFiltro
              .def_coberturas):true &&

          widget._jugadorFiltro.def_colocacion==true?
      (event.snapshot.value['_def_colocacion'] ==
              widget._jugadorFiltro.def_colocacion):true &&

          widget._jugadorFiltro.def_comportamientofueradezona==true?
      (event.snapshot.value['_def_comportamientofueradezona'] ==
              widget._jugadorFiltro.def_comportamientofueradezona):true &&

          widget._jugadorFiltro.def_correctabasculacion==true?
      (event.snapshot.value['_def_correctabasculacion'] ==
              widget._jugadorFiltro.def_correctabasculacion):true &&

          widget._jugadorFiltro.def_correctabasculacion_distanciadeintervalos==true?
      (event.snapshot
              .value['_def_correctabasculacion_distanciadeintervalos'] ==
              widget._jugadorFiltro.def_correctabasculacion_distanciadeintervalos):true &&

          widget._jugadorFiltro.def_correctoperfilamiento==true?
      (event.snapshot.value['_def_correctoperfilamiento'] ==
              widget._jugadorFiltro.def_correctoperfilamiento):true &&

          widget._jugadorFiltro.def_cruces==true?
          (event.snapshot.value['_def_cruces'] == widget._jugadorFiltro.def_cruces):true &&

              widget._jugadorFiltro.def_destrezaantecentroslaterales==true?
          (event.snapshot.value['_def_destrezaantecentroslaterales'] ==
              widget._jugadorFiltro.def_destrezaantecentroslaterales):true &&

              widget._jugadorFiltro.def_dificildesuperarenel1vs1==true?
          (event.snapshot.value['_def_dificildesuperarenel1vs1'] ==
              widget._jugadorFiltro.def_dificildesuperarenel1vs1):true &&

              widget._jugadorFiltro.def_dominiodelaszonasderechace==true?
          (event.snapshot.value['_def_dominiodelaszonasderechace'] ==
              widget._jugadorFiltro.def_dominiodelaszonasderechace):true &&

              widget._jugadorFiltro.def_duelosaereos==true?
          (event.snapshot.value['_def_duelosaereos'] ==
              widget._jugadorFiltro.def_duelosaereos):true &&

              widget._jugadorFiltro.def_duelosdefensivos==true?
          (event.snapshot.value['_def_duelosdefensivos'] ==
              widget._jugadorFiltro.def_duelosdefensivos):true &&

              widget._jugadorFiltro.def_evitarecepcionesentrelineas==true?
          (event.snapshot.value['_def_evitarecepcionesentrelineas'] ==
              widget._jugadorFiltro.def_evitarecepcionesentrelineas):true &&

              widget._jugadorFiltro.def_evitaserdesbordado==true?
          (event.snapshot.value['_def_evitaserdesbordado'] ==
              widget._jugadorFiltro.def_evitaserdesbordado):true &&

              widget._jugadorFiltro.def_interceptaciondetiro==true?
          (event.snapshot.value['_def_interceptaciondetiro'] ==
              widget._jugadorFiltro.def_interceptaciondetiro):true &&

              widget._jugadorFiltro.def_mantenerlalineadefensiva==true?
          (event.snapshot.value['_def_mantenerlalineadefensiva'] ==
              widget._jugadorFiltro.def_mantenerlalineadefensiva):true &&

              widget._jugadorFiltro.def_marcajeproximoaoponentedirecto==true?
          (event.snapshot.value['_def_marcajeproximoaoponentedirecto'] ==
              widget._jugadorFiltro.def_marcajeproximoaoponentedirecto):true &&

              widget._jugadorFiltro.def_ocupaespaciosdecompanerossuperados==true?
          (event.snapshot.value['_def_ocupaespaciosdecompanerossuperados'] ==
              widget._jugadorFiltro.def_ocupaespaciosdecompanerossuperados):true &&


              widget._jugadorFiltro.def_perfilamientos==true?
          (event.snapshot.value['_def_perfilamientos'] ==
              widget._jugadorFiltro.def_perfilamientos):true &&

              widget._jugadorFiltro.def_permiteelgiro==true?
          (event.snapshot.value['_def_permiteelgiro'] ==
              widget._jugadorFiltro.def_permiteelgiro):true &&

              widget._jugadorFiltro.def_presiontrasperdida==true?
          (event.snapshot.value['_def_presiontrasperdida'] ==
              widget._jugadorFiltro.def_presiontrasperdida):true &&


              widget._jugadorFiltro.def_resolucionanteparedesrivales==true?
          (event.snapshot.value['_def_resolucionanteparedesrivales'] ==
              widget._jugadorFiltro.def_resolucionanteparedesrivales):true &&


              widget._jugadorFiltro.def_sabecuidarsuespalda==true?
          (event.snapshot.value['_def_sabecuidarsuespalda'] ==
              widget._jugadorFiltro.def_sabecuidarsuespalda):true &&


              widget._jugadorFiltro.def_vigilayreferenciaalrival_enfaseofensiva==true?
          (event.snapshot.value['_def_vigilayreferenciaalrival_enfaseofensiva'] ==
              widget._jugadorFiltro.def_vigilayreferenciaalrival_enfaseofensiva):true &&


              widget._jugadorFiltro.def_vigilanciassobrelateralrival==true?
          (event.snapshot.value['_def_vigilanciassobrelateralrival'] ==
              widget._jugadorFiltro.def_vigilanciassobrelateralrival):true &&


              widget._jugadorFiltro.def_blocaje==true?
          (event.snapshot.value['_def_blocaje'] == widget._jugadorFiltro.def_blocaje):true &&

              widget._jugadorFiltro.def_juegoaereolateral==true?
          (event.snapshot.value['_def_juegoaereolateral'] ==
              widget._jugadorFiltro.def_juegoaereolateral):true &&

              widget._jugadorFiltro.def_juegoaereofrontal==true?
          (event.snapshot.value['_def_juegoaereofrontal'] ==
              widget._jugadorFiltro.def_juegoaereofrontal):true &&

              widget._jugadorFiltro.def_habilidadenel1vs1==true?
          (event.snapshot.value['_def_habilidadenel1vs1'] ==
              widget._jugadorFiltro.def_habilidadenel1vs1):true &&

              widget._jugadorFiltro.def_despeje==true?
          (event.snapshot.value['_def_despeje'] == widget._jugadorFiltro.def_despeje):true &&

              widget._jugadorFiltro.def_anticipacion_intuicion==true?
          (event.snapshot.value['_def_anticipacion_intuicion'] ==
              widget._jugadorFiltro.def_anticipacion_intuicion):true &&

              widget._jugadorFiltro.def_coberturadelineadefensiva==true?
          (event.snapshot.value['_def_coberturadelineadefensiva'] ==
              widget._jugadorFiltro.def_coberturadelineadefensiva):true &&

              widget._jugadorFiltro.def_abps==true?
          (event.snapshot.value['_def_abps'] == widget._jugadorFiltro.def_abps):true &&

              widget._jugadorFiltro.def_penaltis==true?
          (event.snapshot.value['_def_penaltis'] == widget._jugadorFiltro.def_penaltis):true)
      )
      {
        jugadoresList.add(Jugador.fromSnapshot(event.snapshot));
      }
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

  @override
  void dispose() {
    super.dispose();
  }
}
