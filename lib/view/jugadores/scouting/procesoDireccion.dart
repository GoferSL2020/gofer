import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/modelo/player.dart';

import 'package:iafootfeel/view/jugadores/scouting/tabEditJugador.dart';

import 'package:iafootfeel/view/jugadores/scouting/tabNivelFoot.dart';
import 'package:iafootfeel/wigdet/texto.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProcesoDireccion extends StatefulWidget {
  ProcesoDireccion(this._jugador, this._padre);

  final Player _jugador;
  final TabEditJugador _padre;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Nivel();
  }
}

class _Nivel extends State<ProcesoDireccion> {
  final _twitter = TextEditingController();
  final _instragram = TextEditingController();
  final _transfermark = TextEditingController();

  String _marca = "";
  List<String> caract;
  String caractAux = "";
  String veredicto = "";
  int _talla = 0;

  int letrasAux = Config.letrasPalabra;

  List<String> _veredicto = <String>[
    "",
    'Firmar',
    'Muy interesante',
    'Continuar seguimiento',
    'Normal',
    'Descartar'
  ];

  List<int> _tallas = <int>[
    0,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47
  ];

  List<String> _marcas = <String>[
    '',
    'NIKE',
    'ADIDAS',
    'PUMA',
    'JOMA',
    'NEW BALANCE',
  ];

  String contacto = "";
  String _fechaVencimiento = "";
  String _fechaMarca = "";
  @override
  void initState() {
    _instragram.text = widget._jugador.instagram;
    _twitter.text = widget._jugador.twitter;
    _transfermark.text=widget._jugador.transfermark;
    _talla=widget._jugador.calzado;
    _marca=widget._jugador.marcaDeportiva;
    _fechaVencimiento = widget._jugador.fechaVencimientoContrato;
    _fechaMarca = widget._jugador.fechaFinalizacionMarca;

  }

  String gender;

  Widget build(BuildContext context) {

    FormField inputMarca = new FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
          decoration: InputDecoration(
          labelText: "Marca",
      ),
        items: _marcas.map<DropdownMenuItem<String>>((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )));
        }).toList(),
        value: _marca,
        isDense: true,
        onChanged: (value) {
          setState(() {
            //newContact.favoriteColor = newValue;
            widget._jugador.marcaDeportiva = value;
            widget._padre.cambio = true;
          });
        },
      );
    });

    FormField inputTalla= new FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: "Talla",
        ),
        items: _tallas.map<DropdownMenuItem<int>>((int value) {
          return new DropdownMenuItem<int>(
              value: value,
              child: new Text(value.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )));
        }).toList(),
        value: _talla,
        isDense: true,
        onChanged: (value) {
          setState(() {
            //newContact.favoriteColor = newValue;
            widget._jugador.calzado = value;
            widget._padre.cambio = true;
          });
        },
      );
    });


    TextFormField inputInstragram = TextFormField(
      controller: _instragram,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      decoration: InputDecoration(
        labelText: 'Instagram',
      ),
      onChanged: (String value) {
        widget._jugador.instagram = value;
        widget._padre.cambio = true;
        //_onChange(value);
      },
      /*validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },*/
    );


    TextFormField inputTransfermark = TextFormField(
      controller: _transfermark,
      inputFormatters: [
          LengthLimitingTextInputFormatter(100),
      ],
      decoration: InputDecoration(
        labelText: 'Transfermark',
      ),
      onChanged: (String value) {
        widget._jugador.transfermark = value;
        widget._padre.cambio = true;
        //_onChange(value);
      },
      /*validator: (value) {
        if (value.isEmpty) {
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
      ),
      onChanged: (String value) {
        widget._jugador.twitter = value;
        widget._padre.cambio = true;
        //_onChange(value);
      },
      /*validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },*/
    );

    Future<DateTime> getDate() {
      // Imagine that this function is
      // more complex and slow.
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2050),
        locale: const Locale("es", "ES"),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
      );
    }

    _launchInstagram() async {
      String nativeUrl = "instagram://user?username=${widget._jugador.instagram}";
      String webUrl = "https://www.instagram.com/${widget._jugador.instagram}/";
      if (await canLaunch(nativeUrl)) {
        await launch(nativeUrl);
      } else if (await canLaunch(webUrl)) {
        await launch(webUrl,forceSafariVC: true,forceWebView: true,enableJavaScript: true,universalLinksOnly: true,);
      } else {
        print("can't open Instagram");
      }
    }

    _launchTweet() async {
      String nativeUrl = "twitter://user?username=${widget._jugador.twitter}";
      String webUrl = "https://twitter.com/${widget._jugador.twitter}/";
      if (await canLaunch(nativeUrl)) {
        await launch(nativeUrl);
      } else if (await canLaunch(webUrl)) {
        await launch(webUrl,forceSafariVC: true,forceWebView: true,enableJavaScript: true);
      } else {
        print("can't open Instagram");
      }
    }

    _launchTrans() async {
      String nativeUrl = "${widget._jugador.transfermark}";
      String webUrl = "${widget._jugador.transfermark}/";
      if (await canLaunch(nativeUrl)) {
        await launch(nativeUrl);
      } else if (await canLaunch(webUrl)) {
        await launch(webUrl,forceSafariVC: true,forceWebView: true,enableJavaScript: true);
      } else {
        print("can't open transfermark");
      }
    }

    void callDatePickerVencimiento() async {
      var order = await getDate();
      setState(() {
        _fechaVencimiento = DateFormat('dd/MM/yyyy').format(order);
        widget._jugador.fechaVencimientoContrato = _fechaVencimiento;
        widget._padre.cambio = true;
      });
    }

    void callDatePickerMarca() async {
      var order = await getDate();
      setState(() {
        _fechaMarca = DateFormat('dd/MM/yyyy').format(order);
        widget._jugador.fechaFinalizacionMarca = _fechaMarca;
        widget._padre.cambio = true;
      });
    }

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
                  padding: EdgeInsets.only(left:15, right: 15,top:10),
                  child: Text("Base Legal",
                      style: TextStyle(
                        color:Config.colorAPP,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [

              Container(width:210,
                padding: EdgeInsets.only(left: 10.0, right: 8),
                child: Text("Contr. de representación:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    )),
              ),
              Row(
                children: [
                  Radio(
                    value: "Si",
                    groupValue: widget._jugador.contratoRepresentacion,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.contratoRepresentacion = value;
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
                    groupValue: widget._jugador.contratoRepresentacion,
                    onChanged: (value) {
                      setState(() {
                        widget._jugador.contratoRepresentacion = value;
                        widget._padre.cambio = true;
                      });
                    },
                  ),
                  Text('No')
                ],
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 210,
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                   "F. Vencimiento contrato:",
                  ),
                ),
                FlatButton(
                  minWidth: 1,
                  onPressed: callDatePickerVencimiento,
                  padding: EdgeInsets.only(left: 0.0),
                  child: Icon(
                    CustomIcon.calendar_alt,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                  child: _fechaVencimiento == null
                      ? Text(
                          "",
                          textScaleFactor: 1.0,
                        )
                      : Text(
                          "$_fechaVencimiento",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                ),

              ],
            ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(width:210,
                    padding: EdgeInsets.only(left: 10.0, right: 8),
                    child: Text("Contr. registrado Federación:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        )),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "Si",
                        groupValue: widget._jugador.contratoFederacion,
                        onChanged: (value) {
                          setState(() {
                            widget._jugador.contratoFederacion = value;
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
                        groupValue: widget._jugador.contratoFederacion,
                        onChanged: (value) {
                          setState(() {
                            widget._jugador.contratoFederacion = value;
                            widget._padre.cambio = true;
                          });
                        },
                      ),
                      Text('No')
                    ],
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(width:210,
                    padding: EdgeInsets.only(left: 10.0, right: 8),
                    child: Text("Contr. Protección Datos:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        )),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "Si",
                        groupValue: widget._jugador.contratoProteccionDatos,
                        onChanged: (value) {
                          setState(() {
                            widget._jugador.contratoProteccionDatos = value;
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
                        groupValue: widget._jugador.contratoProteccionDatos,
                        onChanged: (value) {
                          setState(() {
                            widget._jugador.contratoProteccionDatos = value;
                            widget._padre.cambio = true;
                          });
                        },
                      ),
                      Text('No')
                    ],
                  ),
                ]),
                Container(
                    padding: EdgeInsets.only(left:15, right: 15),
                    child: Text("Comunicación",
                        style: TextStyle(
                          color:Config.colorAPP,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(width:210,
                    padding: EdgeInsets.only(left: 10.0, right: 8),
                    child: Text("Servicio Comunicación:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        )),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "Si",
                        groupValue: widget._jugador.servicioComunicacion,
                        onChanged: (value) {
                          setState(() {
                            widget._jugador.servicioComunicacion = value;
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
                        groupValue: widget._jugador.servicioComunicacion,
                        onChanged: (value) {
                          setState(() {
                            widget._jugador.servicioComunicacion = value;
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
                      width: 50,
                      child: IconButton(
                        icon: new Image.asset("assets/img/trans.png"),
                        color:Colors.blue,
                        onPressed: () {
                          _launchTrans();
                        },

                      )),
                  Container(width: 300,
                    padding: EdgeInsets.only(left:15, right: 15),
                    child:inputTransfermark,
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: 50,
                    child: IconButton(
                      icon: Icon(CustomIcon.instagram),
                      color:Colors.red.shade700,
                      onPressed: () {
                        _launchInstagram();
                      },

                    )),
                Container(width: 300,
                  padding: EdgeInsets.only(left:15, right: 15),
                  child:inputInstragram,
                ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                      width: 50,
                      child: IconButton(
                        icon: Icon(CustomIcon.twitter),
                        color:Colors.blue,
                        onPressed: () {
                          _launchTweet();
                        },

                      )),
                  Container(width: 300,
                    padding: EdgeInsets.only(left:15, right: 15),
                    child:inputTwiter,
                  ),
                ]),

                Container(
                  padding: EdgeInsets.only(left:15, right: 15,top:10),
                  child: Text("Contrato Marca",
                      style: TextStyle(
                        color:Config.colorAPP,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(width:210,
                    padding: EdgeInsets.only(left: 15.0, right: 8),
                    child: Text("Contrato Marca Deportiva:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        )),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "Si",
                        groupValue: widget._jugador.contratoMarcaDeportiva,
                        onChanged: (value) {
                          setState(() {
                            widget._jugador.contratoMarcaDeportiva = value;
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
                        groupValue: widget._jugador.contratoMarcaDeportiva,
                        onChanged: (value) {
                          setState(() {
                            widget._jugador.contratoMarcaDeportiva = value;
                            widget._padre.cambio = true;
                          });
                        },
                      ),
                      Text('No')
                    ],
                  ),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(width: 100,
                        padding: EdgeInsets.only(left:15, right: 15),
                        child:inputTalla,
                      ),
                      Container(width: 200,
                        padding: EdgeInsets.only(left:15, right: 15),
                        child:inputMarca,
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 210,
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: Text(
                        "F. Finalización marca:",
                      ),
                    ),
                    FlatButton(
                      minWidth: 1,
                      onPressed: callDatePickerMarca,
                      padding: EdgeInsets.only(left: 0.0),
                      child: Icon(
                        CustomIcon.calendar_alt,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                      child: _fechaMarca == null
                          ? Text(
                        "",
                        textScaleFactor: 1.0,
                      )
                          : Text(
                        "$_fechaMarca",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),

                  ],
                ),
            Container(
            height: 50,
            ),
          ])),
    );
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
