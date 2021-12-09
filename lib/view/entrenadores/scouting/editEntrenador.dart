import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as ImageLib;
import 'package:toggle_switch/toggle_switch.dart';


class EditEntrenador extends StatefulWidget {
  static String tag = 'edit-page';
  final Equipo equipo;
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;
  final Entrenador entrenador;

  EditEntrenador(
      {@required this.equipo,
        @required this.temporada,
        @required this.categoria,
        @required this.pais,
        @required this.entrenador
      });


  @override
  _EditEntrenadorState createState() => _EditEntrenadorState();
}
class _EditEntrenadorState extends State<EditEntrenador> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _altura = TextEditingController();
  final _peso = TextEditingController();
  final _dorsal = TextEditingController();
  final _scout = TextEditingController();
  final _CCAA = TextEditingController();
  final _provincia = TextEditingController();
  final _nacionalidad = TextEditingController();
  String _activo =  "Activo";

  final _valor = TextEditingController();
  var _fecha;
  var _fechaFichaje;
  var _fechaFinContrato;

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



  @override
  void dispose() {
    _nombre.dispose();
    _provincia.dispose();
    _nacionalidad.dispose();
    _scout.dispose();
    _CCAA.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _nombre.text = widget.entrenador.entrenador;
    _fecha = widget.entrenador.fechaNacimiento;
    _CCAA.text= widget.entrenador.ccaa;
    _provincia.text = widget.entrenador.paisNacimiento;
    _nacionalidad.text = widget.entrenador.nacionalidad;
    _activo = widget.entrenador.activo;
    _fechaFichaje=widget.entrenador.fechaFichaje;
    _fechaFinContrato=widget.entrenador.fechaFinContrato;
    _scout.text=widget.entrenador.scout;

    insertar= widget.entrenador.entrenador==""?true:false;
    //_imageFile=Image.network(widget.entrenador.imagen));
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
                        ? Image.file(File(_imageFile.path), fit: BoxFit.fill)
                        : Image.network(
                      Config.imagenEntrenador(widget.entrenador,)
                      ,
                      fit: BoxFit.fitHeight,
                    )),
              ),
            ),
          ),
        )
      ],
    );


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

    TextFormField inputScout = TextFormField(
      controller: _scout,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'URL',
        icon: Icon(CustomIcon.safari,size: 20, color: Colors.black,),
      ),
      validator: (value) {

      },
    );

    TextFormField inputNacionalidad = TextFormField(
      controller: _nacionalidad,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nacionalidad',
        icon: Icon(Icons.home_work_outlined, color: Colors.black,),
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
        _fechaFinContrato = DateFormat('dd/MM/yyyy').format(order);
      });
    }
    void callDatePickerFichaje() async {
      var order = await getDate();
      setState(() {
        _fechaFichaje = DateFormat('dd/MM/yyyy').format(order);
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
          Image.asset('assets/img/entrenador.png');
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
                  Container(width: 280,
                      padding: EdgeInsets.only(left: 10),
                      child: inputNombre),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding:
                    EdgeInsets.only(right: 5.0),

                  ),
                  Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                      child:  Text("Fecha Nacimiento:      ",
                        textScaleFactor: 1.0,
                      )
                  ),
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

              Container(width: double.infinity,
                      padding: EdgeInsets.all(5),
                  child:
                      inputScout),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding:
                    EdgeInsets.only(right: 5.0),

                  ),Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                    child:  Text("Fecha Fichaje:         ",
                      textScaleFactor: 1.0,
                    )
                  ),
                  FlatButton(
                    minWidth: 1,
                    onPressed: callDatePickerFichaje,
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
                    child: _fechaFichaje == null
                        ? Text(
                      "",
                      textScaleFactor: 1.0,
                    )
                        : Text(
                      "$_fechaFichaje",
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
                      EdgeInsets.only(right: 5.0),

                  ),
                  Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                      child:  Text("Fecha Fin Contrato:",
                        textScaleFactor: 1.0,
                      )
                  ),
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
                    child: _fechaFinContrato == null
                        ? Text(
                      "",
                      textScaleFactor: 1.0,
                    )
                        : Text(
                      "$_fechaFinContrato",
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
                      width: 185,
                      padding: EdgeInsets.all(10.0),
                      child: ToggleSwitch(
                        minWidth: 80,
                        minHeight: 30,
                        initialLabelIndex:
                        Config.getValue(widget.entrenador.activo),
                        activeBgColor: Colors.blue[900],
                        inactiveBgColor: Colors.grey[300],
                        inactiveFgColor: Colors.black,
                        fontSize: 12,
                        labels:['Activo', 'Inactivo'],
                        onToggle: (index) {
                          _activo=widget.entrenador.categoria.contains("Argentina")?
                          Config.extranjeroArgentino[index]
                              :Config.extranjero[index];
                        },
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(width: 300,
                      padding: EdgeInsets.only(left: 10),child:
                      inputNacionalidad),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(width: 300,
                      padding: EdgeInsets.only(left: 10),child:
                  inputProvincia),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(width: 300,
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
                      widget.entrenador.entrenador=_nombre.text;
                      //widget.entrenador.fechaNacimiento=_fecha.toString();
                      widget.entrenador.fechaNacimiento=_fecha.toString();
                      widget.entrenador.ccaa=_CCAA.text;
                      widget.entrenador.paisNacimiento=_provincia.text;
                      widget.entrenador.nacionalidad=_nacionalidad.text;
                      widget.entrenador.activo=_activo;
                      widget.entrenador.fechaFinContrato=_fechaFinContrato.toString();
                      widget.entrenador.fechaFichaje=_fechaFichaje.toString();
                      widget.entrenador.scout=_scout.text;

                      CRUDEntrenador con = CRUDEntrenador();
                      if(insertar)
                        con.addEntrenadorDatos(widget.temporada,widget.pais,widget.categoria,widget.equipo,widget.entrenador);
                      //con.updateEntrenadorDatos(widget.temporada,widget.pais,widget.categoria,widget.equipo,widget.entrenador);
                      else
                        con.updateEntrenadorDatos(widget.temporada,widget.pais,widget.categoria,widget.equipo,widget.entrenador);
                      //jugadorService.updateJugadorIAScout(widget.entrenador,false);
                      //ProductManager().insert(widget.entrenador);
                      if(_imageFile!=null)
                        await uploadFile(widget.entrenador.foto());
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
            Text('El entrenador\n${widget.entrenador.entrenador}'),
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
                return true; // showDialog() returns true
              },
            ),
          ],
        );
      },
    );
  }

  Future uploadFile(String foto) async {
    print("UPLLOAD");
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    // if (permissionStatus.isGranted) {
    //Select Image
    print("STORAGE:${_imageFile.path}");

    var file = File(_imageFile.path);
    print("STORAGE:${_imageFile.path}");

    if (_imageFile != null) {
      //Upload to Firebase
      var snapshot =
      await _storage.ref().child('entrenadores/$foto').putFile(file);

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
