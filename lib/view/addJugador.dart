
import 'dart:io';

import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/sheets/gsheets.dart';
import 'package:iadvancedscout/sheets/gsheetsSCOUT.dart';
import 'package:iadvancedscout/view/paises.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

class AddJugador extends StatefulWidget {

  AddJugador(this.equipo) ;

  @override
  _AddJugadorState createState() => _AddJugadorState();
  final Equipo equipo;
}

class _AddJugadorState extends State<AddJugador> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Jugador jugador;
  String jugadorPosicion;
  bool isLoading = false;
  PickedFile _imageFile;
  String imageUrl;

  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  TextEditingController jugadorNombre = TextEditingController();
  List<String> _posicion = <String>
  [ 'Portero',
    'Lateral derecho',
    'Lateral izquierdo',
    'Central',
    'Central derecho',
    'Central izquierdo',
    'Carrilero derecho',
    'Carrilero izquierdo',
    'Pivote',
    'Medio centro izquierdo',
    'Medio centro derecho',
    'Volante derecho',
    'volante izquierdo',
    'Interior izquierdo',
    'Interior derecho',
    'Media punta',
    'Media punta izquierdo',
    'Media punta derecho',
    'Extremo izquierdo',
    'Extremo derecho',
    'Delantero'];


  @override
  void initState() {
    //uploadImage();
    // TODO: implement initState
    super.initState();
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,imageQuality: 20,
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

  @override
  void dispose() {

    super.dispose();
  }
  Widget _previewImage() {
    if (_imageFile != null) {
      return Semantics(
          child: Image.file(File(_imageFile.path)),
          label: "IAMGEN");
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {

      return  //Texto(Config.colorAPP, AppLocalization.of(context).imagen,20,Colors.grey
        Image.asset('assets/img/jugador.png');
    }
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
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  child:Center(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/clubes/${widget.equipo.equipo}.png', height: 25.0, width: 25.0),
                            Texto(Colors.white, "${widget.equipo.equipo}".toUpperCase(),
                                14, Colors.black, false)
                          ]))),

              Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child:Center(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Texto(Colors.black, "Añadir el jugador".toUpperCase(),
                                12, Colors.white, false)
                          ]))),
              new Container(
                  width: 200,height: 200,
                  padding: EdgeInsets.only(
                      top: 0.0, left: 0, right: 0, bottom: 20),
                  child:
                  _previewImage()
              ),
              Padding(
                  padding:
                  EdgeInsets.only( top: 5.0, left: 20, right:20, bottom: 5),
                  child: new Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(300.0),
                      },
                      defaultVerticalAlignment:
                      TableCellVerticalAlignment.middle,
                      //border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            FormField(builder: (FormFieldState state) {
                              return InputDecorator(
                                  decoration: InputDecoration(
                                    labelText:
                                    'Poner el nombre de jugador',
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.teal)),
                                  ),
                                  child: new TextFormField(
                                    controller: jugadorNombre,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Poner el nombre de jugador';
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (dam) {
                                      // aceptar(palabra.strPalabra);
                                    },
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ));
                            }),
                          ],
                        ),
                        TableRow(
                            children: [
                              FormField(
                                  builder: (FormFieldState state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: "Selecciona la posicición",
                                      ),
                                      isEmpty: jugadorPosicion == '',
                                      child: new DropdownButtonFormField(
                                        items: _posicion.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: jugadorPosicion,
                                        validator: (value) =>
                                        value == null
                                            ? 'Poner la posicición' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //newContact.favoriteColor = newValue;
                                            jugadorPosicion = value;
                                            state.didChange(value);
                                          });
                                        },
                                      ),
                                    );
                                  }),
                            ])
                      ])
              ),
              Padding(
                padding:
                EdgeInsets.only(top: 0.0, left: 20, right: 20, bottom: 5),
                child: isLoading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                    color: Colors.black,
                    shape: Border.all(color: Colors.black, width: 1.0),
                    child: Text("Aceptar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        )),
                    onPressed: () {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        setState(() {
                          insertJugador();
                        });
                        setState(() {
                          isLoading = false;
                        });

                      }catch(e){
                        setState(() {
                          isLoading=false;
                        });
                        e.toString();
                      }
                    }
                ),
              ),
            ],
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: "IMAGEN",

            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'image0',
              tooltip: "FOTO",
              child: const Icon(Icons.photo_library, color: Colors.white,),
            ),
          ),
          Padding(

            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton( backgroundColor: Colors.black,
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image1',
              tooltip: "FOTO",
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  void insertJugador() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      jugador=new Jugador(jugadorNombre.text, widget.equipo.equipo, widget.equipo.categoria, widget.equipo.pais, jugadorPosicion.toUpperCase(),null);
      jugador.id=("${jugadorNombre}${jugadorNombre}").toUpperCase().trim();
      form.save();
      form.reset();
      //uploadFile(jugador.id);
      //print(imageUrl);
      jugador.imagen = jugador.id;
      JugadorDao jugadorService = JugadorDao();
      jugadorService.addJugadorIAScout(jugador,true,0);
      jugadorService.addJugadorIAScout(jugador,false,0);
      ProductManager().insert(jugador);
      ProductManagerEXCELSCOUT().insert(jugador);
    }
  }


  Future uploadFile(String id) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    await Permission.photos.request();


    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      var file = File(_imageFile.path);
      //print("STORAGE:${_imageFile.path}");

      if (_imageFile != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('jugadores/$id')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        //print('No Path Received');
      }

    } else {
      //print('Grant Permissions and try again');
    }
  }


}


