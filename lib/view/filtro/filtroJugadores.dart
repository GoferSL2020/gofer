

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDPais.dart';
import 'package:iadvancedscout/dao/CRUDTemporada.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/filtro/jugadoresFiltros.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:image_picker/image_picker.dart';

class FiltroPlayeres extends StatefulWidget {

  FiltroPlayeres() ;

  @override
  _FiltroPlayeresState createState() => _FiltroPlayeresState();
 }

class _FiltroPlayeresState extends State<FiltroPlayeres> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  String niveles;
  String posicion;
  String temporada="2021-2022";
  String tipo;
  String categoria=" ";
  double _edad=15;
  double _edad2=45;
  bool isLoading = false;
  PickedFile _imageFile;
  String imageUrl;
  TextEditingController _nombre = TextEditingController();
  TextEditingController _lugar = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(15, 44);


  FirebaseDatabase _database = FirebaseDatabase.instance;

  Player jugadorFiltro;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  List<Temporada> temporadas = List();
  List<Pais> paises = List();
  List<Categoria> categorias = List();
  Temporada _temporadaAux = new Temporada();
  Pais _paisAux = new Pais();
  Categoria _categoriaAux = new Categoria();

  List<Jornada> jornadas = List();


  Future<List<String>> get temporadasAux async {
    CRUDTemporada dao = CRUDTemporada();
    QuerySnapshot docs = await dao.getDataCollection();

    List<Temporada> datos = List();
    Temporada t = new Temporada();
    t.id = '';
    t.temporada = '';
    datos.add(t);

    for (var d in docs.docs) {
      Temporada t = new Temporada();
      t.id = d.id;
      t.temporada = d.data()['temporada'];
      datos.add(t);
    }

    setState(() {
      _temporadaAux = datos[0];
      temporadas = datos;
    });
  }

  _cogerPais() async {
    //print("PAIS");
    //print(_temporadaAux.id);
    List<Pais> datos = await CRUDPais().fetchPaises(_temporadaAux);
    setState(() {
      //print(datos[0].id);
      _paisAux = datos[0];
      paises.addAll(datos);
    });
  }

  _cogerCategorias() async {
    List<Categoria> datos =
    await CRUDCategoria().fetchCategorias(_temporadaAux, _paisAux);
    setState(() {
      _categoriaAux = datos[0];
      categorias.addAll(datos);
    });
  }


  List<String> _categoria2021 = <String>
  [ ' ',
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
  [ " ",
    '2ª División A',
    '2ª División B Grupo 1',
    '2ª División B Grupo 2',
    '2ª División B Grupo 3',
    '2ª División B Grupo 4' ,
    '2ª División B Grupo 5',
  ];

  List<String> _posicion = <String>
  [ 'TODOS','PORTERO',
    'LATERAL DERECHO',
    'LATERAL IZQUIERDO',
    'CENTRAL',
    'DEFENSA CENTRAL DERECHO',
    'DEFENSA CENTRAL IZQUIERDO',
    'CARRILERO DERECHO',
    'CARRILERO IZQUIERDO',
    'PIVOTE',
    'MEDIO CENTRO',
    'VOLANTE',
    'INTERIOR',
    'MEDIA PUNTA',
    'EXTREMO',
  //  'EXTREMO DERECHO',
    'DELANTERO'];
  List<String> _niveles= <String>
  [ " ",'N/A','Discreto',
    'Dudoso',
    'Intermedio',
    'Destacado',
    'Superior',
    'Superlativo',
  ];
  List<String> _tipo= <String>
  [ " "
  ];

  List<String> _temporadas= <String>
  ["2021-2022","2020-2021",
  ];

  @override
  void initState() {

    setState(() {
        temporadasAux;

      jugadorFiltro=new Player();

      jugadorFiltro.edadRange1=15;
      jugadorFiltro.edadRange2=44;
      _nombre.text="";
      _lugar.text="";
      jugadorFiltro.temporada="2021-2022";
      jugadorFiltro.posicion="TODOS";
      posicion="TODOS";
      jugadorFiltro.nivel="";
      jugadorFiltro.tipo="";
      niveles=" ";
      tipo=" ";
      jugadorFiltro.ofe_niveltecnico=false;
      jugadorFiltro.ofe_profundidad=false;
      jugadorFiltro.ofe_capacidaddegenerarbuenoscentrosalarea=false;
      jugadorFiltro.ofe_capacidaddeasociacion=false;
      jugadorFiltro.ofe_desborde=false;
      jugadorFiltro.ofe_superioridadpordentro=false;
      jugadorFiltro.ofe_finalizacion=false;
      jugadorFiltro.ofe_saquedebanda_longitud=false;
      jugadorFiltro.ofe_lanzadordeabps=false;
      jugadorFiltro.ofe_salidadebalon=false;
      jugadorFiltro.ofe_paselargo_medio=false;
      jugadorFiltro.ofe_cambiosdeorientacion=false;
      jugadorFiltro.ofe_batelineasconpaseinterior=false;
      jugadorFiltro.ofe_conduccionparadividir=false;
      jugadorFiltro.ofe_primerpasetrasrecuperacion=false;
      jugadorFiltro.ofe_intervieneenabps=false;
      jugadorFiltro.ofe_velocidadeneljuego=false;
      jugadorFiltro.ofe_incorporacionazonasderemate=false;
      jugadorFiltro.ofe_amplitud=false;
      jugadorFiltro.ofe_desmarquesdeapoyo=false;
      jugadorFiltro.ofe_desmarquesderuptura=false;
      jugadorFiltro.ofe_capacidaddegenerarbuenoscentroslateralesalarea=false;
      jugadorFiltro.ofe_habilidad1vs1=false;
      jugadorFiltro.ofe_realizaciondelultimopase=false;
      jugadorFiltro.ofe_goleador=false;
      jugadorFiltro.ofe_explotaciondeespacios=false;
      jugadorFiltro.ofe_duelosaereos=false;
      jugadorFiltro.ofe_desbordeporvelocidad=false;
      jugadorFiltro.ofe_dominiode2vs1_pared=false;
      jugadorFiltro.ofe_ambidextro=false;
      jugadorFiltro.ofe_juegodecara=false;
      jugadorFiltro.ofe_protecciondelbalon=false;
      jugadorFiltro.ofe_caidasabanda=false;
      jugadorFiltro.ofe_prolongacionesaereas=false;
      jugadorFiltro.ofe_dominiodelarea=false;
      jugadorFiltro.ofe_llegadaaposicionesderemate=false;
      jugadorFiltro.ofe_juegoesespacioreducido=false;
      jugadorFiltro.ofe_definidor_anteelportero=false;
      jugadorFiltro.ofe_rematador_finalizador=false;
      jugadorFiltro.ofe_capacidadasociativa_apoyosalalineadefensiva=false;
      jugadorFiltro.ofe_desplazamientoenlargo=false;
      jugadorFiltro.fis_velocidaddereaccion=false;
      jugadorFiltro.fis_velocidaddedesplazamiento=false;
      jugadorFiltro.fis_agilidad=false;
      jugadorFiltro.fis_fuerza_potencia=false;
      jugadorFiltro.fis_cuerpoacuerpo=false;
      jugadorFiltro.fis_capacidaddesalto=false;
      jugadorFiltro.fis_explosividad=false;
      jugadorFiltro.fis_potenciadesaltolateralyvertical=false;
      jugadorFiltro.fis_resistencia_idayvuelta=false;
      jugadorFiltro.fis_cambioderitmo=false;
      String _fis_envergadura="";
      jugadorFiltro.psic_liderazgo=false;
      jugadorFiltro.psic_comunicacion=false;
      jugadorFiltro.psic_seguridad=false;
      jugadorFiltro.psic_tomadedecisiones=false;
      jugadorFiltro.psic_agresividad=false;
      jugadorFiltro.psic_polivalencia=false;
      jugadorFiltro.psic_competitividad=false;
      jugadorFiltro.psic_agresividad_contundencia=false;
      jugadorFiltro.psic_noasumeriesgosextremos=false;
      jugadorFiltro.psic_entendimientodeljuego_inteligencia=false;
      jugadorFiltro.psic_creatividad=false;
      jugadorFiltro.psic_confianza=false;
      jugadorFiltro.psic_compromiso=false;
      jugadorFiltro.psic_valentia=false;
      jugadorFiltro.psic_oportunismo=false;
      jugadorFiltro.def_acoso_presionsobreeloponente=false;
      jugadorFiltro.def_actituddefensiva=false;
      jugadorFiltro.def_activaciondelosmecanismosdepresion=false;
      jugadorFiltro.def_anticipacion=false;
      jugadorFiltro.def_ayudaspermanentesallateral=false;
      jugadorFiltro.def_capacidaddemarcaje=false;
      jugadorFiltro.def_capacidadparataparcentros=false;
      jugadorFiltro.def_cerrarelladodebil_basculaciones=false;
      jugadorFiltro.def_cierralineasdepase=false;
      jugadorFiltro.def_coberturadecentrales=false;
      jugadorFiltro.def_coberturas=false;
      jugadorFiltro.def_colocacion=false;
      jugadorFiltro.def_comportamientofueradezona=false;
      jugadorFiltro.def_correctabasculacion=false;
      jugadorFiltro.def_correctabasculacion_distanciadeintervalos=false;
      jugadorFiltro.def_correctoperfilamiento=false;
      jugadorFiltro.def_cruces=false;
      jugadorFiltro.def_destrezaantecentroslaterales=false;
      jugadorFiltro.def_dificildesuperarenel1vs1=false;
      jugadorFiltro.def_dominiodelaszonasderechace=false;
      jugadorFiltro.def_duelosaereos=false;
      jugadorFiltro.def_duelosdefensivos=false;
      jugadorFiltro.def_evitarecepcionesentrelineas=false;
      jugadorFiltro.def_evitaserdesbordado=false;
      jugadorFiltro.def_interceptaciondetiro=false;
      jugadorFiltro.def_mantenerlalineadefensiva=false;
      jugadorFiltro.def_marcajeproximoaoponentedirecto=false;
      jugadorFiltro.def_ocupaespaciosdecompanerossuperados=false;
      jugadorFiltro.def_perfilamientos=false;
      jugadorFiltro.def_permiteelgiro=false;
      jugadorFiltro.def_presiontrasperdida=false;
      jugadorFiltro.def_resolucionanteparedesrivales=false;
      jugadorFiltro.def_sabecuidarsuespalda=false;
      jugadorFiltro.def_vigilayreferenciaalrival_enfaseofensiva=false;
      jugadorFiltro.def_vigilanciassobrelateralrival=false;
      jugadorFiltro.def_blocaje=false;
      jugadorFiltro.def_juegoaereolateral=false;
      jugadorFiltro.def_juegoaereofrontal=false;
      jugadorFiltro.def_habilidadenel1vs1=false;
      jugadorFiltro.def_despeje=false;
      jugadorFiltro.def_anticipacion_intuicion=false;
      jugadorFiltro.def_coberturadelineadefensiva=false;
      jugadorFiltro.def_abps=false;
      jugadorFiltro.def_penaltis=false;

    });
    // TODO: implement initState



    super.initState();
  }



  @override
  void dispose() {
    _nombre.dispose();
    _lugar .dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    TextFormField inputNombre = TextFormField(
      controller: _nombre,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nombre',
        //  icon: Icon(CustomIcon.futbolista_4, color: Colors.black,),
      ),
    );
    TextFormField inputLugar = TextFormField(
      controller: _lugar,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'CCAA de Nacimiento',
        //  icon: Icon(CustomIcon.futbolista_4, color: Colors.black,),
      ),
    );

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
        title: Text("IAScout - Filtro jugadores",
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
          child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: [
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
                                  jugadorFiltro.jugador=_nombre.text;
                                  jugadorFiltro.paisNacimiento=_lugar.text;
                                  jugadorFiltro.categoria=_categoriaAux.categoria;
                                  jugadorFiltro.temporada=_temporadaAux.temporada;
                                  jugadorFiltro.pais=_paisAux.pais;
                                  Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) => JugadoresFiltroPage(jugadorFiltro,_categoriaAux,_temporadaAux,_paisAux),
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
                              "Buscar jugadores",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            icon: Icon(
                              CustomIcon.search,
                              size: 20,
                              color: Colors.white,
                            ),
                            textColor: Colors.black,
                            splashColor: Colors.black,
                            color: Colors.blue),
                      ]),

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
                        TableRow(children: [
                          FormField(builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Selecciona la temporada",
                              ),
                              //isEmpty: temporadasAux == null,
                              child: DropdownButtonFormField<Temporada>(
                                hint: Text("Selecciona la temporada"),
                                value: _temporadaAux,
                                validator: (value) => value == null
                                    ? 'Selecciona la temporada'
                                    : null,
                                isDense: true,
                                onChanged: (Temporada value) async {
                                  setState(() {
                                    //newContact.favoriteColor = newValue;
                                    _temporadaAux = value;
                                    jugadorFiltro.temporada=value.temporada;
                                    _cogerPais();

                                    state.didChange(value);
                                  });
                                },
                                items: temporadas.map((Temporada temp) {
                                  return DropdownMenuItem<Temporada>(
                                    value: temp,
                                    child: Text(
                                      temp.temporada,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                        ]),
                        TableRow(children: [
                          FormField(builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Selecciona el pais",
                              ),
                              //isEmpty: temporadasAux == null,
                              child: DropdownButtonFormField<Pais>(
                                hint: Text("Selecciona el pais"),
                                value: _paisAux,
                                validator: (value) =>
                                value == null ? 'Selecciona el pais' : null,
                                isDense: true,
                                onChanged: (Pais value) async {
                                  setState(() {
                                    //newContact.favoriteColor = newValue;
                                    _paisAux = value;
                                    jugadorFiltro.pais=value.pais;
                                    _cogerCategorias();

                                    state.didChange(value);
                                  });
                                },
                                items: paises.map((Pais temp) {
                                  return DropdownMenuItem<Pais>(
                                    value: temp,
                                    child: Text(
                                      temp.pais,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                        ]),
                        TableRow(children: [
                          FormField(builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Selecciona el categoria",
                              ),
                              //isEmpty: temporadasAux == null,
                              child: DropdownButtonFormField<Categoria>(
                                hint: Text("Selecciona el categoria"),
                                value: _categoriaAux,
                                validator: (value) =>
                                value == null ? 'Selecciona el categoria' : null,
                                isDense: true,
                                onChanged: (Categoria value) async {
                                  setState(() {
                                    //newContact.favoriteColor = newValue;
                                    _categoriaAux = value;
                                    jugadorFiltro.categoria=value.categoria;
                                    state.didChange(value);
                                  });
                                },
                                items: categorias.map((Categoria temp) {
                                  return DropdownMenuItem<Categoria>(
                                    value: temp,
                                    child: Text(
                                      temp.categoria,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
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
                                        labelText: "Selecciona la posición",
                                      ),
                                      isEmpty: posicion == '',
                                      child: new DropdownButtonFormField(
                                        items: _posicion.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: posicion,
                                        validator: (value) =>
                                        value == null
                                            ? 'Selecciona la posición' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            _tipo.clear();
                                            _tipo.add(' ');
                                            _tipo.addAll(Player.listaTiposPosicion(value));
                                            //newContact.favoriteColor = newValue;
                                            jugadorFiltro.posicion = value;
                                            state.didChange(value);
                                          });
                                        },
                                      ),
                                    );
                                  }),
                            ]),

                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10),
                                child: inputNombre),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10),
                                child: inputLugar),
                          ],
                        ),
                        TableRow(
                            children: [
                              FormField(
                                  builder: (FormFieldState state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: "Selecciona el nivel ciclo 1",
                                      ),
                                      isEmpty: niveles =="",
                                      child: new DropdownButtonFormField(
                                        items: _niveles.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: niveles,
                                        validator: (value) =>
                                        value == null
                                            ? 'Selecciona el nivel ciclo 1' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //newContact.favoriteColor = newValue;
                                            jugadorFiltro.nivel = value;
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
                                        labelText: "Selecciona el nivel ciclo 2",
                                      ),
                                      isEmpty: niveles =="",
                                      child: new DropdownButtonFormField(
                                        items: _niveles.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: niveles,
                                        validator: (value) =>
                                        value == null
                                            ? 'Selecciona el nivel ciclo 2' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //newContact.favoriteColor = newValue;
                                            jugadorFiltro.nivel2 = value;
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
                                        labelText: "Selecciona el nivel ciclo 3",
                                      ),
                                      isEmpty: niveles =="",
                                      child: new DropdownButtonFormField(
                                        items: _niveles.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: niveles,
                                        validator: (value) =>
                                        value == null
                                            ? 'Selecciona el nivel ciclo 3' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //newContact.favoriteColor = newValue;
                                            jugadorFiltro.nivel3 = value;
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
                                        labelText: "Selecciona el nivel ciclo 4",
                                      ),
                                      isEmpty: niveles =="",
                                      child: new DropdownButtonFormField(
                                        items: _niveles.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: niveles,
                                        validator: (value) =>
                                        value == null
                                            ? 'Selecciona el nivel ciclo 4' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //newContact.favoriteColor = newValue;
                                            jugadorFiltro.nivel4 = value;
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
                                        labelText: "Selecciona el tipo de jugador (demarcación)",
                                      ),
                                      isEmpty: tipo == "",
                                      child: new DropdownButtonFormField(
                                        items: _tipo.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: tipo,
                                        validator: (value) =>
                                        value == null
                                            ? 'Selecciona el tipo de jugador (demarcación)' : null,
                                        isDense: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //newContact.favoriteColor = newValue;
                                            jugadorFiltro.tipo = value;
                                            state.didChange(value);
                                          });
                                        },
                                      ),
                                    );
                                  }),
                            ]),
                        TableRow(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  width: double.infinity,
                                  child: Row(children: [
                                    SizedBox(height: 5,width: 5,),
                                    Text('Edad:'),
                                    RangeSlider(
                                    values: _currentRangeValues,
                                    min: 15,
                                    max: 46,
                                    divisions: 46,
                                    labels: RangeLabels(
                                      _currentRangeValues.start.round().toString(),
                                      _currentRangeValues.end.round().toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        _currentRangeValues = values;
                                        jugadorFiltro.edadRange1=_currentRangeValues.start.round();
                                        jugadorFiltro.edadRange2=_currentRangeValues.end.round();
                                      });
                                    },
                                  ),
                                    Text('${_currentRangeValues.start.round().toString()}-${_currentRangeValues.end.round().toString()}'),

                                  ]),
                              )
                            ]),
                      ])
              ),
            Container(
            height: 20,color:Colors.white,),
          Visibility(
            visible: posicion!=" "?true:false,
            child:
            Container(
                        width: double.infinity,color:Colors.white,
                        child:  Texto(
                            Colors.blue[900],
                            "Características generales Físico".toUpperCase(),
                            14,
                            Colors.white,
                            false)),
          ),

            Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: new Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(220),
                    1: FixedColumnWidth(70),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: ponerFisico(),
                ),
              ),
            Container(
                        width: double.infinity,color:Colors.white,
                        child:  Texto(
                            Colors.blue[900],
                            "Características generales Defensivas".toUpperCase(),
                            14,
                            Colors.white,
                            false)
                    ),

            Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: new Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(220),
                    1: FixedColumnWidth(70),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: ponerDefensivo(),
                ),
              ),
            Container(
                        width: double.infinity,color:Colors.white,
                        child:  Texto(
                            Colors.blue[900],
                            "Características generales Ofensivas".toUpperCase(),
                            14,
                            Colors.white,
                            false)),
            Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: new Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(220),
                    1: FixedColumnWidth(70),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: ponerOfensivos(),
                ),
              ),
            Container(
                        width: double.infinity,color:Colors.white,
                        child:  Texto(
                            Colors.blue[900],
                            "Características generales Psicología".toUpperCase(),
                            14,
                            Colors.white,
                            false)),

            Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: new Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(220),
                    1: FixedColumnWidth(70),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: ponerPsicologia(),
                ),
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
                            jugadorFiltro.jugador=_nombre.text;
                            jugadorFiltro.paisNacimiento=_lugar.text;
                            Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => JugadoresFiltroPage(jugadorFiltro,_categoriaAux,_temporadaAux,_paisAux),
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
                        "Buscar jugadores",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      icon: Icon(
                        CustomIcon.search,
                        size: 20,
                        color: Colors.white,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.black,
                      color: Colors.blue),
                ]),

              ),
                    Container(
                      height: 50,color:Colors.white,),
            ],
          )
          ),
      )
    );
  }

  List<TableRow> ponerFisico() {
    List<String> caract;
    if (jugadorFiltro.posicion.toUpperCase().contains("PORTERO"))
      caract = Player.porteroFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("LATERAL"))
      caract = Player.lateralFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("CARRILERO"))
      caract = Player.carrileroFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("DEFENSA"))
      caract = Player.centralFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("CENTRAL"))
      caract = Player.centralFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("MEDIO"))
      caract = Player.medioFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("INTERIOR"))
      caract = Player.medioFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract = Player.medioFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("PIVOTE"))
      caract = Player.medioFisico;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("DELANTERO"))
      caract = Player.delanteroFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("PUNTA"))
      caract = Player.delanteroFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("EXTREMO"))
      caract = Player.extremoFisico;
    else
      caract = Player.todosFisico;
    List<TableRow> rows = new List<TableRow>();
    for (String doc in caract) {

      rows.add(TableRow(children: [
        new Text(doc,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            )),
        Switch(
          value: Player.dameElValor(doc, jugadorFiltro),
          onChanged: (newValue) {
            setState(() {
              Player.poneElValor(doc, newValue, jugadorFiltro);
            });
          },
          activeTrackColor: Colors.blue[900],
          activeColor: Colors.blue[900],
        ),
      ]));
    }
    return rows;
  }
  List<TableRow> ponerDefensivo() {
    List<String> caract;
    if(jugadorFiltro.posicion.toUpperCase().contains("PORTERO"))
      caract=Player.porteroDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("LATERAL"))
      caract=Player.lateralDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CARRILERO"))
      caract=Player.carrileroDefensa;
    else if(jugadorFiltro.posicion.toUpperCase().contains("DEFENSA"))
      caract=Player.centralDefensa;
    else if(jugadorFiltro.posicion.toUpperCase().contains("CENTRAL"))
      caract=Player.centralDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("MEDIO"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("INTERIOR"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PIVOTE"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("DELANTERO"))
      caract=Player.delanteroDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PUNTA"))
      caract=Player.delanteroDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("EXTREMO"))
      caract=Player.extremoDefensa;
    else
      caract=Player.todosDefensa;
    List<TableRow> rows =new List<TableRow>();
    for (String doc in caract) {

      rows.add(
          TableRow(children: [
            new Text(doc,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,

                )),
            Switch(
              value: Player.dameElValor(doc, jugadorFiltro),
              onChanged: (newValue) {
                setState(() {
                  Player.poneElValor(doc, newValue,  jugadorFiltro);
                });
              },
              activeTrackColor: Colors.blue[900],
              activeColor: Colors.blue[900],
            ),
          ])
      );
    }
    return rows;
  }

  List<TableRow> ponerOfensivos() {
    List<String> caract;
    if(jugadorFiltro.posicion.toUpperCase().contains("PORTERO"))
      caract=Player.porteroOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("LATERAL"))
      caract=Player.lateralOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CARRILERO"))
      caract=Player.carrileroOfensivas;
    else if(jugadorFiltro.posicion.toUpperCase().contains("DEFENSA"))
      caract=Player.centralOfensivas;
    else if(jugadorFiltro.posicion.toUpperCase().contains("CENTRAL"))
      caract=Player.centralOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("MEDIO"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("INTERIOR"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PIVOTE"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("DELANTERO"))
      caract=Player.delanteroOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PUNTA"))
      caract=Player.delanteroOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("EXTREMO"))
      caract=Player.extremoOfensivas;
    else
      caract=Player.todosOfensivas;
    List<TableRow> rows =new List<TableRow>();
    for (String doc in caract) {

      rows.add(
          TableRow(children: [
            new Text(doc,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,

                )),
            Switch(
              value: Player.dameElValor(doc, jugadorFiltro),
              onChanged: (newValue) {
                setState(() {
                  Player.poneElValor(doc, newValue,  jugadorFiltro);
                });
              },
              activeTrackColor: Colors.blue[900],
              activeColor: Colors.blue[900],
            ),
          ])
      );
    }
    return rows;
  }

  List<TableRow> ponerPsicologia() {
    List<String> caract;
    if(jugadorFiltro.posicion.toUpperCase().contains("PORTERO"))
      caract=Player.porteroPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("LATERAL"))
      caract=Player.lateralPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CARRILERO"))
      caract=Player.carrileroPsicologia;
    else if(jugadorFiltro.posicion.toUpperCase().contains("DEFENSA"))
      caract=Player.centralPsicologia;
    else if(jugadorFiltro.posicion.toUpperCase().contains("CENTRAL"))
      caract=Player.centralPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("MEDIO"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("INTERIOR"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PIVOTE"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("DELANTERO"))
      caract=Player.delanteroPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PUNTA"))
      caract=Player.delanteroPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("EXTREMO"))
      caract=Player.extremoPsicologia;
    else
      caract=Player.todosPsicologia;
    List<TableRow> rows =new List<TableRow>();
    for (String doc in caract) {

      rows.add(
          TableRow(children: [
            new Text(doc,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,

                )),
            Switch(
              value: Player.dameElValor(doc, jugadorFiltro),
              onChanged: (newValue) {
                setState(() {
                  Player.poneElValor(doc, newValue,  jugadorFiltro);
                });
              },
              activeTrackColor: Colors.blue[900],
              activeColor: Colors.blue[900],
            ),
          ])
      );
    }
    return rows;
  }
}


