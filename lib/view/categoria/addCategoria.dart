
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';



class AddCategoria extends StatefulWidget {
  @override
  _AddCategoriaState createState() => _AddCategoriaState();
}

class _AddCategoriaState extends State<AddCategoria> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
   TextEditingController temporadaController = TextEditingController();



  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Config.fondo,
        appBar:new  AppBar(
          actions: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 40,
                      child: IconButton(
                          icon: Icon(Icons.save_outlined,size: 30, color: Colors.blue,),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              var a= registrar(context);
                              if (a==null) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          })),
                  Container(
                      width: 50,
                      child: IconButton(
                        icon:
                        new Image.asset(Config.icono),

                        onPressed: () {
                          //var a = singOut();
                          //if (a != null) {

                          //}
                        },
                      ))]
            )
        ],
          backgroundColor:Colors.black,
          title: Text("iafootfeel -Añadir temporada",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  /*Row(children: [
                    Padding(
                        padding: EdgeInsets.only(top:20.0, left:20, right: 20, bottom: 5),
                        child:Texto(Colors.blue.shade900, "Puesto",14, Colors.white, true)
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:20.0, left:20, right: 20, bottom: 5),
                      child:DropdownButton(
                        value: _currentPuesto,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                    ),

                  ]),*/

                  Padding(
                    padding: EdgeInsets.only(top:5.0, left:20, right: 20, bottom: 5),
                    child:
                    TextFormField(
                      controller: temporadaController,
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.calendar_today_outlined),
                          hintText: 'Introduzca la temporada',
                          labelText: 'Categoria'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Categoria';
                        }
                        return null;
                      },
                    ),
                  ),
                ]))));
  }


  int _state = 0;
  Widget setUpButtonChild(){
    if(_state == 0){
      return new Text(
        "Registrar",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }else if(_state == 1){
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }else{
      return new Text(
        "Registrar",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }
  }
  void animateButton(){
    setState(() {
      _state = 1;
    });
    Timer(Duration(seconds: 60),(){
      setState(() {
        _state = 2;
      });
    });
  }
  registrar(BuildContext context) async {
    final _auth = FirebaseAuth.instance;

    try {
      FirebaseFirestore.instance.collection("temporadas").doc().set(
        {
          'temporada': temporadaController.text,
          'año': temporadaController.text.split("/")[0],
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }


  @override
  void dispose() {
    super.dispose();
    temporadaController.dispose();
  }
}
