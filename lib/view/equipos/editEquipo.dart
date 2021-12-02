import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:provider/provider.dart';

class EditEquipo extends StatefulWidget {
  final Temporada temporada;

  final Equipo equipo;

  EditEquipo({@required this.equipo, @required this.temporada});

  @override
  _EditEquipoState createState() => _EditEquipoState();
}

class _EditEquipoState extends State<EditEquipo> {
  final _formKey = GlobalKey<FormState>();

  String equipo;
  bool insertar = false;
  String entrenador;
  int duracionMinutos;
  String competicion = "";
  String categoria = "";
  List<String> _categorias = <String>[
    'SENIOR',//45, 90
    'JUVENIL',//45, 90
    'CADETE',//40, 80
    'INFANTIL',//35 ,70
    'ALEVIN',//30, 60
    'ALEVIN-7',//30, 60
    'BENJAMIN',//25, 50
    'PREBENJAMIN',//25, 50
    'CHUPETIN',//15, 30

  ];

  @override
  void initState() {
    print(widget.equipo.equipo);
    equipo = widget.equipo.equipo;
    categoria = widget.equipo.categoria;
    insertar = widget.equipo.equipo == null ? true : false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final equipoProvider = new CRUDEquipo();
    FormField inputCategoria = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Selecciona la categoria",
        ),
        isEmpty: _categorias == '',
        child: new DropdownButtonFormField(
          items: _categorias.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          value: categoria,
          validator: (value) => value == null ? 'Poner la categoria' : null,
          isDense: true,
          onChanged: (value) {
            setState(() {
              //newContact.favoriteColor = newValue;
              categoria = value;
              state.didChange(value);
            });
          },
        ),
      );
    });
    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 40,
                    child: IconButton(
                      icon: Icon(Icons.save_outlined,size: 30, color: Colors.blue,),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        if (insertar) {

                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
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
                    ))])

        ],
        backgroundColor: Colors.black,
        title: Text("IAClub - Añadir Equipo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: Abajo(temporada: widget.temporada,),
      body: Container(
        child: Column(children: <Widget>[
          Container(width: double.infinity,
          color:Colors.black,
          child:Text(
            widget.temporada.temporada,
            textAlign: TextAlign.center,
            style: TextStyle(color: Config.colorAPP,


                fontSize: 16,
                fontStyle: FontStyle.italic),
          ),),

          Container(
            width: double.infinity,
            height: 30,
            color:Colors.black,
            child:Text(
              widget.equipo.equipo==null?"":widget.equipo.equipo,
              textAlign: TextAlign.center,
              style: TextStyle(color: Config.colorAPP,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),),
          Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  Row(
                    children: [
                      Expanded(
                        flex: 1, // 20%
                        child: Icon(
                          CustomIcon.futbol,
                          color: Colors.grey[700],
                          size: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child:inputCategoria,
                      ),
                  ],),
                  TextFormField(
                      initialValue: widget.equipo.equipo,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Equipo',
                        icon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Poner el equipo';
                        }
                      },
                      onSaved: (value) => equipo = value),
                  TextFormField(
                      initialValue: widget.equipo.entrenador,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Entrenador',
                        icon: Icon(CustomIcon.arbitro),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Poner el entrenador';
                        }
                      },
                      onSaved: (value) => entrenador = value),
                  TextFormField(
                      initialValue: widget.equipo.entrenador,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Categoria - grupo',
                        icon: Icon(CustomIcon.marcador),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Poner la categoria';
                        }
                      },
                      onSaved: (value) => categoria = value),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
