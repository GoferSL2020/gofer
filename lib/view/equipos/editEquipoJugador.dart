import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
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
  PickedFile _imageFile;
  String imageUrl;
  File _image;
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

  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,imageQuality: 20,
        maxHeight:  100 , maxWidth: 100);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 20,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
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
        if (value.isEmpty) {
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
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 55  ,
              backgroundColor: Colors.black,
              child:  new SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: _imageFile != null
                    //https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/
                        ? Image.file(File(_imageFile.path), fit: BoxFit.fill)
                        : Image.network("https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/"
                        "o/clubes"
                        "%2F${widget.equipo.equipo.replaceAll("Ñ", "N").replaceAll("ñ", "n")}.png"
                        "?alt=media",
                            fit: BoxFit.cover,height: 90,
                          )),
            ),
          ),
        )
      ],
    );

    Future<DateTime> getDate() {
      // Imagine that this function is
      // more complex and slow.
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050),
        locale : const Locale("es","ES"),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
      );
    }

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
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      widget.equipo.equipo = inputNombre.controller.text;
                       if(insertar) {
                          await equipoProvider.addEquipo(widget.pais,
                            widget.equipo);
                      }else {
                        await equipoProvider.updateEquipo(widget.pais,
                            widget.equipo);
                      }
                      if(_imageFile!=null)
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
    final _picker = ImagePicker();
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

   // if (permissionStatus.isGranted) {
      //Select Image
      print("STORAGE:${_imageFile.path}");
      var file = File(_imageFile.path);
    setState(() {});
      print("STORAGE:${_imageFile.path}");

      if (_imageFile != null) {
        final tempDir = await getTemporaryDirectory();
        final path = tempDir.path;

        Im.Image image = Im.decodeImage(file.readAsBytesSync());
        image= Im.copyResize(image,width: 500,);
        // choose the size here, it will maintain aspect ratio
        var compressedImage = new File('$path/img_copy.png')..writeAsBytesSync(Im.encodePng(image,level: 4));


        //Upload to Firebase
        var snapshot =
            await _storage.ref().child(
                "clubes"
                    "/${widget.equipo.equipo.replaceAll("Ñ", "N").
                replaceAll("ñ", "n")}.png").putFile(compressedImage, SettableMetadata(contentType: 'image/png',));
        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          compressedImage.delete();
        });
      } else {
        print('No Path Received');
      }
   /* } else {
      print('Grant Permissions and try again');
    }*/
  }


  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    print("testCompressAndGetFile");
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 90,
      minWidth: 100,
      minHeight: 100,
      rotate: 0,
    );


    return result;
  }
}
