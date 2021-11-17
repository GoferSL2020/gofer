
import 'package:fluttertoast/fluttertoast.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iadvancedscout/conf/config.dart';


import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:open_file/open_file.dart' as open_file;

import '../custom_icon_icons.dart';

class Imagen extends StatefulWidget {
  Imagen(this.imagen,this.titulo,this.subtitulo);
  final String imagen;
  final String titulo;
  final String subtitulo;
  @override
  _ImagenState createState() => _ImagenState();
}

class _ImagenState extends State<Imagen> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  PdfPageImage _pageImage;
  PdfPageImage _pageImage2;

  _ImagenState();

  @override
  void initState() {
    setState(()  {
      pageImage;

    });
    // TODO: implement initState

    super.initState();
  }



  Future<List<String>> get pageImage async {
  try {
      final document = await PdfDocument.openFile(widget.imagen);
      // Or open from data:
      // final document = await PdfDocument.openData(<Uint8List>);

      // Or open from file path:
      // final document = await PdfDocument.openFile('absolute/path/to/file');

      final page = await document.getPage(1); // Not index! Page number starts from 1
      final pageImageAux = await page.render(width: page.width, height: page.height);
      final page2 = await document.getPage(2); // Not index! Page number starts from 1
      final pageImageAux2 = await page2.render(width: page.width, height: page.height);

      // You can increase image quality:
      // final pageImage = await page.render(width: page.width * 3, height: page.height * 3);
      // Before open another page it is necessary to close the previous
      // The android platform does not allow parallel rendering
      await page.close();
      setState(() {
        _pageImage=pageImageAux;
        _pageImage2=pageImageAux2;
      });

  } on PlatformException catch (error) {
  // Handle render error
  print(error);
  }
}

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: new Image.asset(Config.icono),
            onPressed: () {
              //var a = singOut();
              //if (a != null) {
              //}
            },
          )
        ],
        backgroundColor: Colors.black,
        title: Text("IAScout - ${widget.titulo}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
              children: <Widget>[
              Container(
              padding: EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 5),
              height: 40,
              width: double.infinity,
              color: Colors.black,
              child: Text(
              "${widget.subtitulo}",
              textAlign: TextAlign.center,
              style: TextStyle(
              color: Colors.white,
              fontSize: 14,
                  fontWeight: FontWeight.bold),
              ),
              ),
                _pageImage!=null?
                Image(
                  image: MemoryImage(_pageImage.bytes),
                ):Container(),
                _pageImage2!=null?
                Image(
                  image: MemoryImage(_pageImage2.bytes),
                ):Container(),

                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                   RaisedButton.icon(
                      onPressed: () async {
                           await Config.saveImage(_pageImage.bytes, _pageImage2.bytes) ?
                            Fluttertoast.showToast(
                            msg: "Se ha grabado",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green.shade900,
                            textColor: Colors.white,
                            fontSize: 14.0):
                            Fluttertoast.showToast(
                            msg: "No se ha grabado",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red.shade900,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      },
                      label: Text(
                        "Guardar a Fotos",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      icon: Icon(
                        CustomIcon.save,
                        size: 20,
                        color: Colors.white,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.black,
                      color: Colors.blue),

                  RaisedButton.icon(
                      onPressed: () async {
                        await open_file.OpenFile.open(widget.imagen);
                      },
                      label: Text(
                        "Abrir el PDF",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      icon: Icon(
                        CustomIcon.file_pdf,
                        size: 20,
                        color: Colors.white,
                      ),
                      textColor: Colors.white,
                      splashColor: Colors.black,
                      color: Colors.blue)
                ]),
              ],
      ));
}
}
