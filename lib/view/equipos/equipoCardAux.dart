import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/futbol_mio_icons.dart';
import 'package:iadvancedscout/icon_mio_icons.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/scout.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/pdf/pdfEquipoTemporada.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/entrenadores/entrenadoresView.dart';
import 'package:iadvancedscout/view/jugadores/jugadoresView.dart';
import 'package:iadvancedscout/view/partidos/partidosJornadaView.dart';

class EquipoCardAux extends StatefulWidget {
  final Equipo equipoDetails;
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;

  EquipoCardAux(
      {@required this.equipoDetails,
      @required this.temporada,
      @required this.categoria,
      @required this.pais});

  @override
  _EquipoCardAuxState createState() => new _EquipoCardAuxState();
}

class _EquipoCardAuxState extends State<EquipoCardAux> {
  var empate = 0;
  var ganado = 0;
  var perdido = 0;
  var jugo = true;

  List<String> _observadores = List();
  List<Scout> _observadoresAUX = List();
  String _observador = "";

  cogerScouting() async {
    final dao2 = new CRUDCategoria();
    _observadores.clear();
    _observadoresAUX = await dao2.fetchScouting(
        widget.temporada, widget.pais, widget.categoria);
    _observadores.add("");
    for (var d in _observadoresAUX) {
      setState(() {
        _observadores.add(d.scout);
      });
    }
  }

  Future getGanados() async {
    final productProvider = new CRUDEquipo();
    var empateAux = 0;
    var ganadoAux = 0;
    var perdidoAux = 0;
    await productProvider
        .empateContar(widget.temporada, widget.equipoDetails)
        .then((value) {
      empateAux = value.docs.length;
    });
    await productProvider
        .ganadoContar(widget.temporada, widget.equipoDetails)
        .then((value) {
      ganadoAux = value.docs.length;
    });
    await productProvider
        .perdidoContar(widget.temporada, widget.equipoDetails)
        .then((value) {
      perdidoAux = value.docs.length;
    });

    setState(() {
      empate = empateAux == null ? 0 : empateAux;
      ganado = ganadoAux == null ? 0 : ganadoAux;
      perdido = perdidoAux == null ? 0 : perdidoAux;
      jugo = empate + ganado + perdido != 0 ? true : false;
    });
  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
// no need of the file extension, the name will do fine.

  @override
  void initState() {
    cogerScouting();
    getGanados();
    _observador=widget.equipoDetails.scouter;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDEquipo();

    FormField inputObservaciones =
        new FormField(builder: (FormFieldState state) {
        return
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Scouter:",
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              Container(width: 60,

              padding: EdgeInsets.all(2),

                child:
                BBDDService().getUserScout().categoria=="Todas"?
                new DropdownButtonFormField(
                  items: _observadores.map((String value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                  value: _observador,
                  validator: (value) => value == null ? 'Souter' : null,
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      _observador=value;
                      CRUDEquipo dao=new CRUDEquipo();
                      dao.updateEquipoScouter(
                          widget.temporada, widget.pais, widget.categoria,widget.equipoDetails,_observador);
                    });
                    _observador = value;
                    state.didChange(value);
                  },
                ):Text(
                  "${widget.equipoDetails.scouter}",
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              )
            ],
          );
    });
    return GestureDetector(
      onTap: (){
      //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
        //    JugadoresView(temporada: widget.temporada, equipo: widget.equipoDetails,categoria: widget.categoria, pais:widget.pais)));

      },
      child:
      Column(
          children: [
       Card(
          color: Config.colorCard,
          elevation: 5,
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, right: 0, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                  new SizedBox(
                  width: 35.0,
                    height: 35.0,
                      child:
                      FlatButton(
                        padding: EdgeInsets.all(0.0),
                      onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (_) =>
                        JugadoresView(temporada: widget.temporada, equipo: widget.equipoDetails,categoria: widget.categoria, pais:widget.pais)));
                        },
                        child: new Image.network(
                          Config.escudoClubes(widget.equipoDetails.equipo),
                          // "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2F${widget.equipoDetails.equipo}.png?alt=media",
                          height: 35),
                      )),
                      FlatButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (_) =>
                              JugadoresView(temporada: widget.temporada, equipo: widget.equipoDetails,categoria: widget.categoria, pais:widget.pais)));
                        },
                        child:
                       Container(width: 160,
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "${widget.equipoDetails.equipo}",
                              style: TextStyle(
                                color: Config.colorCardLetra,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          )),

                      Padding(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child:
                          inputObservaciones),
                    ],
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          height: 30,
                          width: 120,
                          child: RaisedButton.icon(
                            elevation: 10,
                            onPressed: () {
                              pdfEquipo(context, widget.equipoDetails);
                            },
                            label: Text(
                              "Evaluaciones",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            icon: Icon(
                              CustomIcon.dice_five,
                              size: 15,
                              color: Colors.black,
                            ),
                            textColor: Colors.white,
                            hoverColor: Colors.black,
                            splashColor: Colors.blue,
                            color: Colors.white,
                          )),
                      Container(
                        width: 2,
                      ),
                      SizedBox(
                          height: 30,
                          width: 92,
                          child: RaisedButton.icon(
                            elevation: 10,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PartidosJornadaView(
                                            temporada: widget.temporada,
                                            equipo: widget.equipoDetails,
                                            categoria: widget.categoria,
                                            pais: widget.pais,
                                          )));
                            },
                            label: Text(
                              "Partidos",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            icon: Icon(
                              CustomIcon.marcador,
                              size: 15,
                              color: Colors.black,
                            ),
                            textColor: Colors.white,
                            hoverColor: Colors.black,
                            splashColor: Colors.blue,
                            color: Colors.white,
                          )),
                      Container(
                        width: 2,
                      ),
                      SizedBox(
                          height: 30,
                          width: 120,
                          child: RaisedButton.icon(
                            elevation: 10,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EntrenadoresView(
                                            temporada: widget.temporada,
                                            equipo: widget.equipoDetails,
                                            categoria: widget.categoria,
                                            pais: widget.pais,
                                          )));
                            },
                            label: Text(
                              "Entrenador",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            icon: Icon(
                              FutbolMio.entrenador_1,
                              size: 15,
                              color: Colors.black,
                            ),
                            textColor: Colors.white,
                            hoverColor: Colors.black,
                            splashColor: Colors.blue,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ]),

    );
  }

  List<Partido> partidoAUX;

  cogerPartidos() async {
    CRUDEquipo dao = CRUDEquipo();
    partidoAUX = await dao.getEquipoPartidos(
        widget.temporada, widget.pais, widget.categoria, widget.equipoDetails);
  }

 /* */

  void pdfEquipo(BuildContext context, Equipo equipo) {
    for (int i = 0; i < 4; i++) {
      Fluttertoast.showToast(
          msg:
              "Espera...\nEstamos haciendo el \ndocumento del equipo:\n${equipo.equipo}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 20,
          backgroundColor: Colors.red.shade900,
          textColor: Colors.white,
          fontSize: 12.0);
    }
    PdfEquipoTemporada pdf = PdfEquipoTemporada(
      widget.temporada,
      equipo,
      widget.pais,
      widget.categoria,
    );
    pdf.generateInvoice();
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, Equipo equipo) {
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
              Text('¿Quieres $action el equipo\n${equipo.equipo}?'),
              Container(
                height: 10,
              ),
              Text('Eliminar los datos del equipo (jugadores y partidos)',
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
