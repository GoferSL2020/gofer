import 'package:flutter/material.dart';
import 'package:gls/dao/CRUDCategoria.dart';
import 'package:gls/modelo/categoria.dart';

class ModifyCategoria extends StatefulWidget {

  final Categoria categoria;

  ModifyCategoria(@required this.categoria);

  @override
  _ModifyCategoriaState createState() => _ModifyCategoriaState();
}

class _ModifyCategoriaState extends State<ModifyCategoria> {
  final _formKey = GlobalKey<FormState>();

  String temporada="" ;

  String categoria="" ;
  String entrenador="" ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dao = new CRUDCategoria();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Modificar el Categoria'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.categoria.categoria,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Categoria',
                    fillColor: Colors.grey.shade300,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Categoria Title';
                    }
                  },
                  onSaved: (value) => temporada = value!
              ),
              ElevatedButton(

                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //await dao.updateCategoria(temporada: widget.temporada, pais:widget.pais, categoria: widget.categoria);
                    Navigator.pop(context) ;
                  }
                },
                child: Text('Aceptar', style: TextStyle(color: Colors.white)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
