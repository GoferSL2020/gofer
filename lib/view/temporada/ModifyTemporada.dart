import 'package:flutter/material.dart';
import 'package:iadvancedscout/dao/CRUDTemporada.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:provider/provider.dart';


class ModifyTemporada extends StatefulWidget {
  final Temporada temporada;

  ModifyTemporada({@required this.temporada});

  @override
  _ModifyTemporadaState createState() => _ModifyTemporadaState();
}

class _ModifyTemporadaState extends State<ModifyTemporada> {
  final _formKey = GlobalKey<FormState>();

  String temporada ;

  String categoria ;
  String entrenador ;

  @override
  void initState() {
    temporada =  widget.temporada.temporada.toUpperCase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final temporadaProvider = new CRUDTemporada();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Modificar el Temporada'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.temporada.temporada,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Temporada',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Temporada Title';
                    }
                  },
                  onSaved: (value) => temporada = value
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await temporadaProvider.updateTemporada(
                        Temporada(
                            temporada: temporada),
                            widget.temporada.id);
                    Navigator.pop(context) ;
                  }
                },
                child: Text('Aceptar', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )

            ],
          ),
        ),
      ),
    );
  }
}
