import 'package:iadvancedscout/dao/PaisService.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:flutter/material.dart';

class AddPais extends StatefulWidget {
  @override
  _AddPaisState createState() => _AddPaisState();
}

class _AddPaisState extends State<AddPais> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Pais pais = Pais(" ", null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add pais"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Poner el pais",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => pais.pais = val,
                  validator: (val){
                    if(val.isEmpty ){
                      return "title field cant be empty";
                    }else if(val.length > 16){
                      return "title cannot have more than 16 characters ";
                    }
                  },
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Post body",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => pais.pais = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "body field cant be empty";
                    }
                  },
                ),
              ),*/
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        insertPais();
        Navigator.pop(context);
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.black,
        tooltip: "Add a pais",),
    );
  }

  void insertPais() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      pais.imagen = null;
      PaisService paisService = PaisService();
      paisService.addPais(pais);
    }
  }



}

