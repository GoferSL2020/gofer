import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toggle_switch/toggle_switch.dart';


class EditJugador extends StatefulWidget {
  static String tag = 'edit-page';
  final Equipo equipo;
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;
  final Player jugador;

  EditJugador(
      {@required this.equipo,
        @required this.temporada,
        @required this.categoria,
        @required this.pais,
        @required this.jugador
      });


  @override
  _EditJugadorState createState() => _EditJugadorState();
}
class _EditJugadorState extends State<EditJugador> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _altura = TextEditingController();
  final _peso = TextEditingController();
  final _dorsal = TextEditingController();
  final _apellido = TextEditingController();
  final _CCAA = TextEditingController();
  final _provincia = TextEditingController();
  String _extranjero =  "Español";
  final _jugador = TextEditingController();
  final _movil = TextEditingController();
  final _email = TextEditingController();
  final _valor = TextEditingController();
  var _fecha;
  var _fechaContrato;

  bool _prestamo = false;
  String _puesto = "";
  String _lateral = "derecho";
  String _puesto2 = "";
  String _id = "";
  PickedFile _imageFile;
  String imageUrl;
  File _image;
  bool insertar=false;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  List<String> _posicion = <String>[
    '',
    'PORTERO',
    'LATERAL DERECHO',
    'LATERAL IZQUIERDO',
    'CENTRAL',
    'DEFENSA CENTRAL DERECHO',
    'DEFENSA CENTRAL IZQUIERDO',
    'CARRILERO DERECHO',
    'CARRILERO IZQUIERDO',
    'PIVOTE',
    'MEDIOCENTRO',
    'MEDIOCENTRO DERECHO',
    'MEDIOCENTRO IZQUIERDO',
    'VOLANTE DERECHO',
    'VOLANTE IZQUIERDO',
    'INTERIOR IZQUIERDO',
    'INTERIOR DERECHO',
    'MEDIAPUNTA',
    'MEDIAPUNTA DERECHO',
    'MEDIAPUNTA IZQUIERDO',
    'EXTREMO IZQUIERDO',
    'EXTREMO DERECHO',
    'DELANTERO',
    'DELANTERO CENTRO'
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
    _provincia.dispose();

    _CCAA.dispose();
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
    _nombre.text = widget.jugador.jugador;
    _valor.text=widget.jugador.valor;
    _prestamo=widget.jugador.prestamo=="si"?true:false;
    _fecha = widget.jugador.fechaNacimiento;
    _fechaContrato = widget.jugador.fechaContrato;
    _CCAA.text= widget.jugador.ccaa;
    _provincia.text = widget.jugador.paisNacimiento;
    _extranjero = widget.jugador.nacionalidad;
    _altura.text = widget.jugador.altura;
    _peso.text = widget.jugador.peso;
    _lateral = widget.jugador.lateral.toLowerCase();
    _dorsal.text = widget.jugador.dorsal.toString();
    _puesto = widget.jugador.posicion.toUpperCase();
    _puesto2 = widget.jugador.posicionalternativa.toUpperCase();
    insertar= widget.jugador.jugador==""?true:false;


    //_imageFile=Image.network(widget.jugador.imagen));
    //_imageFile;

    super.initState();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

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
              radius: 55    ,
              backgroundColor: Colors.black,
              child: ClipOval(
                child: new SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: _imageFile != null
                    //https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/
                        ? Image.file(File(_imageFile.path), fit: BoxFit.fill)
                        : Image.network(
                      Config.imagenJugador(widget.equipo, widget.jugador,)
                      ,
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
          labelText: "Poner el 1º puesto",
        ),
        isEmpty: _puesto == '',
        child: new DropdownButtonFormField(
          items: _posicion.map((String value) {
            return new DropdownMenuItem(
                value: value,
                child: new Text(value, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  color: Colors.blue,
                ))
            );
          }).toList(),
          value: _puesto,
          validator: (value) => value == null ? 'Poner el 1º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _puesto = value;
              state.didChange(value);
            });
          },
        ),
      );
    });

    FormField inputPosicion2 = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Poner el 2º puesto",
        ),
        isEmpty: _puesto2 == '',
        child: new DropdownButtonFormField(
          items: _posicion.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: Colors.black,
              )),
            );
          }).toList(),
          value: _puesto2,
          //validator: (value) => value == null ? 'Poner el 2º puesto' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              _puesto2 = value;
              state.didChange(value);
            });
          },
        ),
      );
    });


    TextFormField inputNombre = TextFormField(
      controller: _nombre,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nombre',
        icon: Icon(CustomIcon.futbolista_4, color: Colors.black,),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );

    TextFormField inputValor = TextFormField(
      controller: _valor,
      inputFormatters: [
        LengthLimitingTextInputFormatter(9),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Valor mercado',
        icon: Icon(Icons.monetization_on_outlined, color: Colors.black,),
      ),
    );

    TextFormField inputProvincia = TextFormField(
      controller: _provincia,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Provincia',
        icon: Icon(Icons.home_work_outlined, color: Colors.black,),
      ),
    );
    TextFormField inputCCCA = TextFormField(
      controller:_CCAA,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'CCAA',
        icon: Icon(Icons.home_work_sharp, color: Colors.black,),
      ),
    );
    TextFormField inputDorsal = TextFormField(
      controller: _dorsal,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Dorsal',
        icon: Icon(CustomIcon.camiseta, color: Colors.black,),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );
    TextFormField inputPeso = TextFormField(
      controller: _peso,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Peso',
        icon: Icon(CustomIcon.weight, size: 20, color: Colors.black,),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );
    TextFormField inputAltura = TextFormField(
      controller: _altura,
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Altura',
        icon: Icon(Icons.accessibility, color: Colors.black,),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );



    Future<DateTime> getDate() {
      // Imagine that this function is
      // more complex and slow.
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2050),
        locale : const Locale("es","ES"),
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
      });
    }

    void callDatePickerContrato() async {
      var order = await getDate();
      setState(() {
        _fechaContrato = DateFormat('dd/MM/yyyy').format(order);
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

    ListView body = ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            color: Colors.black,
            padding: EdgeInsets.all(8.0),
            child:Center(
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.network(Config.escudoClubes(widget.equipo.equipo),
                          height:25),
                      Texto(Colors.white, "${widget.equipo.equipo}".toUpperCase(),
                          14, Colors.black, false)
                    ]))),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                child:
                Texto(Config.colorAPP, "Detalle del jugador", 12, null, false),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      padding: EdgeInsets.only(right: 10),
                      child:
                      picture
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(width: 230,
                      padding: EdgeInsets.only(left: 10),
                      child: inputNombre),
                  Container(width: 100,
                      padding: EdgeInsets.only(left: 20),child:
                      inputDorsal),
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
                      Icons.date_range,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Container(

                    padding:
                    EdgeInsets.symmetric(horizontal:5.0, vertical: 15),
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

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      width: 325,
                      padding: EdgeInsets.all(10.0),
                      child: ToggleSwitch(
                        minWidth: 100,
                        minHeight: 30,
                        initialLabelIndex:
                        Config.getValue(widget.jugador.lateral.toLowerCase()),
                        activeBgColor: Colors.blue[900],
                        inactiveBgColor: Colors.grey[300],
                        inactiveFgColor: Colors.black,
                        fontSize: 12,
                        labels: ['derecho', 'izquierdo','unknown'],
                        onToggle: (index) {
                          print(index);
                          setState(() {
                            _lateral=Config.lateral[index];
                            widget.jugador.lateral=Config.lateral[index];
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
                  Container(width: 180,
                      padding: EdgeInsets.all(5),child:
                      inputPosicion)
                  ,
                  Container(width: 180,
                      padding: EdgeInsets.all(5),child:
                      inputPosicion2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(width: 100,
                      padding: EdgeInsets.only(left: 20),child:
                      inputAltura),
                  Container(width: 100,
                      padding: EdgeInsets.only(left: 20),child:
                      inputPeso),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(width: 170,
                      padding: EdgeInsets.only(left: 10),child:
                      inputValor),
                  FlatButton(
                    minWidth: 1,
                    onPressed: callDatePickerContrato,
                    padding: EdgeInsets.only(left: 30.0),
                    child: Icon(
                      Icons.date_range,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                        child: new Text("En prestamo",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ))),
                    Switch(
                      value: _prestamo,
                      onChanged: (newValue) {
                        setState(() {
                          _prestamo=newValue;
                        });
                      },
                      activeTrackColor: Colors.blue[900],
                      activeColor: Colors.blue[900],
                    ),
                  ]),
              Row(
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
                        labels: widget.jugador.categoria.contains("Argentina")?['Argentina', 'Extranjero']:['Nacional', 'Extranjero','Nacionalizado'],
                        onToggle: (index) {
                          setState(() {
                            _extranjero=widget.jugador.categoria.contains("Argentina")?
                            Config.extranjeroArgentino[index]
                                :Config.extranjero[index];
                            widget.jugador.nacionalidad=_extranjero;
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
                  Container(width: 350,
                      padding: EdgeInsets.only(left: 10),child:
                      inputProvincia),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(width: 350,
                      padding: EdgeInsets.only(left: 10),
                      child: inputCCCA),
                ],
              ),
            ],
          ),
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[

            Container(
              width: 80,
              child: IconButton(
                  icon:
                  Icon(Icons.save_outlined,size: 30, color: Colors.blue,),

                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      widget.jugador.jugador=_nombre.text;
                      //widget.jugador.fechaNacimiento=_fecha.toString();
                      widget.jugador.dorsal=int.parse(_dorsal.text);
                      widget.jugador.peso=_peso.text;
                      widget.jugador.altura=_altura.text;
                      widget.jugador.valor=_valor.text;
                      widget.jugador.prestamo=_prestamo==false?"no":"si";
                      widget.jugador.fechaNacimiento=_fecha.toString();
                      widget.jugador.fechaContrato=_fechaContrato.toString();
                      widget.jugador.posicion=_puesto;
                      widget.jugador.posicionalternativa=_puesto2;
                      widget.jugador.lateral=_lateral;
                      widget.jugador.ccaa=_CCAA.text;
                      widget.jugador.paisNacimiento=_provincia.text;
                      widget.jugador.lateral=_lateral;
                      widget.jugador.nacionalidad=_extranjero;
                      widget.jugador.idCategoria=widget.categoria.id;
                      widget.jugador.idPais=widget.pais.id;
                      widget.jugador.idTemporada=widget.temporada.id;
                      widget.jugador.idEquipo=widget.equipo.id;
                      CRUDJugador con = CRUDJugador();
                      if(insertar) {
                        await con.addJugadorDatos(
                            widget.temporada, widget.pais, widget.categoria,
                            widget.equipo, widget.jugador);
                      }else {
                        con.updateJugadorDatos(widget.temporada,widget.pais,widget.categoria,widget.equipo,widget.jugador);
                      }
                      //jugadorService.updateJugadorIAScout(widget.jugador,false);
                      //ProductManager().insert(widget.jugador);
                      if(_imageFile!=null)
                        await uploadFile(widget.jugador.foto());
                      _showGrabar(context);
                    }
                  }),
            )
          ],
          backgroundColor: Colors.black,
          title: Text("IAScout -Jugador",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        body: body);
  }


  Future<bool> _showGrabar(
      BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('ATENCIÓN', style: TextStyle(
            fontSize: 18, decoration: TextDecoration.underline,)),
          content:
          Column(children: [
            Container(height: 18,),
            Text('El jugador\n${widget.jugador.jugador}'),
            Container(height: 18,),
            Text('se ha grabado'.toUpperCase(), style: TextStyle(
              color: Colors.black,
              fontSize: 18,)),
            Container(height: 10,),
          ],),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar',
                  style: TextStyle(fontSize: 16, color: Colors.green[900])),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
      //Upload to Firebase
      var snapshot =
      await _storage.ref().child('jugadores/$foto').putFile(file);

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
