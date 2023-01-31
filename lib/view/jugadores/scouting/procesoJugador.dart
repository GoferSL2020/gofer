import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/dao/CRUDCategoria.dart';
import 'package:iafootfeel/dao/CRUDEquipoJugador.dart';
import 'package:iafootfeel/dao/CRUDJugador.dart';
import 'package:iafootfeel/dao/CRUDNacionalidad.dart';
import 'package:iafootfeel/dao/CRUDPais.dart';
import 'package:iafootfeel/dao/CRUDScout.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/nacionalidad.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/modelo/seleccion.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/userScout.dart';

import 'package:iafootfeel/view/jugadores/scouting/tabNivelFoot.dart';
import 'package:iafootfeel/wigdet/texto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

class ProcesoJugador extends StatefulWidget {
  static String tag = 'edit-page';
  final Player jugador;
  final Pais pais;
  ProcesoJugador({@required this.jugador, @required this.pais});

  @override
  _ProcesoJugadorState createState() => _ProcesoJugadorState();
}

class _ProcesoJugadorState extends State<ProcesoJugador> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _altura = TextEditingController();
  final _peso = TextEditingController();
  final _dorsal = TextEditingController();
  final _apellido = TextEditingController();
  String _extranjero = "Español";
  final _jugador = TextEditingController();
  final _apodo = TextEditingController();
  String _equipo;
  final _movil = TextEditingController();
  final _email = TextEditingController();
  final _valor = TextEditingController();
  var _fecha;
  var _fechaContrato;

  String _nacionalidad;
  String _nacionalidad2;
  String _pais;
  String _categoria;
  String _competicion = "";
  String _seleccion = "";
  bool _prestamo = false;
  String _puesto = "";
  String _lateral = "";
  String _puesto2 = "";
  String _catCantera = "";
  String _id = "";
  PickedFile _imageFile;
  String imageUrl;
  File _image;
  bool insertar = false;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  bool cambio = false;
  cambiar() {
    cambio = true;
  }

  List<String> _equipos = new List();
  List<String> _paises = new List();
  List<String> _nacionalidades = new List();
  List<String> _categorias = new List();
  List<String> _competiciones = new List();
  List<String> _selecciones= new List();

  List<String> _posicion2 = <String>[
    '',
    'PORTERO',
    'LATERAL',
    'CENTRAL',
    'CARRILERO',
    'PIVOTE',
    'MEDIOCENTRO',
    'VOLANTE',
    'INTERIOR',
    'MEDIAPUNTA',
    'EXTREMO',
    'DELANTERO',
  ];
  List<String> _posicion = <String>[
    '',
    'PORTERO',
    'DEFENSA',
    'CENTROCAMPISTA',
    'DELANTERO',
  ];
  List<String> _catCanteras = <String>[
    '',
    'A',
    'B',
    'C',
  ];
  /*
  Portero
Defensa central izquierdo
Defensa central derecho
Lateral derecho
Pivote
Delantero centro
Volante derecho
Delantero centro
Volante izquierdo
Interior izquierdo
Mediapunta derecho
Lateral izquierdo
Interior derecho
Mediapunta
Extremo izquierdo
Mediocentro izquierdo
Extremo derecho
Mediapunta izquierdo
Mediocentro derecho
Mediocentro ofensivo
Carrilero izquierdo
   */

  @override
  void dispose() {
    _nombre.dispose();
    _valor.dispose();

    _altura.dispose();
    _peso.dispose();
    _jugador.dispose();
    _movil.dispose();
    _dorsal.dispose();
    _apellido.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.pais == null) {
      if (widget.jugador.pais == "") {
        _pais = "";
        widget.jugador.pais = _pais;
      } else {
        _pais = widget.jugador.pais;
      }
    } else {
      if (widget.jugador.pais == "") {
        _pais = "";
        widget.jugador.pais = _pais;
      } else
        _pais = widget.jugador.pais;
    }

    setState(() {
      _cogerSelecciones();
      _cogerNacionaliades();
      _cogerPais();
      if (widget.jugador.pais != "") {
        print("ENTRO");
        _cogerCategorias();
        _cogerEquipos();
        _cogerCompeticiones();
        _equipo = widget.jugador.equipo;
      }
      if (widget.jugador.categoria != "") {
        _categoria = widget.jugador.categoria;
      }
      if (widget.jugador.competecion != "") {
        _competicion = widget.jugador.competecion;
      }
      if (widget.jugador.seleccion != "") {
        _seleccion = widget.jugador.seleccion;
      }
      _cogerScuter();
    });
    if(widget.jugador.scouter=="MIGRAR")
      _scouter="";
    else
      _scouter = widget.jugador.scouter;
    _nombre.text = widget.jugador.jugador;
    _categoria = widget.jugador.categoria;
    _seleccion= widget.jugador.seleccion;
    _competicion = widget.jugador.competecion;
    _apodo.text = widget.jugador.apodo;
    _catCantera = widget.jugador.catCantera;
    _valor.text = widget.jugador.valor;
    _prestamo = widget.jugador.prestamo == "si" ? true : false;
    _fecha = widget.jugador.fechaNacimiento;
    _fechaContrato = widget.jugador.fechaContrato;
    _nacionalidad2 = widget.jugador.nacionalidad2;
    _nacionalidad = widget.jugador.nacionalidad;

    _extranjero = widget.jugador.nacionalidad;
    _altura.text = widget.jugador.altura;
    _peso.text = widget.jugador.peso;
    _lateral = widget.jugador.lateral.toLowerCase();
    _dorsal.text = widget.jugador.dorsal.toString();
    _puesto = widget.jugador.posicion.toUpperCase();
    try {
      _puesto2 = widget.jugador.posicionalternativa.toUpperCase();
      _puesto2 = widget.jugador.posicionalternativa.toUpperCase();
    } catch (e) {
      _puesto2 = "";
    }


    insertar = widget.jugador.jugador == "" ? true : false;

    //_imageFile=Image.network(widget.jugador.imagen));
    //_imageFile;

    super.initState();
  }

  List<String> scouter = List();
  String _scouter = "";
  _cogerScuter() async {
    scouter.clear();
    List<UserScout> datos;
    datos = await CRUDUserScout().fetchUserScouts();
    setState(() {
      scouter.add("");
      for (var p in datos){
        scouter.add(p.name);
      }
    });
  }

  _cogerEquipos() async {
    _equipos.clear();
    String pais = await CRUDPais().getEquipoByNombre(_pais);
    List<EquipoJugador> datos;
    datos = await CRUDEquipoJugador().fetchEquiposJugadores(pais);
    setState(() {
      _equipos.add("");
      for (var p in datos) _equipos.add(p.equipo);
    });
  }

  _cogerCategorias() async {
    _categorias.clear();
    List<Categoria> datos;
    datos = await CRUDCategoria().fetchCategoriasTodas();
    setState(() {
      _categorias.add("");
      for (var p in datos) _categorias.add(p.categoria);
    });
  }

  _cogerCompeticiones() async {
    _competiciones.clear();

    String p = await CRUDPais().getEquipoByNombre(_pais);
    Pais pais = new Pais();
    pais.id = p;

    //  String pais = await CRUDPais().getEquipoByNombre(_pais);
    List<Categoria> datos;
    datos = await CRUDCategoria().fetchCategorias(pais);
    setState(() {
      _competiciones.add("");
      for (var p in datos) {
        print("${p.categoria}");
        _competiciones.add(p.categoria);
      }
    });
  }

  _cogerSelecciones() async {
    _selecciones.clear();
    //  String pais = await CRUDPais().getEquipoByNombre(_pais);
    List<Seleccion> selecciones;
    selecciones = await CRUDCategoria().fetchSelecciones();
    setState(() {
      _selecciones.add("");
      for (var s in selecciones) {
        print("${s}");
        _selecciones.add(s.seleccion);
      }
    });
  }

  _cogerPais() async {
    _paises.clear();
    List<Pais> datos;
    datos = await CRUDPais().fetchPaises();
    setState(() {
      _paises.add("");
      for (var p in datos) _paises.add(p.pais);
    });
  }

  _cogerNacionaliades() async {
    _nacionalidades.clear();
    List<Nacionalidad> datos;
    datos = await CRUDNacionalidad().fetchNacionalidades();
    setState(() {
      _nacionalidades.add("");
      for (var p in datos) _nacionalidades.add(p.nacionalidad);
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    setState(() {
      _image = image;
    });
  }

  _imgFromCamera() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 20,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Column picture = Column(
      children: <Widget>[
        Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: ClipOval(
                child: new SizedBox(
                    width: 90.0,
                    height: 90.0,
                    child: _imageFile != null
                        //https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/
                        ? Image.file(File(_imageFile.path), fit: BoxFit.fill)
                        : Image.network(
                            Config.imagenJugador(
                              null,
                              widget.jugador,
                            ),
                            fit: BoxFit.fitHeight,
                          )),
              ),
            ),
          ),
        )
      ],
    );
    FormField inputPosicion = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Poner el puesto",
        ),
        isEmpty: _puesto == '',
        child: new DropdownButtonFormField(
          items: _posicion.map((String value) {
            return new DropdownMenuItem(
                value: value,
                child: new Text(value,
                    style: TextStyle(
                      fontSize: 12,
                    )));
          }).toList(),
          value: _puesto,
          validator: (value) => value == null ? 'Puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _puesto = value;
              widget.jugador.posicion = value;
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });

    FormField inputPosicion2 = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Puesto secundario",
        ),
        isEmpty: _puesto2 == '',
        child: new DropdownButtonFormField(
          items: _posicion2.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontSize: 12,
                  )),
            );
          }).toList(),
          value: _puesto2,
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              _puesto2 = value;
              widget.jugador.posicionalternativa = value;
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });

    FormField inputEquipo = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Equipo",
        ),
        isEmpty: _equipo == '',
        child: new DropdownButtonFormField(
          items: _equipos.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            );
          }).toList(),
          value: _equipo,
          validator: (value) => value == '' ? 'Poner el equipo' : '',
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _equipo = value;
              widget.jugador.equipo = _equipo;
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });
    FormField inputPaises = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "País de Competeción",
        ),
        isEmpty: _pais == null,
        child: new DropdownButtonFormField(
          items: _paises.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            );
          }).toList(),
          value: _pais,
          validator: (value) => value == '' ? 'Poner el pais' : '',
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _pais = value;
              _equipos.clear();
              _equipo = "";
              widget.jugador.pais = _pais;
              widget.jugador.equipo = "";
              widget.jugador.competecion = "";

              _competicion="";
              _cogerEquipos();
              _cogerCategorias();
              _cogerCompeticiones();
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });

    FormField inputNacionalidad1 =
        new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Nacionalidad 1",
        ),
        isEmpty: _nacionalidad == null,
        child: new DropdownButtonFormField(
          items: _nacionalidades.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            );
          }).toList(),
          value: _nacionalidad,
          validator: (value) => value == '' ? 'Poner la nacionalidad' : '',
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _nacionalidad = value;
              widget.jugador.nacionalidad = _nacionalidad;
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });

    FormField inputNacionalidad2 =
        new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Nacionalidad 2",
        ),
        isEmpty: _nacionalidad2 == null,
        child: new DropdownButtonFormField(
          items: _nacionalidades.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            );
          }).toList(),
          value: _nacionalidad2,
          validator: (value) => value == '' ? 'Poner la nacionalidad 2' : '',
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _nacionalidad2 = value;
              widget.jugador.nacionalidad2 = _nacionalidad2;
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });
    FormField inputCategoria = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Categoria",
        ),
        isEmpty: _categoria == null,
        child: new DropdownButtonFormField(
          items: _categorias.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            );
          }).toList(),
          value: _categoria,
          validator: (value) => value == '' ? 'Poner el pais' : '',
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _categoria = value;
              setState(() {
                widget.jugador.categoria = _categoria;
              });
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });

    FormField inputCompeticiones =
        new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Competición",
        ),
        isEmpty: _competicion == null,
        child: new DropdownButtonFormField(
          items: _competiciones.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            );
          }).toList(),
          value: _competicion,
          validator: (value) => value == '' ? 'Poner el pais' : '',
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _competicion = value;
              setState(() {
                widget.jugador.competecion = _competicion;
              });
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });

    FormField inputSelecciones =
    new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Selección",
        ),
        isEmpty: _selecciones == null,
        child: new DropdownButtonFormField(
          items: _selecciones.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            );
          }).toList(),
          value: _seleccion,
          validator: (value) => value == '' ? 'Poner la selección' : '',
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _seleccion = value;
              setState(() {
                widget.jugador.seleccion = _seleccion;
              });
              cambio = true;
              state.didChange(value);
            });
          },
        ),
      );
    });

    FormField inputCatCantera = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "A,B,C",
        ),
        isEmpty: _catCantera == null,
        child: new DropdownButtonFormField(
          items: _catCanteras.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            );
          }).toList(),
          value: _catCantera,
          validator: (value) => value == '' ? 'Poner el A,B,C' : '',
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            _catCantera = value;
            setState(() {
              widget.jugador.catCantera = _catCantera;
            });
            cambio = true;
            state.didChange(value);
          },
        ),
      );
    });

    TextFormField inputNombre = TextFormField(
      controller: _nombre,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nombre y apellidos',
        /* icon: Icon(
          CustomIcon.futbolista_4,
          color: Colors.black,
        ),        */
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
      onChanged: (value) {
        //newContact.favoriteColor = newValue;
        widget.jugador.jugador = value;
        cambio = true;
      },
    );

    TextFormField inputApodo = TextFormField(
      controller: _apodo,
      inputFormatters: [
        LengthLimitingTextInputFormatter(15),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Apodo',
        /* icon: Icon(
          CustomIcon.futbolista_4,
          color: Colors.black,
        ),        */
      ),
      onChanged: (value) {
        //newContact.favoriteColor = newValue;
        widget.jugador.apodo = value;
        cambio = true;
      },
    );

    TextFormField inputValor = TextFormField(
      controller: _valor,
      inputFormatters: [
        LengthLimitingTextInputFormatter(13),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Valor mercado',
        icon: Icon(
          Icons.monetization_on_outlined,
          color: Colors.black,
        ),
      ),
    );

    TextFormField inputDorsal = TextFormField(
      controller: _dorsal,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Dorsal',
        icon: Icon(
          CustomIcon.camiseta,
          color: Colors.black,
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
      onChanged: (value) {
        //newContact.favoriteColor = newValue;
        _dorsal.text = value;
        widget.jugador.dorsal = int.parse(_dorsal.text);
        cambio = true;
      },
    );

    TextFormField inputPeso = TextFormField(
      controller: _peso,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
        labelText: 'Peso',
        icon: Icon(
          CustomIcon.weight,
          size: 20,
          color: Colors.black,
        ),
      ),
      onChanged: (value) {
        //newContact.favoriteColor = newValue;
        widget.jugador.peso = value;
        cambio = true;
      },
      /*validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },*/
    );
    TextFormField inputAltura = TextFormField(
      controller: _altura,
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
      ],
      decoration: InputDecoration(
        labelText: 'Altura',
        icon: Icon(
          Icons.accessibility,
          color: Colors.black,
        ),
      ),
      onChanged: (value) {
        //newContact.favoriteColor = newValue;
        widget.jugador.altura = value;
        cambio = true;
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

    void callDatePicker() async {
      var order = await getDate();
      setState(() {
        _fecha = DateFormat('dd/MM/yyyy').format(order);
        widget.jugador.fechaNacimiento = _fecha;
        _categoria = widget.jugador.edadCategoria();
        cambio = true;
      });
    }

    void callDatePickerContrato() async {
      var order = await getDate();
      setState(() {
        _fechaContrato = DateFormat('dd/MM/yyyy').format(order);
        cambio = true;
      });
    }

    Widget _previewImage() {
      if (_imageFile != null) {
        return Semantics(
            child: Image.file(File(_imageFile.path)), label: "IAMGEN");
      } else if (_pickImageError != null) {
        return Text(
          'Pick image error: $_pickImageError',
          textAlign: TextAlign.center,
        );
      } else {
        return //Texto(Config.colorAPP, AppLocalization.of(context).imagen,20,Colors.grey
            Image.asset('assets/img/jugador.png');
      }
    }

    FormField inputScouter = new FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: "Agente FootFeel",
        ),
        items: scouter.map<DropdownMenuItem<String>>((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )));
        }).toList(),
        value: _scouter,
        validator: (value) => value == null ? '' : null,
        isDense: true,
        onChanged: (value) {
          setState(() {
            //newContact.favoriteColor = newValue;
            _scouter = value;
            widget.jugador.scouter = value;
            cambio = true;
            state.didChange(value);
          });
        },
      );
    });

    ListView body = ListView(padding: EdgeInsets.all(0), children: <Widget>[
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10, left: 5.0),
                child: Image.network(
                    Config.escudoClubesFF(widget.jugador.equipo),
                    height: 25),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 5.0),
                  child: Text('${widget.jugador.equipo}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ))),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                BBDDService().getUserScout().puesto == "FootFeel"
                    ? Container(
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    "Jugador FF",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Config.colorFootFeel),
                  ),
                ):Container(),
                BBDDService().getUserScout().puesto == "FootFeel"
                    ? Switch(
                  value: widget.jugador.firmado,
                  onChanged: (newValue) {
                    setState(() {
                      widget.jugador.firmado = newValue;
                      print(widget.jugador.firmado);
                    });
                  },
                  activeTrackColor: Config.colorFootFeel,
                  activeColor: Config.colorFootFeel,
                ):Container(),
                // Container(
                //   padding: EdgeInsets.only(left: 5,right: 10, top: 5), child: picture),
              ],
            ),
            (widget.jugador.firmado == false &&  BBDDService().getUserScout().puesto!= "Marketing")?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    "Proceso",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red.shade700),
                  ),
                ),
                Switch(
                  value: widget.jugador.proceso,
                  onChanged: (newValue) {
                    setState(() {
                      widget.jugador.proceso = newValue;
                      print(widget.jugador.proceso);
                    });
                  },
                  activeTrackColor: Colors.red.shade700,
                  activeColor: Colors.red.shade700,
                ),
               Container(
                  width: 178,
                  padding: EdgeInsets.only(left: 15, right: 5),
                  child: inputScouter,
                )
              ],
            ):Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 230,
                    padding: EdgeInsets.only(left: 10),
                    child: inputNombre),
                Container(
                    width: 120,
                    padding: EdgeInsets.only(left: 10),
                    child: inputApodo),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                FlatButton(
                  minWidth: 1,
                  onPressed: callDatePicker,
                  padding: EdgeInsets.only(left: 0.0),
                  child: Icon(
                    CustomIcon.birthday_cake,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                  child: _fecha == null
                      ? Text(
                          "",
                          textScaleFactor: 1.0,
                        )
                      : Text(
                          "$_fecha",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    widget.jugador.edadCategoria(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red.shade700),
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: inputPaises),
            Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: inputCompeticiones),
            Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: inputEquipo),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 200,
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: inputCategoria),
                Container(
                    width: 150,
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: inputCatCantera),
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: inputPosicion),
            Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: inputPosicion2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: ToggleSwitch(
                      minWidth: 100,
                      minHeight: 30,
                      initialLabelIndex:
                          Config.getValue(widget.jugador.lateral),
                      activeBgColor: Colors.blue[900],
                      inactiveBgColor: Colors.grey[300],
                      inactiveFgColor: Colors.black,
                      fontSize: 12,
                      labels: [
                        'Derecho',
                        'Izquierdo',
                        'Ambidiestro',
                        'unknown'
                      ],
                      onToggle: (index) {
                        print(index);
                        setState(() {
                          print(_lateral);

                          _lateral = Config.lateral[index];
                          widget.jugador.lateral = _lateral;
                          cambio = true;
                        });
                      },
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 100,
                    padding: EdgeInsets.only(left: 20),
                    child: inputAltura),
                Container(
                    width: 100,
                    padding: EdgeInsets.only(left: 20),
                    child: inputPeso),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 250,
                    padding: EdgeInsets.only(left: 10),
                    child: inputNacionalidad1),
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: inputSelecciones),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 250,
                    padding: EdgeInsets.only(left: 10),
                    child: inputNacionalidad2),
              ],
            ),
            /* Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: ToggleSwitch(
                        minWidth: 110,
                        minHeight: 30,
                        initialLabelIndex:
                            Config.getValue(widget.jugador.nacionalidad),
                        activeBgColor: Colors.blue[900],
                        inactiveBgColor: Colors.grey[300],
                        inactiveFgColor: Colors.black,
                        fontSize: 12,
                        labels: ['Nacional', 'Extranjero'],
                        onToggle: (index) {
                          setState(() {
                            _extranjero = Config.extranjero[index];
                            widget.jugador.nacionalidad = _extranjero;
                            cambio = true;
                          });
                        },
                      )),
                ],
              ),*/
            Container(
              height: 50,
              padding: EdgeInsets.only(right: 10, top: 5),
            ),
          ],
        ),
      )
    ]);
    return Scaffold(body: body);
  }

  Future<bool> _showGrabar(BuildContext context) {
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
                height: 18,
              ),
              Text('El jugador\n${widget.jugador.jugador}'),
              Container(
                height: 18,
              ),
              Text('se ha grabado'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
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
                Navigator.of(context).pop();
                Navigator.pop(context, true);
                return true; // showDialog() returns true
              },
            ),
          ],
        );
      },
    );
  }

  Future uploadFile(String foto) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    // if (permissionStatus.isGranted) {
    //Select Image

    var file = File(_imageFile.path);

    if (_imageFile != null) {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;

      Im.Image image = Im.decodeImage(file.readAsBytesSync());
      image = Im.copyResize(
        image,
        width: 500,
      );
      // choose the size here, it will maintain aspect ratio
      var compressedImage = new File('$path/img_copy.png')
        ..writeAsBytesSync(Im.encodePng(image, level: 4));

      //Upload to Firebase
      var snapshot = await _storage
          .ref()
          .child('jugadores/$foto')
          .putFile(compressedImage);

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('No Path Received');
    }
    /* } else {
      print('Grant Permissions and try again');
    }*/
  }
}
