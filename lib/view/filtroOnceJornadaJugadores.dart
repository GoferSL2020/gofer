

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/view/onceFiltros.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:image_picker/image_picker.dart';

class FiltroOnceJugadores extends StatefulWidget {

  FiltroOnceJugadores({this.categoria}) ;
  final String categoria;
  @override
  _FiltroOnceJugadoresState createState() => _FiltroOnceJugadoresState();
 }

class _FiltroOnceJugadoresState extends State<FiltroOnceJugadores> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  String jornadas;
  String categoriaAux;

  bool isLoading = false;
  PickedFile _imageFile;
  String imageUrl;

  FirebaseDatabase _database = FirebaseDatabase.instance;


  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  TextEditingController jugadorNombre = TextEditingController();

  List<String> _jornadas= <String>
  [ '','1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '101',
    '102',
    '103',
  ];

  List<String> _categoria2021 = <String>
  [ '',
    '2ª División A',
    '1ª División RFEF Grupo 1',
    '1ª División RFEF Grupo 2',
    '2ª División RFEF Grupo 1',
    '2ª División RFEF Grupo 2',
    '2ª División RFEF Grupo 3',
    '2ª División RFEF Grupo 4',
    '2ª División RFEF Grupo 5',
  ];

  List<String> _categoria = <String>
  [ "",
    '2ª División A',
    '2ª División B Grupo 1',
    '2ª División B Grupo 2',
    '2ª División B Grupo 3',
    '2ª División B Grupo 4' ,
    '2ª División B Grupo 5',
  ];


  List<String> _temporadas= <String>
  ["2021-2022","2020-2021",
  ];


  String temporadaAux="";

  @override
  void initState() {

    temporadaAux=_temporadas.first;
    categoriaAux=widget.categoria==null?"":widget.categoria;
    setState(() {
    });
    // TODO: implement initState


    super.initState();
  }



  @override
  void dispose() {

    super.dispose();
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
        title: Text("IAScout - Filtro once de la jornada",
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
                        FormField(
                            builder: (FormFieldState state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  labelText: "Selecciona la temporada",
                                ),
                                isEmpty: temporadaAux == '',
                                child: new DropdownButtonFormField(
                                  items: _temporadas.map((String value) {
                                    return new DropdownMenuItem(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  value: temporadaAux,
                                  validator: (value) =>
                                  value == null
                                      ? 'Selecciona la temporada' : null,
                                  isDense: true,
                                  onChanged: (value) {
                                    setState(() {
                                      //newContact.favoriteColor = newValue;
                                      temporadaAux = value;
                                      state.didChange(value);
                                    });
                                  },
                                ),
                              );
                            }),
                      ]),
                        TableRow(
                            children: [
                              FormField(
                                  builder: (FormFieldState state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: "Selecciona la categoria",
                                      ),
                                      isEmpty: categoriaAux == '',
                                      child: new DropdownButtonFormField(
                                        items: temporadaAux=="2020-2021"?_categoria.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList():
                                        _categoria2021.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: categoriaAux,
                                        validator: (value) =>
                                        value == null
                                            ? 'Selecciona la categoria' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //newContact.favoriteColor = newValue;
                                            categoriaAux = value;
                                            state.didChange(value);
                                          });
                                        },
                                      ),
                                    );
                                  }),
                            ]),
                        TableRow(
                            children: [
                              FormField(
                                  builder: (FormFieldState state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: "Selecciona la jornada",
                                      ),
                                      isEmpty: jornadas == '',

                                      child: new DropdownButtonFormField(
                                        items: _jornadas.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: jornadas,
                                        validator: (value) =>
                                        value == null
                                            ? 'Selecciona la jornada' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //newContact.favoriteColor = newValue;
                                            jornadas = value;
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
                    :
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    RaisedButton.icon(
                    onPressed: () async {

                  try {
                  setState(() {
                  isLoading = true;
                  });
                  setState(() {
                  Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => OnceFiltroPage(categoriaAux,jornadas,temporadaAux),
                  ));

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
                  },
                  label: Text(
                    "Mejores de la jornada ",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  icon: Icon(
                    CustomIcon.futbolista_4,
                    size: 20,
                    color: Colors.white,
                  ),
                  textColor: Colors.black,
                  splashColor: Colors.black,
                  color: Colors.blue),
              ]),
          )])),
    );
  }

}


