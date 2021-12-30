import 'package:flutter/material.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/view/jugadoresList.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

class EquiposList extends StatefulWidget {
  @override
  _EquiposListState createState() => new _EquiposListState();
  final List<Equipo> _listEquipos;
  EquiposList(this._listEquipos){
    //print(_listEquipos);
  }
}

class _EquiposListState extends State<EquiposList> {

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
  SingleChildScrollView dataBody(List<Equipo> listEquipo) {


    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        showCheckboxColumn: false,
        columns: [
          DataColumn(label: Text('')),
          DataColumn(label: Text('EQUIPO')),

        ],
        rows:
        listEquipo // Loops through dataColumnText, each iteration assigning the value to element
            .map(
          ((element) => DataRow(
            cells: <DataCell>[
              DataCell(Container(
                height: 30.0,
                width: 30.0,
                child:element.imagen!=null?Image.memory(element.imagen):Text(element.imagen.toString()),
              )),
              DataCell(
              Container(
               width: 250, //SET width
              child: Text(element.equipo,
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              )
              )

                ,)),

            ],
             onSelectChanged: (newValue)  async {
              JugadorDao con=JugadorDao();

              List<Jugador> lista=con.getJugadores(element);
              //List<Jugador> lista= await con.getAllJugadores(element);
            Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => JugadoresList(lista),
            ));
            },)
          ),
        ).toList(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("IAScout - Equipos",
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
              child: Texto(Colors.white, widget._listEquipos.isNotEmpty?
              widget._listEquipos[0].categoria.toString().toUpperCase():
              "Equipos"
                  ,20, Colors.blue[900], false)),
          Expanded(
            child : dataBody(widget._listEquipos),
          ),
        ],
      ),
    );
  }


}
