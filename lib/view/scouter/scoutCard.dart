
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDScout.dart';
import 'package:iadvancedscout/icon_mio_icons.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/scout.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/userScout.dart';

class ScoutCard extends StatefulWidget {
  final UserScout scout;
  final List<Categoria> categorias;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


  ScoutCard(
      {@required this.scout,this.categorias
        });

  final productProvider = new CRUDUserScout();
  @override
  _ScoutCardState createState() => new _ScoutCardState();
}

class _ScoutCardState extends State<ScoutCard> {
   List<String> categoriasString=[];


  @override
  void initState() {

    //_cogerScouts();
  }

  void inicial() async{
    setState(() {
      categoriasString.clear();
      categoriasString.add("");
      categoriasString.add("Todas");
      widget.categorias.forEach((element) {
        categoriasString.add(element.categoria);
      });
    });

  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }


  @override
  Widget build(BuildContext context) {
    inicial();
    return GestureDetector(
      onTap: () {

        },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: Card(
          color: Config.colorCard,
          elevation: 5,
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,height: 20,

                  child:Center(
                  child:Text(
                    '${widget.scout.name}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      color: Colors.black,),
                  )),
                ),
                Container(
                  width: double.infinity,height: 20,

                  child:Center(
                      child:Text(
                        '${widget.scout.email}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          color: Colors.blue.shade900,),
                      )),
                ),
                Container(
                  width: double.infinity,height: 20,

                  child:Center(
                      child:Text(
                        'Categoria: ${widget.scout.categoria}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          color: Colors.red.shade900,),
                      )),
                ),
                FormField(builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Selecciona el categoria",
                    ),
                    //isEmpty: temporadasAux == null,
                    child: DropdownButtonFormField<String>(
                      hint: Text("Selecciona el categoria"),
                      value: widget.scout.categoria,
                      validator: (value) =>
                      value == null ? 'Selecciona el categoria' : null,
                      isDense: true,
                      onChanged: (String value) async {
                        setState(() {
                          //newContact.favoriteColor = newValue;
                          widget.scout.categoria = value;
                          state.didChange(value);
                          CRUDUserScout dao = CRUDUserScout();
                          dao.updateUserScout(widget.scout);
                        });
                      },
                      items: categoriasString.map((String temp) {
                        return DropdownMenuItem<String>(
                          value: temp,
                          child: Text(
                            temp,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
             /*Container(height: 5,),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 30,
                        child: RaisedButton.icon(
                          elevation: 20,
                          onPressed: () {
                          },
                          label: Text("Cambiar la categoria",
                            style: TextStyle(color: Colors.black, fontSize: 11),),
                          icon: Icon(IconMio.mode_edit, size: 20, color: Colors.black,),
                          textColor: Colors.white,
                          hoverColor: Colors.black,
                          splashColor: Colors.blue,
                          color: Colors.white,)),Container(width: 5,)
                  ],
                ),
              ),*/
            ],),
            ),
          ),
        ),
    );
  }

}
