import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/model/categoria.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/equipos.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage(this._pais);

  @override
  _CategoriasPageState createState() => _CategoriasPageState();
  final Pais _pais;
}

class _CategoriasPageState extends State<CategoriasPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "jugadores";
  List<Categoria> categoriasList = <Categoria>[];


  getCategoria() {
    categoriasList.clear();
    _database.reference()
        .child('temporadas/${widget._pais.temporada}/paises/${widget._pais.pais}/categorias').orderByChild('categoria')
        .once()
        .then((DataSnapshot snapshotResult) {
      if (snapshotResult == null || snapshotResult.value==null ) return;
      //print("CATEGORIAS:${snapshotResult.value}");
      Map<dynamic, dynamic> paisesMap = snapshotResult.value;
      paisesMap.forEach((key, value) {
        //print("CATEGORIAS:${value["categoria"]}");
        //print("KEY:${key}");

        if(
        (BBDDService().getUserScout().categoria==value["categoria"])||
            (BBDDService().getUserScout().categoria=="Todas"))
          categoriasList.add(Categoria.fromJson(key, value));
      });
    });

  }



  @override
  void initState() {
    //print("temporadas/2021-2022/paises/${widget._pais.pais}/categorias/${BBDDService().getUserScout().categoria}");
    nodeName = "temporadas/${BBDDService().getUserScout().temporada}/paises/${widget._pais.pais}/categorias";
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(actions: <Widget>[
        IconButton(
          icon: new Image.asset(Config.icono),onPressed: () {
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
        backgroundColor:Colors.black,
        title: Text("IAScout - Categorias",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: categoriasList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            //
            Container(color:Colors.black,
                padding: EdgeInsets.all(1.0),
                child: Texto(Colors.white,"${widget._pais.pais}".toUpperCase()
                    ,14, Colors.black, false)),
            Container(color:Colors.black,
                padding: EdgeInsets.all(1.0),
                child: Texto(Colors.red,"${BBDDService().getUserScout().temporada}".toUpperCase()
                    ,14, Colors.black, false)),
            dataBody(),
            //  dataBody(),
          ],
        ),
      ),
     /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) =>AddCategoria()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        tooltip: "add a post",
      ),*/
    );
  }

  Flexible dataBody() {
    return
            Flexible(
              child:
              ListView.builder(
                itemCount: categoriasList.length,
                itemBuilder: (context, index) {
                  return
                    ListTile(
                      onTap: () {
                          Categoria categoria=new Categoria(categoriasList[index].categoria, widget._pais.pais,null);
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => EquiposPage(categoria),
                          ));
                      },
                      title: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            categoriasList[index].categoria.contains("1ª División Liga Argentina")?
                            Image.network("https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/categorias%2F1_DivisionLigaArgentina.png?alt=media",width: 25):
                            categoriasList[index].categoria.contains("División A")?
                            Image.network("https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/categorias%2F2_Division.png?alt=media",width: 25):
                            categoriasList[index].categoria.contains("1ª División")?
                            Image.network("https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/categorias%2F1_RFEF.png?alt=media",width: 25):
                            categoriasList[index].categoria.contains("División B")?
                            Image.network("https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/categorias%2F2b.png?alt=media",width: 25):
                            Image.network("https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/categorias%2F2_RFEF.png?alt=media",width: 25),

                            Text(
                                    categoriasList[index].categoria
                              ,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(width: 50,),
                            IconButton(
                                icon: new Icon(
                                  CustomIcon.camiseta,
                                  color: Colors.green[900],
                                  size: 20,
                                ),

                            ),
                          ]),
                    );
                },
              ));
  }

  Visibility dataBody2(){
    return  Visibility(
      visible: categoriasList.isNotEmpty,
      child: Flexible(
          child: FirebaseAnimatedList(

              query: _database.reference().child(nodeName),
              itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                //print("${snap}");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: new RaisedButton(
                        elevation: 0.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        onPressed: ()  async {
                          Categoria categoria=new Categoria(categoriasList[index].categoria, widget._pais.pais,null);
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => EquiposPage(categoria),
                          ));

                        },
                        child: Column(children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //Image.asset(snap.value['categoria']=="Segunda A"?"assets/img/123.png":"assets/img/2b.png", height: 25.0, width: 25.0),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: new Text(
                                  "${snap.value['categoria']}",
                                  style: TextStyle(

                                    // fontWeight: FontWeight.bold,
                                      fontSize: 15.0),textAlign: TextAlign.center,
                                ),),
                              Spacer(),
                              FlatButton(
                                onPressed: ()  {
                                  setState(() {
                                    // CategoriaService(widget.).deleteCategoria(categoriasList[index]);
                                    // categoriasList.removeAt(index);
                                  });
                                },
                                padding: EdgeInsets.all(10.0),
                                child: Row( // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(Icons.restore_from_trash_outlined,
                                      color: Colors.white,),
                                  ],
                                ),
                              ),],
                          ),
                        ]),
                        textColor: Colors.black,
                        color: Colors.white),
                  ),
                );
              })),
    );
  }
  _childAdded(Event event) {
    setState(() {
      //print(categoriasList.length);
      //print("CATEGORIA:${BBDDService().getUserScout().categoria}");
      //print("KEY:${event.snapshot.key.toString()}");
      if (BBDDService().getUserScout().categoria.contains("Todas")) {
        //print("TODAS:${BBDDService().getUserScout().categoria.contains("Todas")}");
        categoriasList.add(Categoria.fromSnapshot(event.snapshot));
      }
      else if (event.snapshot.key.toString().contains(BBDDService().getUserScout().categoria) ) {
        //print("CONT:${event.snapshot.key.toString().contains(BBDDService().getUserScout().categoria)}");
        categoriasList.add(Categoria.fromSnapshot(event.snapshot));
      }

    });
  }

  _childAddedCategoria(Categoria event) {

    categoriasList.add(event);

  }

  void _childRemoves(Event event) {
    //print("_childRemoves");
    var deletedPost = categoriasList.singleWhere((post){
      return post.pais == event.snapshot.key;
    });

    setState(() {
      categoriasList.removeAt(categoriasList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = categoriasList.singleWhere((post){
      return post.pais == event.snapshot.key;
    });

    setState(() {
      categoriasList[categoriasList.indexOf(changedPost)] =Categoria.fromSnapshot(event.snapshot);
    });
  }
}
