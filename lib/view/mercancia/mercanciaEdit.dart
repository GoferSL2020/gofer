import 'dart:io';
// ignore: unnecessary_import
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gls/service/UserService.dart';
import 'package:gls/service/MercanciaService.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gls/conf/config.dart';

import 'package:gls/modelo/categoria.dart';
import 'package:gls/modelo/mercancia.dart';
//import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';

//import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

class MercanciaEdit extends StatefulWidget {
  static String tag = 'edit-page';
  final Mercancia mercancia;
  final Categoria categoria;
  MercanciaEdit(this.mercancia, this.categoria);

  @override
  _MercanciaEditState createState() => _MercanciaEditState();
}

class _MercanciaEditState extends State<MercanciaEdit> {
  final _formKey = GlobalKey<FormState>();
  final _referencia = TextEditingController();
  final _descripcion = TextEditingController();

  String? imageUrl;
  XFile? _imageFileList1;
  XFile? _imageFileList2;
  XFile? _imageFileList3;
  bool insertar = false;
  dynamic _pickImageError;
  int _state = 0;
  final ImagePicker _picker = ImagePicker();
  List<dynamic>?_outputs;


  @override
  void dispose() {
    _referencia.dispose();

    super.dispose();
  }
  String dia="";
  String mes="";
  @override
  void initState() {
    _referencia.text = widget.mercancia.referenciaProducto;
    _descripcion.text = widget.mercancia.descripcion;

    insertar = widget.mercancia.referenciaProducto == "" ? true : false;

    int diaHoy= DateTime.now().day;
    int mesHoy= DateTime.now().month;

    if(diaHoy<10)
      dia="0${diaHoy}";
    else
      dia="${diaHoy}";
    if(mesHoy<10)
      mes="0${mesHoy}";
    else
      mes="${mesHoy}";


    super.initState();
  }


  Future<void> _onImageButtonPressed(ImageSource source, bool camara, int foto,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final XFile? pickedFile;
      if (camara == false)
        pickedFile = await _picker.pickImage(source: ImageSource.gallery
            /*maxWidth: 100,
        maxHeight: 100,
        imageQuality: 100,*/
            );
      else
        pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          /*maxWidth: 100,
        maxHeight: 100,
        imageQuality: 100,*/
        );
      setState(() async {
        if (foto == 1) {
          _imageFileList1 = pickedFile!;
        }
        else if (foto == 2)
          _imageFileList2 = pickedFile!;
        else if (foto == 3) _imageFileList3 = pickedFile!;
      });
    } catch (e) {
      setState(() {
        print("EEEERRRRRROOOOOORR:${e.toString()}");
        _pickImageError = e;
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    TextFormField inputNombre = TextFormField(
      controller: _referencia,
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Número',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );

    TextFormField inputDescripcion = TextFormField(
      controller: _descripcion,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Descripción',
        icon: Icon(Icons.info_outlined),
      ),
    );




    Column picture(int foto, XFile? _imageFileList) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 0),
            child: Container(
              width: 120,
              height: 60,
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    side: BorderSide(
                      width: 1,
                      color: Config.letras,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Text("Foto $foto"),
                  color: Config.fondo,
                  textColor: Config.letras,
                  splashColor: Config.fondo,
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera, true, foto,
                        context: context);
                    //_showPicker(context, foto);
                  }),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                //  _onImageButtonPressed(ImageSource.camera, context: context);
              },
              child:
                Container(
                  decoration:BoxDecoration(
      border: Border.all(),
      ),
             child: SizedBox(
                  width: 250.0,
                  height: 350.0,
                  // gnore: unnecessary_null_comparison

                  child: !kIsWeb
                      ? _imageFileList != null
                          ? Image.file(File(_imageFileList.path),
                              fit: BoxFit.fill)
                          : Image.network(
                             Config.imagenFoto(widget.mercancia, foto),
                              fit: BoxFit.cover,
                              height: 90,
                            )
                      : _imageFileList != null
                          ? Image.network(_imageFileList.path,
                              fit: BoxFit.fill)
                          : Image.network(
                              Config.imagenFoto(widget.mercancia, foto),
                              fit: BoxFit.cover,
                              height: 90,
                            )),
            ),),
          ),
        ],
      );
    }




    ListView body = ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 30,
          color: Config.fondo,
          child: Text(
            "Categoria ${widget.categoria.categoria}",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Config.letras,
                fontSize: 16,
                fontStyle: FontStyle.italic),
          ),
        ),

        Container(
        width: double.infinity,
        height: 450,
        child:ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              picture(1, _imageFileList1),
              Container(width: 5, ),
              picture(2, _imageFileList2),
              Container(width: 5, ),
              picture(3, _imageFileList3),
              Container(width: 5)
            ])),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 20, left: 10,right: 10),
                      child: Text(
                        "${UserService.userOficina.numeroOficina}/"
                            "${dia}/"
                            "${mes}/",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Config.fondo,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),),
                  Container(width: 100, child: inputNombre),
                ],
              ),

              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10),
                  child: inputDescripcion),
              _outputs != null
                  ? Text('${_outputs![0]["label"]}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  background: Paint()..color = Colors.white,
                ),
              )
                  : Container()
            ],
          ),
        )
      ],
    );

    return _state==0?Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
                width: 50,
                child: IconButton(
                  icon: new Image.asset(Config.icono),
                  onPressed: () {},
                )),
          ],
          backgroundColor: Config.fondo,
          title: Text("Mercancía",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Config.letras,
              )),
          elevation: 0,
          centerTitle: true,
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Config.fondo,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 50,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Config.fondo,
          child: Icon(
            Icons.save_outlined,
            color: Config.letras,
            size: 30,
          ),
          onPressed: () async {
            bool esta=await  MercanciaService().estaElProducto("${UserService.userOficina.numeroOficina}/${dia}/${mes}/${inputNombre.controller!.text}");
            setState(() {
            if (_formKey.currentState!.validate()) {
              if(esta){
                Fluttertoast.showToast(
                    msg:
                    "Hay un mercancía con este referencia:\n\n${UserService.userOficina.numeroOficina}/${dia}/${mes}/${inputNombre.controller!.text}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 18.0);
              }else{

              _state=1;
              try {
                _formKey.currentState!.save();
                widget.mercancia.referenciaProducto =
                "${UserService.userOficina.numeroOficina}/${dia}/${mes}/${inputNombre.controller!.text}";
                widget.mercancia.plataforma =  UserService.userOficina
                    .nombre;
                widget.mercancia.descripcion = inputDescripcion.controller!.text;
                widget.mercancia.categoria = widget.categoria.categoria;
                widget.mercancia.fechaAlta = DateTime.now().toString();
                widget.mercancia.plataformaNumero = UserService.userOficina.numeroOficina;
                widget.mercancia.plataforma = UserService.userOficina.nombre;
                //var fechaNac = format.parse(fechaDeHoy);

                if (insertar) {
                  MercanciaService().addProducto(widget.mercancia);
                } else {
                  MercanciaService().updateProducto(widget.mercancia);
                }
                if (_imageFileList1 != null)
                  uploadFile(1, _imageFileList1!);
                if (_imageFileList2 != null)
                  uploadFile(2, _imageFileList2!);
                if (_imageFileList3 != null)
                  uploadFile(3, _imageFileList3!);
                _state = 0;
                Fluttertoast.showToast(
                    msg:
                    "Se ha guardado el mercancía",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.green.shade700,
                    textColor: Colors.white,
                    fontSize: 22.0);
                Navigator.pop(context, true);
              }
              catch(e){ Fluttertoast.showToast(
                  msg:
                  "No se ha guardado el\n\nmercancía:${widget.mercancia.referenciaProducto}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);

              }
              //_showGrabarDialog(context,widget.mercancía);
            }
            }});


          },
        ),
        body: body):Center(child:Container(child: CircularProgressIndicator()));

  }

  Future<bool?> _showGrabarDialog(
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
            Text('Se ha guardado la\nmercancía:${mercancia.referenciaProducto}',style: TextStyle(
              color: Colors.black, fontSize: 18,)),
            Container(height: 10,),
          ],),
          actions: <Widget>[
            TextButton(
              child:  Text('Aceptar',style:TextStyle(
                  fontSize: 16, color: Colors.black)),
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
    Future uploadFile(int foto, XFile _imageFileList) async {
    print("UPLLOAD");
    final _storage = FirebaseStorage.instance;

    //   await Permission.photos.request();

    // if (permissionStatus.isGranted) {
    //Select Image
    print("STORAGE:${_imageFileList.path}");
    var file = File(_imageFileList.path);
    setState(() {});

    if (_imageFileList != null) {
      print("STORAGE:${_imageFileList.path}");

      var compressedImage;
       if (!kIsWeb) {
        print("kIsWeb:${_imageFileList.path}");
        final tempDir = await getTemporaryDirectory();
        final path = tempDir.path;
       // Im.Image? image = Im.decodeImage(file.readAsBytesSync());
        //image = Im.copyResize(image!, width: 300,);
        // choose the size here, it will maintain aspect ratio
        //compressedImage = new File('$path/img_copy.png')
         // ..writeAsBytesSync(Im.encodePng(image, level:5));
      }
      //Upload to Firebase
      print("ANTES:${_imageFileList.path}");

      var snapshot;
      if (kIsWeb == false) {
        print("IOS:${_imageFileList.path}");

        snapshot = await _storage
            .ref()
            .child("productos"
                "/${widget.mercancia.referenciaProducto.replaceAll("/", "")}_$foto.png")
            .putFile(
            file,
                SettableMetadata(
                  contentType: 'image/png',
                ));
      } else {
        print("WEB:${_imageFileList.path}");
        Uint8List aux = await _imageFileList.readAsBytes();
        snapshot = await _storage
            .ref()
            .child("productos"
                "/${widget.mercancia.referenciaProducto..replaceAll("/", "")}_$foto.png")
            .putData(aux);
      }

      var downloadUrl = await snapshot.ref.getDownloadURL();
      print("DOWN:${downloadUrl}");
      setState(() {
        imageUrl = downloadUrl;
        if (kIsWeb == false) {
          compressedImage.delete();
        }
      });
    } else {
      print('No Path Received');
    }
    /* } else {
      print('Grant Permissions and try again');
    }*/
  }
}
