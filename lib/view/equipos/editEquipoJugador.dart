import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/dao/CRUDEquipoJugador.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/wigdet/abajo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

class EditEquipoJugador extends StatefulWidget {
  static String tag = 'edit-page';
  final EquipoJugador  equipo;
  final Pais pais;
  EditEquipoJugador(this.equipo,this.pais);

  @override
  _EditEquipoJugadorState createState() => _EditEquipoJugadorState();
}

class _EditEquipoJugadorState extends State<EditEquipoJugador> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();

   String? imageUrl;
   XFile? _imageFileList;
  bool insertar=false;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();


  @override
  void dispose() {
    _nombre.dispose();

    super.dispose();
  }

  @override
  void initState() {

    _nombre.text = widget.equipo.equipo;

    insertar= widget.equipo.equipo==""?true:false;

    super.initState();
  }



  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
          try{
              final XFile? pickedFile = await _picker.pickImage(
                source: ImageSource.gallery,
                maxWidth: 100,
                maxHeight: 100,
                imageQuality: 100,
              );
              setState(() {
                _imageFileList= pickedFile!;

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
    final equipoProvider = new CRUDEquipoJugador();

    TextFormField inputNombre = TextFormField(
      controller: _nombre,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Equipo',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
    );



    Column picture = Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _onImageButtonPressed(ImageSource.camera, context: context);
            },
            child: CircleAvatar(
              radius: 55  ,
              backgroundColor: Colors.black,
              child:  new SizedBox(
                    width: 120.0,
                    height: 120.0,
                    // ignore: unnecessary_null_comparison

                    child:
                    !kIsWeb?
                     _imageFileList != null
                    //https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/
                        ? Image.file(File(_imageFileList!.path), fit: BoxFit.fill)
                        : Image.network("https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/"
                        "o/clubes"
                        "%2F${widget.equipo.equipo.replaceAll("Ñ", "N").replaceAll("ñ", "n")}.png"
                        "?alt=media",
                            fit: BoxFit.cover,height: 90,
                            )
                  :_imageFileList != null
                    //https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/
                    ? Image.network(_imageFileList!.path, fit: BoxFit.fill)
                        : Image.network("https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/"
                    "o/clubes"
                    "%2F${widget.equipo.equipo.replaceAll("Ñ", "N").replaceAll("ñ", "n")}.png"
                    "?alt=media",
                    fit: BoxFit.cover,height: 90,
                    ))
              ,
            ),
          ),
        )
      ],
    );



    ListView body = ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(width: double.infinity,
          color:Colors.black,
          child:Text(
            "Equipo",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.italic),
          ),),
        picture,
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(width: 340,
                  padding: EdgeInsets.only(left: 10),child:
              inputNombre),
            ],
          ),
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[

            Container(
              width: 40,
              child: IconButton(
                  icon: Icon(Icons.save_outlined,size: 30, color: Colors.blue,),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.equipo.equipo = inputNombre.controller!.text;
                       if(insertar) {
                          await equipoProvider.addEquipo(widget.pais,
                            widget.equipo);
                      }else {
                        await equipoProvider.updateEquipo(widget.pais,
                            widget.equipo);
                      }
                      if(_imageFileList!=null)
                        await uploadFile();
                      Navigator.pop(context);
                    }
                  }),
            )
          ],
          backgroundColor: Colors.black,
          title: Text("FootFeel - Equipos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Config.colorFootFeel,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBar: Abajo(),
        body: body);
  }

  Future uploadFile() async {
    print("UPLLOAD");
    final _storage = FirebaseStorage.instance;

    //   await Permission.photos.request();

   // if (permissionStatus.isGranted) {
      //Select Image
      print("STORAGE:${_imageFileList!.path}");
      var file = File(_imageFileList!.path);
    setState(() {});

      if (_imageFileList != null) {
        print("STORAGE:${_imageFileList!.path}");

        var compressedImage;
        if (!kIsWeb) {
          print("kIsWeb:${_imageFileList!.path}");
          final tempDir = await getTemporaryDirectory();
          final path = tempDir.path;
          Im.Image? image = Im.decodeImage(file.readAsBytesSync());
          image = Im.copyResize(image!, width: 100,);
          // choose the size here, it will maintain aspect ratio
           compressedImage = new File('$path/img_copy.png')
            ..writeAsBytesSync(Im.encodePng(image, level: 4));
        }
        //Upload to Firebase
        print("ANTES:${_imageFileList!.path}");

        var snapshot;
          if(kIsWeb==false) {
            print("IOS:${_imageFileList!.path}");

            snapshot= await _storage.ref().child(
                "clubes"
                    "/${widget.equipo.equipo.replaceAll("Ñ", "N").
                replaceAll("ñ", "n")}.png").putFile(
                compressedImage, SettableMetadata(contentType: 'image/png',));
          }else {
            print("WEB:${_imageFileList!.path}");
            Uint8List aux=await _imageFileList!.readAsBytes();
            snapshot=await _storage.ref().child(
                "clubes"
                    "/${widget.equipo.equipo.replaceAll("Ñ", "N").
                replaceAll("ñ", "n")}.png").putData(aux);
          }

        var downloadUrl = await snapshot.ref.getDownloadURL();
        print("DOWN:${downloadUrl}");
        setState(() {
          imageUrl = downloadUrl;
          if(kIsWeb==false) {
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
