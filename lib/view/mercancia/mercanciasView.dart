import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gls/conf/config.dart';

import 'package:gls/modelo/categoria.dart';
import 'package:gls/service/UserService.dart';
import 'package:gls/service/MercanciaService.dart';
import 'package:gls/wigdet/abajo.dart';

import '../../modelo/mercancia.dart';



class MercanciaView extends StatefulWidget {
  final Categoria categoria;
  final String sitio;
  MercanciaView(this.categoria,this.sitio);

  @override
  _MercanciaViewState createState() => new _MercanciaViewState();
}

class _MercanciaViewState extends State<MercanciaView> {
  List<Mercancia> mercancias = <Mercancia>[];
  List<Mercancia> mercanciasTODOS = <Mercancia>[];
  final _filtrar = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });
    setState(() {
      _cogerProductos();
    });
    super.initState();
  }

  _cogerProductos() async {
    List<Mercancia> datos;
    if(widget.categoria.categoria!=""){
      datos = await MercanciaService().fetchProductos(widget.categoria);
      datos.removeWhere((element) => element.fechaRecogido!="");
    }else{
      if(UserService.userOficina.plataforma==true)
        datos = await MercanciaService().fetchProductosRecogidoPlataforma();
      else
        datos = await MercanciaService().fetchProductosRecogidoOficina(UserService.userOficina.numeroOficina);
    }
    setState(() {
      mercancias = datos;
      for (var d in mercancias) mercanciasTODOS.add(d);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextFormField inputBuscar = TextFormField(
      controller: _filtrar,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Filtrar productos ${widget.sitio.toLowerCase()}',
        fillColor: Colors.black,
        hoverColor: Colors.black,

        border: OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(
          Icons.zoom_in,
          color: Colors.black,
        ),

        focusedBorder: OutlineInputBorder(

          borderSide:  BorderSide(color: Colors.black,width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          mercancias.clear();
          if (value.trim() == "") {
            for (var d in mercanciasTODOS) {
              mercancias.add(d);
            }
          }
          for (var d in mercanciasTODOS) {
            if (d.descripcion.toUpperCase().contains(value.toUpperCase(), 0)) {
              mercancias.add(d);
            } else {
            }
          }

          // jugador = jugadorTODOS.where((element) => element.jugador.contains(value)).toList();
        });
      },
    );

    return new Scaffold(
      key: _scaffoldkey,
      appBar: new AppBar(
        actions: <Widget>[
          Container(
              width: 50,
              child: IconButton(
                icon: new Image.asset(Config.icono),
                onPressed: () {},
              )),
        ],
        backgroundColor: Config.fondo,
        title: Text("GLS - Mercancias",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Config.letras)),
        elevation: 0,
        centerTitle: true,

      ),
      bottomNavigationBar: Abajo(),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            height: 30,
            width: double.infinity,
            color:Config.fondo,
            child: Text(
              "Mercancias ${widget.categoria.categoria}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Config.letras,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            color:Config.fondo,
            child: Text(
              " ${widget.sitio}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Config.letras,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(height: 5,
            color: Config.fondo,
          ),
          Container(
              color: Config.letras,
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10,right: 20),
              child: inputBuscar),
          Container(height: 5,
              color: Config.fondo,
              ),
          Visibility(
              visible: mercancias.isNotEmpty,
              child: Flexible(
                child: ListView.builder(
                    itemCount: mercancias.length,
                    itemBuilder: (buildContext, index) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child:  Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text("Referencia: ${mercancias[index].referenciaProducto}",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text("Plataforma: ${mercancias[index].plataforma}",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text("Descripción:",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text("${mercancias[index].descripcion}",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontSize: 12,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text("Fecha Alta:",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                    ),),
                                Text("${mercancias[index].fechaAlta}",
                                  style: TextStyle(
                                    color: Config.fondo,
                                    fontSize: 12,

                                  ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text("Fecha Recogida:",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text("${mercancias[index].fechaRecogido}",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontSize: 12,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text("Oficina recogida:",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                    ),
                                  ),

                                  Text(mercancias[index].oficinaRecogido!=""?"${mercancias[index].oficinaNumero}-${mercancias[index].oficinaRecogido}":"",
                                    style: TextStyle(
                                      color: Config.fondo,
                                      fontSize: 12,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                height: 300,
                                child:ListView(
                                  // This next line does the trick.
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      SizedBox(
                                          width: 250.0,
                                          height: 300.0,
                                          // ignore: unnecessary_null_comparison
                                          child:
                                          Image.network(
                                            Config.imagenFoto(mercancias[index], 1),
                                               fit: BoxFit.cover,height: 90,
                                          )
                                      ),
                                      Container(width: 5, ),
                                      SizedBox(
                                          width: 250.0,
                                          height: 300.0,
                                          // ignore: unnecessary_null_comparison
                                          child:
                                          Image.network(
                                            Config.imagenFoto(mercancias[index], 2),fit: BoxFit.cover,height: 90,
                                          )
                                      ),
                                      Container(width: 5, ),
                                      SizedBox(
                                          width: 250.0,
                                          height: 300.0,
                                          // ignore: unnecessary_null_comparison
                                          child:
                                          Image.network(
                                            Config.imagenFoto(mercancias[index], 3),fit: BoxFit.cover,height: 90,
                                          )
                                      ),
                                      Container(width: 5)
                                    ])),
                            mercancias[index].fechaRecogido==""?
                            Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  UserService.userOficina.plataforma==false?
                                  Container(
                                    width: 130,
                                    height: 60,
                                    padding: EdgeInsets.all(10),
                                    child: MaterialButton(
                                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                                          side: BorderSide(
                                            width: 1,
                                            color: Config.fondo,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: Text("Recogido"),
                                        color:  Config.letras,
                                        textColor: Config.fondo,
                                        splashColor: Config.fondo,
                                        onPressed: () async{
                                              await  _showRecogidoDialog(context,mercancias![index])==true?
                                                setState(() {
                                                mercancias[index].fechaRecogido=DateTime.now().toString();
                                                mercancias[index].oficinaNumero=UserService.userOficina.numeroOficina;
                                                mercancias[index].oficinaRecogido=UserService.userOficina.nombre;
                                                MercanciaService().updateProducto( mercancias[index]);
                                                //productos.remove(productos[index]);
                                                Fluttertoast.showToast(
                                                    msg:
                                                    "Se ha recogido el\n prodcucto:${mercancias[index].referenciaProducto}",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Colors.green.shade900,
                                                    textColor: Colors.white,
                                                    fontSize: 12.0);
                                                Navigator.pop(context, true);
                                              }):null;
                                        }

                                    ),
                                  ):Container(),
                                ],
                              ),
                            ):Container(),
                            Padding(
                                padding: EdgeInsets.only(top: 20,left: 10,bottom: 10),
                                child:
                                Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 10),
                                    color:Config.fondo,
                                    height: 1)),
                          ],
                        ),
                      );
                    }),
              )),
        ]),
      ),
    );
  }
  final _referencia = TextEditingController();



  Future<bool?> _showRecogidoDialog(
      BuildContext context, Mercancia mercancia) {

    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('ATENCIÓN',style: TextStyle(
            fontSize: 18,decoration: TextDecoration.underline,)),
          content:Material(
             color:Colors.transparent,
            child:
            Column(children: [
              Container(height: 10,),
              Text('¿El mercancía se ha recogido?'),
              Container(height: 10,),
              Text('El mercancía: ${mercancia.referenciaProducto}\n se ha recogido',style: TextStyle(
                color: Colors.black, fontSize: 18,)),
              Container(height: 10,),
              //inputNombre,
              //Container(height: 50,child:inputNombre),
              Container(height: 10,),
            ],
          ),),
          actions: <Widget>[
            TextButton(
              child:  Text('Recogido',style:TextStyle(
                  fontSize: 16, color: Colors.black)),
              onPressed: () {
                      Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('Cancelar',style:TextStyle(
                  fontSize: 16, color: Colors.red),),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }
  Future<bool?> _showEliminarDialog(
      BuildContext context, Mercancia mercancia) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('ATENCIÓN',style: TextStyle(
            fontSize: 18,decoration: TextDecoration.underline,)),
          content:
          Column(children: [
            Container(height: 10,),
            Text('¿Quieres eliminar la mercancía?'),
            Container(height: 10,),
             Text('Eliminar los datos de la mercancía:${mercancia.referenciaProducto}',style: TextStyle(
              color: Colors.black, fontSize: 18,)),
            Container(height: 10,),
          ],),
          actions: <Widget>[
            TextButton(
              child:  Text('Eliminar',style:TextStyle(
                  fontSize: 16, color: Colors.black)),
              onPressed: () {

                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('Cancelar',style:TextStyle(
                  fontSize: 16, color: Colors.red),),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }
}
