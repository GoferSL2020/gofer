import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/dao/CRUDScout.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/modelo/userScout.dart';
import 'package:iafootfeel/view/jugadores/scouting/tabEditJugador.dart';
import 'package:iafootfeel/view/jugadores/scouting/tabNivelFoot.dart';
import 'package:iafootfeel/wigdet/texto.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';

class ProcesoCaptacion extends StatefulWidget {
  ProcesoCaptacion(this._jugador, this._padre);

  final Player _jugador;
  final TabEditJugador _padre;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Nivel();
  }
}

class _Nivel extends State<ProcesoCaptacion> {
  final _twitter = TextEditingController();
  final _instragram = TextEditingController();


  late List<String> caract;
  String caractAux = "";
  String veredicto = "";
  int letrasAux = Config.letrasPalabra;
  String _fechaContrato = "";

  List<String> _veredicto = <String>[
    "",
    'Firmar',
    'Muy interesante',
    'Continuar seguimiento',
    'Normal',
    'Descartar'
  ];

  String contacto = "";


  @override
  void initState() {
    _instragram.text = widget._jugador.instagram;
    _twitter.text = widget._jugador.twitter;
    _fechaContrato = widget._jugador.fechaContrato;
    setState(() {

    });

  }

  Future<DateTime?> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate:  Config.dateStringtodateCalendario(widget._jugador.fechaContrato)!,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
      locale: const Locale("es", "ES"),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
  }

  void callDatePickerClub() async {
    var order = await getDate();
    setState(() {
      _fechaContrato = DateFormat('dd/MM/yyyy').format(order!);
      widget._jugador.fechaContrato = _fechaContrato;
      widget._padre.cambio = true;
    });
  }

  Widget build(BuildContext context) {
    TextFormField inputInstragram = TextFormField(
      controller: _instragram,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      decoration: InputDecoration(
        labelText: 'Instagram',
        icon: Icon(
          CustomIcon.instagram,
          size: 20,
          color: Colors.black,
        ),
      ),
      onChanged: (String value) {
        widget._jugador.instagram = value;
        widget._padre.cambio = true;
        //_onChange(value);
      },
      /*validator: (value) {
        if (value!.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },*/
    );
    TextFormField inputTwiter = TextFormField(
      controller: _twitter,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      decoration: InputDecoration(
        labelText: 'Twitter',
        icon: Icon(
          CustomIcon.twitter,
          color: Colors.black,
        ),
      ),
      onChanged: (String value) {
        widget._jugador.twitter = value;
        widget._padre.cambio = true;
        //_onChange(value);
      },
      /*validator: (value) {
        if (value!.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },*/
    );


    String dropdownValue = 'Dog';

    print("_________");
    print(caractAux);
    // TODO: implement build
    return Scaffold(
      body: new SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Text("Seguimiento de jugadores",
                  style: TextStyle(
                    color: Config.colorAPP,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 210,
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    "Fecha Fin contrato Club:",
                  ),
                ),
                TextButton(
                  onPressed: callDatePickerClub,
                  child: Icon(
                    CustomIcon.calendar_alt,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                  child: _fechaContrato == null
                      ? Text(
                          "",
                          textScaleFactor: 1.0,
                        )
                      : Text(
                          "$_fechaContrato",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Text("Rendimiento",
                  style: TextStyle(
                    color: Config.colorAPP,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
            ),
            Container(
              height: 170,
              padding: EdgeInsets.only(left: 0, right: 0),
              child: TabNivelFoot(widget._jugador, widget._padre),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: ToggleSwitch(
                      minWidth: 120,
                      minHeight: 30,
                      initialLabelIndex:
                          Config.getValue(widget._jugador.rendimiento),
                      activeBgColor: [Colors.blue.shade900],
                      inactiveBgColor: Colors.grey.shade300,
                      inactiveFgColor: Colors.black,
                      fontSize: 12,
                      labels: [
                        'Otros',
                        'Cantera',
                        'Sel.Autonómica',
                        'Internacional',
                      ],
                      onToggle: (index) {
                        setState(() {
                          widget._jugador.rendimiento =
                              Config.redimiento[index!];
                          widget._padre.cambio = true;
                        });
                      },
                    )),
              ],
            ),
            Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(0.0),
                child: Texto(
                    Colors.blue.shade900,
                    "Descripción jugador".toUpperCase(),
                    12,
                    Colors.white,
                    false)),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 0.0, left: 25.0, right: 25.0),
                child: TextField(
                  enabled: true,
                  controller: TextEditingController(
                      text: widget._jugador.descripcion),
                  maxLines: 5,
                  maxLength: 1000,
                  decoration: InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(1.0),
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  onChanged: (String value) {
                    widget._jugador.descripcion = value;
                    widget._padre.cambio = true;

                    //_onChange(value);
                  },
                )),
            Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(0.0),
                child: Texto(
                    Colors.blue.shade900,
                    "Observaciones scouter".toUpperCase(),
                    12,
                    Colors.white,
                    false)),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 0.0, left: 25.0, right: 25.0),
                child: TextField(
                  enabled: true,
                  controller: TextEditingController(
                      text: widget._jugador.observaciones),
                  maxLines: 5,
                  maxLength: 1000,
                  decoration: InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(1.0),
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  onChanged: (String value) {
                    widget._jugador.observaciones = value;
                    widget._padre.cambio = true;

                    //_onChange(value);
                  },
                )),
                Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(0.0),
                    child: Texto(
                        Colors.blue.shade900,
                        "Sólo para jugadores no FootFeel".toUpperCase(),
                        12,
                        Colors.white,
                        false)),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: 75,
                padding: EdgeInsets.only(left: 5.0, right: 8),
                child: Text("Agente:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    )),
              ),
              Row(
                children: [
                  Radio(
                    value: "Si",
                    groupValue: widget._jugador.agente,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.agente = value.toString();
                        widget._padre.cambio = true;
                      });
                    },
                  ),
                  Text('Si')
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "No",
                    groupValue: widget._jugador.agente,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.agente = value.toString();
                        widget._padre.cambio = true;
                      });
                    },
                  ),
                  Text('No')
                ],
              ),

            ]),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: 75,
                padding: EdgeInsets.only(left: 5.0, right: 8),
                child: Text("Contacto:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    )),
              ),
              Row(
                children: [
                  Radio(
                    value: "Si",
                    groupValue: widget._jugador.contacto,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.contacto = value.toString();
                        widget._padre.cambio = true;
                      });
                    },
                  ),
                  Text('Si')
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "No",
                    groupValue: widget._jugador.contacto,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.contacto = value.toString();
                        widget._padre.cambio = true;
                      });
                    },
                  ),
                  Text('No')
                ],
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: 75,
                padding: EdgeInsets.only(left: 5.0, right: 15),
                child: Text("Reunión:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    )),
              ),
              Row(
                children: [
                  Radio(
                    value: "Realizada",
                    groupValue: widget._jugador.reunion,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.reunion = value.toString();
                        widget._padre.cambio = true;
                      });
                    },
                  ),
                  Text('Realizada',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "En proceso",
                    groupValue: widget._jugador.reunion,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.reunion = value.toString();
                        widget._padre.cambio = true;
                      });
                    },
                  ),
                  Text('En proceso',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "No",
                    groupValue: widget._jugador.reunion,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.reunion = value.toString();
                        widget._padre.cambio = true;
                      });
                    },
                  ),
                  Text('No',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ],
              ),
            ]),
            Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(0.0),
                child: Texto(
                    Colors.blue.shade900,
                    "Comentario captación".toUpperCase(),
                    12,
                    Colors.white,
                    false)),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 0.0, left: 25.0, right: 25.0),
                child: TextField(
                  enabled: true,
                  controller: TextEditingController(
                      text: widget._jugador.comentarios),
                  maxLines: 5,
                  maxLength: 1000,
                  decoration: InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(1.0),
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  onChanged: (String value) {
                    widget._jugador.comentarios = value;
                    widget._padre.cambio = true;

                    //_onChange(value);
                  },
                )),
          ])),
    );
  }


  List<TableRow> ponerFila2col() {
    List<TableRow> rows = <TableRow>[];
    for (String doc in caract) {
      rows.add(TableRow(children: [
        new Container(
          height: 10,
        )
      ]));
      rows.add(TableRow(children: [
        new Text(doc.split(":")[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            )),
      ]));
      rows.add(TableRow(children: [
        new Text(doc.split(":")[1],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            )),
      ]));
    }
    return rows;
  }

  @override
  void setState(fn) {
    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }
}

/*
Nivel técnico
Salida de balón
Pase largo/medio
Cambios de orientación
Bate líneas con pase interior
Conducción para dividir
Primer pase tras recuperación
Interviene en ABP´s
Finalización
 */
