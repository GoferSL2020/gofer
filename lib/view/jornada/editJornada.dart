import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDJornada.dart';

import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class EditJornada extends StatefulWidget {
  static String tag = 'edit-page';
  final Temporada temporada;
  final Pais pais;
  final Categoria categoria;
  final Jornada jornada;

  EditJornada(
      {
        @required this.temporada,
        @required this.pais,
        @required this.categoria,
        @required this.jornada,
      });

  @override
  _EditJornadaState createState() => _EditJornadaState();
}

class _EditJornadaState extends State<EditJornada> {
  final _formKey = GlobalKey<FormState>();
  final _jornada = TextEditingController();
  var _fecha;

  String imageUrl;
  bool insertar = false;
  dynamic _pickImageError;

  CRUDEquipo dao=CRUDEquipo();
  List<Equipo> contrarios=List();


  @override
  void dispose() {

    super.dispose();
  }

  @override
  void initState() {
    _fecha = widget.jornada.fecha;
    _jornada.text =
        widget.jornada.jornada.toString();
    insertar = widget.jornada.jornada == 0 ? true : false;

    //_imageFile=Image.network(widget.partido.imagen));
    //_imageFile;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dao = new CRUDJornada();
    TextFormField inputJornada = TextFormField(
      controller: _jornada,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Jornada',
        icon: Icon(Icons.timer),
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
        firstDate: DateTime(1980),
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
      });
    }


    ListView body = ListView(
      children: <Widget>[
        Container(
          height: 30,
          width: double.infinity,
          color:Colors.black,
          child:Text(
            widget.temporada.temporada,
            textAlign: TextAlign.center,
            style: TextStyle(color: Config.colorAPP,
                fontSize: 16,
                fontStyle: FontStyle.italic),
          ),),
        Container(
          height: 30,
          width: double.infinity,
          color:Colors.black,
          child:Text(
            widget.categoria.categoria,
            textAlign: TextAlign.center,
            style: TextStyle(color: Config.colorAPP,
                fontSize: 16,
                fontStyle: FontStyle.italic),
          ),),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:10,bottom: 16.0),
                child:
                    Texto(Colors.blue[900], "Detalle la jornada", 14, null, false),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      width: 100,
                      padding: EdgeInsets.only(left: 10, right: 20),
                      child: inputJornada),
                  FlatButton(
                    minWidth: 1,
                    onPressed: callDatePicker,
                    padding: EdgeInsets.only(left: 0.0),
                    child: Icon(
                      Icons.date_range,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 15),
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

            ],
          ),
        )
      ],
    );

    return Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            Container(
              width: 40,
              child: IconButton(
                  icon: Icon(
                    Icons.save_outlined,
                    size: 30,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                      if (_fecha.toString().compareTo("")!=0) {
                        if( (_formKey.currentState.validate()) &&(_fecha.toString().compareTo("")!=0)){
                          _formKey.currentState.save();
                          widget.jornada.fecha = _fecha;
                          widget.jornada.jornada =
                              int.parse(inputJornada.controller.text);
                          if (insertar) {
                            await dao.addJornada(
                                widget.temporada, widget.categoria, widget.pais, widget.jornada);
                          } else {
                            await dao.updateJornada(widget.temporada, widget.categoria, widget.pais, widget.jornada);
                          }
                          Navigator.pop(context);
                          }
                      //Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      //    PartidoesView(temporada: widget.temporada, equipo: widget.equipo)));
                    }else{
                        Fluttertoast.showToast(
                            msg: "Poner la fecha del partido",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red.shade900,
                            textColor: Colors.white,
                            fontSize: 14.0
                        );
                      }
                  }),
            ),
          ],
          backgroundColor: Colors.black,
          title: Text("IAScout -Añadir Partido",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBar: Abajo(
          temporada: widget.temporada,
        ),
        body: body);
  }

  /*EquipoContrario campoEquipo() {
    final campo =
    contrarios.firstWhere((element) =>
    element.equipo == _equipoContrario,
        orElse: () {
          return null;
        });
    return campo;
  }*/
}
