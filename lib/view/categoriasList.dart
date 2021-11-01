import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/categoriaDao.dart';

import 'package:iadvancedscout/dao/equipoDao.dart';
import 'package:iadvancedscout/view/equiposList.dart';
import 'package:iadvancedscout/model/categoria.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:flutter/material.dart';

class CategoriasList extends StatefulWidget {
  @override
  _CategoriasListState createState() => new _CategoriasListState();

   List<Categoria> _listCategoria;
  CategoriasList(this._listCategoria){
    //print("CATEGIO:${_listCategoria}");
  }


}
class _CategoriasListState extends State<CategoriasList> {

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  /*void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }*/


  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
  SingleChildScrollView dataBody(List<Categoria> listCategoria) {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          showCheckboxColumn: false,
        columns: [
          DataColumn(label: Text('Categoría')),
          DataColumn(label: Text('País')),
          DataColumn(label: Text('Action')),
        ],
        rows:
        listCategoria// Loops through dataColumnText, each iteration assigning the value to element
            .map(
          ((element) => DataRow(
            cells: <DataCell>[
              DataCell(
                  Text(element.categoria)),
              DataCell(Text(element.pais)),
              DataCell( new IconButton(
                icon: const Icon(Icons.delete_forever,
                    color: const Color(0xFF167F67)),
                //onPressed: () => _delete(element.categoria),
                alignment: Alignment.centerLeft,
              )),

            ],
            onSelectChanged: (newValue)  async {
              EquipoDao con=EquipoDao();
              List<Equipo> lista= await con.getAllEquipo(element.pais, element.categoria);
              //print("ONSELECT${lista}");
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => EquiposList(lista),
              ));
              //print('row 1 pressed');
            },)

          ),
        )
            .toList(),
      ),
    );
  }




 @override
  Widget build(BuildContext context) {


    return new Scaffold(
      appBar: new AppBar(
        title: Text("IAScout - Categorías",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
      ),
      key: scaffoldKey,
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Container(color:Colors.blue[900],
              padding: EdgeInsets.all(10.0),
              child: Texto(Colors.white, widget._listCategoria.isNotEmpty?
              widget._listCategoria[0].pais.toString().toUpperCase():
              "Categorías"
                  ,20, Colors.blue[900], false)),
          Expanded(
            child : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                showCheckboxColumn: false,
                columns: [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('Categoría')),
                  DataColumn(label: Text('País')),
                ],
                rows:
                widget._listCategoria// Loops through dataColumnText, each iteration assigning the value to element
                    .map(
                  ((element) => DataRow(
                    cells: <DataCell>[
                      DataCell(Container(
                        height: 30.0,
                        width: 30.0,
                        child:Image.asset("assets/img/2b.png"),
                      )),
                      DataCell(
                          Text(element.categoria, style: new TextStyle(fontSize: 14),)),
                      DataCell(Text(element.pais, style: new TextStyle(fontSize: 12),)),
                     /* DataCell( new IconButton(
                        icon: const Icon(Icons.delete_forever,
                            color: const Color(0xFF167F67)),
                        //onPressed: () => _delete(element.categoria),
                        alignment: Alignment.centerLeft,
                      )),*/

                    ],
                    onSelectChanged: (newValue) async {
                      EquipoDao con=EquipoDao();
                      List<Equipo> lista= await con.getAllEquipo(element.pais, element.categoria);
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => EquiposList(lista),
                      ));
                    },)

                  ),
                )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
