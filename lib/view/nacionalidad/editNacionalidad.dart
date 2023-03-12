import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/dao/CRUDNacionalidad.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/nacionalidad.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/wigdet/abajo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

class EditNacionalidad extends StatefulWidget {
  static String tag = 'edit-page';
  final Nacionalidad  nacionalidad;
  EditNacionalidad(this.nacionalidad);

  @override
  _EditNacionalidadState createState() => _EditNacionalidadState();
}

class _EditNacionalidadState extends State<EditNacionalidad> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  bool insertar=false;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();


  @override
  void dispose() {
    _nombre.dispose();

    super.dispose();
  }

  @override
  void initState() {

    _nombre.text = widget.nacionalidad.nacionalidad;

    insertar= widget.nacionalidad.nacionalidad==""?true:false;

    super.initState();
  }
/*
  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,imageQuality: 20,
        maxHeight:  100 , maxWidth: 100);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }
*/



  @override
  Widget build(BuildContext context) {
    final provider = new CRUDNacionalidad();

    TextFormField inputNombre = TextFormField(
      controller: _nombre,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nacionalidad',
        icon: Icon(Icons.flag),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );



    ListView body = ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(width: double.infinity,
          color:Colors.black,
          child:Text(
            "Nacionalidad",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.italic),
          ),),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(width: 340,
                  padding: EdgeInsets.only(left: 10),child:
              inputNombre),
            ],
          ),
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[

            Container(
              width: 40,
              child: IconButton(
                  icon: Icon(Icons.save_outlined,size: 30, color: Colors.blue,),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.nacionalidad.nacionalidad = inputNombre.controller!.text.toUpperCase();
                       if(insertar) {
                          await provider.addEquipo(
                            widget.nacionalidad);
                      }else {
                        await provider.updateEquipo(
                            widget.nacionalidad);
                      }
                      Navigator.pop(context);
                    }
                  }),
            )
          ],
          backgroundColor: Colors.black,
          title: Text("FootFeel - Equipos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Config.colorFootFeel,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBar: Abajo(),
        body: body);
  }



}
