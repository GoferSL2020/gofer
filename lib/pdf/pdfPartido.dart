import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iadvancedscout/conf/config.dart';

import 'package:iadvancedscout/model/jugadorJornada.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;
import 'package:http/http.dart' show get;

/// Represents the PDF widget class.
class PDFPartido {
  PdfColor colorAzul = PdfColor(10, 51, 110);
  PdfColor colorNegro = PdfColor(0, 0, 0);
  PdfColor colorAzulClaro = PdfColor(223, 247, 248);
  PdfColor colorBlanco= PdfColor(255, 255, 255);
  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9,);
  final PdfFont contentFont12 = PdfStandardFont(PdfFontFamily.helvetica, 12);
  final PdfFont contentFont10 = PdfStandardFont(PdfFontFamily.helvetica, 10);
  final PdfFont contentFontCelda = PdfStandardFont(PdfFontFamily.helvetica, 8);
  final PdfFont contentFontCelda7 = PdfStandardFont(PdfFontFamily.helvetica, 7);
  final PdfFont contentFontCelda6 = PdfStandardFont(PdfFontFamily.helvetica, 6);
  final PdfFont contentFontCelda5 = PdfStandardFont(PdfFontFamily.helvetica, 5);
  final PdfFont contentFontCeldaCampo = PdfStandardFont(
      PdfFontFamily.helvetica, 30);

  final List<JugadorJornada> jugadores;
   List<JugadorJornada> jugadoresPorteros=new List();
   List<JugadorJornada> jugadoresDefensas=new List();
   List<JugadorJornada> jugadoresCentrocampistas=new List();
   List<JugadorJornada> jugadoresDelanteros=new List();
  List<JugadorJornada> jugadoresPorterosSUB=new List();
  List<JugadorJornada> jugadoresDefensasSUB=new List();
  List<JugadorJornada> jugadoresCentrocampistasSUB=new List();
  List<JugadorJornada> jugadoresDelanterosSUB=new List();


  PDFPartido({@required this.jugadores,
  });

  ponerJugadores() {
    String medios = "";
    String volantes = "";
    String central = "";
    String extremos = "";

    for (JugadorJornada doc in jugadores) {
      print(doc.posicion);
      if (doc.posicion.toUpperCase().contains("LATERAL IZQUIERDO")) {

        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresDefensasSUB.add(doc);
        else
          jugadoresDefensas.add(doc);
      }
      if (doc.posicion.toUpperCase().contains("LATERAL DERECHO")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresDefensasSUB.add(doc);
        else
        jugadoresDefensas.add(doc);
      }

      if (doc.posicion.toUpperCase().contains("DEFENSA")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresDefensasSUB.add(doc);
        else
        jugadoresDefensas.add(doc);
      }

      if (doc.posicion.toUpperCase().contains("MEDIO")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresCentrocampistasSUB.add(doc);
        else
        jugadoresCentrocampistas.add(doc);
      }

      if (doc.posicion.toUpperCase().contains("VOLANTE")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresCentrocampistasSUB.add(doc);
        else
        jugadoresCentrocampistas.add(doc);
      }
      if (doc.posicion.toUpperCase().contains("INTERIOR")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresCentrocampistasSUB.add(doc);
        else
        jugadoresCentrocampistas.add(doc);
      }
      if (doc.posicion.toUpperCase().contains("PIVOTE")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresCentrocampistasSUB.add(doc);
        else
        jugadoresCentrocampistas.add(doc);
      }
      if (doc.posicion.toUpperCase().contains("MEDIA")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresCentrocampistasSUB.add(doc);
        else
        jugadoresCentrocampistas.add(doc);
      }
      if (doc.posicion.toUpperCase().contains("PORTERO")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresPorterosSUB.add(doc);
        else
        jugadoresPorteros.add(doc);
      }

      if (doc.posicion.toUpperCase().contains("DELANTERO")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresDelanterosSUB.add(doc);
        else
        jugadoresDelanteros.add(doc);
      }

      if (doc.posicion.toUpperCase().contains("EXTREMO IZQUIERDO")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresDelanterosSUB.add(doc);
        else
        jugadoresDelanteros.add(doc);
      }
      if (doc.posicion.toUpperCase().contains("EXTREMO DERECHO")) {
        if (Config.edadSub(doc.fechaNacimiento).contains("Sub"))
          jugadoresDelanterosSUB.add(doc);
        else
        jugadoresDelanteros.add(doc);
      }
    }

  }




  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Set the page size
    document.pageSettings.size = PdfPageSize.a4;

//Change the page orientation to landscape
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    final PdfPage page2 = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    //page.graphics.drawRectangle(bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height), pen: PdfPen(PdfColor(142, 170, 219, 255)));
    drawFooter(page, pageSize);
    drawFooter(page2, pageSize);
    ponerJugadores();
    jugadoresPosicion(page,1);
    jugadoresPosicion(page2,1);
    final PdfGrid medios = PdfGrid();
    final PdfGrid porteros = PdfGrid();
    final PdfGrid delanteros = PdfGrid();
    final PdfGrid defensas = PdfGrid();
    final PdfGrid mediosSUB = PdfGrid();
    final PdfGrid porterosSUB = PdfGrid();
    final PdfGrid delanterosSUB = PdfGrid();
    final PdfGrid defensasSUB = PdfGrid();
    await getGridJugadores(page,medios,jugadoresCentrocampistas,372);
    await getGridJugadores(page,defensas,jugadoresDefensas,180);
    await getGridJugadores(page,porteros,jugadoresPorteros,6);
    await getGridJugadores(page,delanteros,jugadoresDelanteros,562);
    await getGridJugadores(page2,mediosSUB,jugadoresCentrocampistasSUB,372);
    await getGridJugadores(page2,defensasSUB,jugadoresDefensasSUB,180);
    await getGridJugadores(page2,porterosSUB,jugadoresPorterosSUB,6);
    await getGridJugadores(page2,delanterosSUB,jugadoresDelanterosSUB,562);


    final PdfLayoutResult resultJugadores1= drawHeader(page, pageSize, medios,1);

    final PdfLayoutResult resultJugadores2= drawHeader(page2, pageSize, medios,1);

    drawGridDatosJugadoresMedios(page, medios, resultJugadores1);
    drawGridDatosJugadoresDefensas(page, defensas, resultJugadores1);
    drawGridDatosJugadoresPorteros(page, porteros, resultJugadores1);
    drawGridDatosJugadoresDelanteros(page, delanteros, resultJugadores1);

    drawGridDatosJugadoresMedios(page2, mediosSUB, resultJugadores1);
    drawGridDatosJugadoresDefensas(page2, defensasSUB, resultJugadores1);
    drawGridDatosJugadoresPorteros(page2, porterosSUB, resultJugadores1);
    drawGridDatosJugadoresDelanteros(page2, delanterosSUB, resultJugadores1);

    await header(page, pageSize, "GENERAL");
    await header(page2, pageSize, "Sub-23");

//Add invoice footer
    // drawFooter(page, pageSize);
    // drawFooter(page2, pageSize2);
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Set the page size
    //Get the storage folder location using path_provider package.
    final Directory directory =
    await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/output.pdf');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    await open_file.OpenFile.open('$path/output.pdf');
  }

  Future header(PdfPage page, Size pageSize, String titulo) async {
     page.graphics.drawRectangle(
        brush: PdfSolidBrush(colorNegro),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
    page.graphics.drawImage(
        PdfBitmap(await getImageFileFromAssets(
            "assets/img/ia_logotipo.png")),
        Rect.fromLTWH(630, 0, 120, 120));
    page.graphics.drawImage(
        PdfBitmap(await getImageFileFromAssets(
            "assets/img/icono.png")),
        Rect.fromLTWH(15, 5, 80, 80));
    page.graphics.drawString("${jugadores[0].categoria} - Jornada:${jugadores[0].jornada}",
        PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold),
        format: PdfStringFormat(alignment: PdfTextAlignment.center,),
        bounds: Rect.fromLTWH(0, 50,pageSize.width, 100),
        brush: PdfSolidBrush(colorBlanco)
    );
     page.graphics.drawString(titulo,
         PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold),
         format: PdfStringFormat(alignment: PdfTextAlignment.center,),
         bounds: Rect.fromLTWH(0, 10,pageSize.width, 100),
         brush: PdfSolidBrush(colorBlanco)
     );
  }

  void drawGridDatosJugadoresPorteros(PdfPage page, PdfGrid grid, PdfLayoutResult result) async {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(30, 140, 0, 0));
  }

  void drawGridDatosJugadoresDefensas(PdfPage page, PdfGrid grid, PdfLayoutResult result) async {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(210, 140, 0, 0));
  }

  void drawGridDatosJugadoresDelanteros(PdfPage page, PdfGrid grid, PdfLayoutResult result) async {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(590, 140, 0, 0));
  }

  void drawGridDatosJugadoresMedios(PdfPage page, PdfGrid grid, PdfLayoutResult result) async {

    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(400, 140, 0, 0));
  }
//Create PDF grid and return
  Future<PdfGrid> getGridJugadores(PdfPage page, PdfGrid grid, List<JugadorJornada> jugadoresAux, int posicion) async{
    //Create a PDF grid

    //Secify the columns count to the grid.
    grid.columns.add(count: 3);
    //Create the header row of the grid.

    double i=0;
    for (JugadorJornada doc in jugadoresAux) {
      double altura=i*33;
      i++;
      //Add rows
      var imgequipo = await get(Uri.parse(
          Config.escudo(doc.equipo)));
      try{
        page.graphics.drawImage(
            PdfBitmap(imgequipo.bodyBytes.toList()),
            Rect.fromLTWH(posicion.roundToDouble(), 144+altura, 22, 22));
      }catch(e){}
      final PdfGridRow row1 = grid.rows.add();
      final PdfGridRow row = grid.rows.add();
      row1.cells[0].value= doc.jugador.toString();
      row1.cells[0].columnSpan=3;
      row1.cells[0].style.font =contentFontCelda7;

      row1.height=13;
      row.height=20;
      row.cells[0].value= doc.equipo;
      row.cells[1].value= doc.posicion.toString();
      row.cells[2].value= Config.edad(doc.fechaNacimiento);
      row.cells[0].style.font =contentFontCelda6;
      row.cells[1].style.font =contentFontCelda6;
      row.cells[2].style.font =contentFontCelda6;
    }


    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable4);
    //Set gird columns width
    grid.columns[0].width = 70;
    grid.columns[1].width = 50;
    grid.columns[2].width = 20;


    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      //row.height=30;
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        cell.style.borders.bottom.color = new PdfColor(255,255,255);
        cell.stringFormat.alignment = PdfTextAlignment.center;
        cell.style.cellPadding =
            PdfPaddings(bottom: 2, left: 2, right:2, top: 2);

      }
    }
    return grid;
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(colorNegro),
        bounds: Rect.fromLTWH(0, pageSize.height-20, pageSize.width, 20));

    const String footerContent =
    '''InAdvanced by Equalia. Avda. de la Albufera 321, 28031 (Madrid), Any Questions? inAdvanced@inAdvanced.com''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        brush: PdfSolidBrush(colorBlanco),
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
        bounds: Rect.fromLTWH(0, pageSize.height - 15, pageSize.width, 0));
  }


  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid, int indice)  {
    //Draw rectangle
    //Create data foramt and convert it to text.

  }
  void jugadoresPosicion(PdfPage page, int indice) {

    //Rotate graphics to 90 degree
    //page.graphics.rotateTransform(-90);
//lateral derecho

    final Size pageSize = page.getClientSize();
    //brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    //Added 30 as a margin for the layout
    //pivote
    page.graphics.drawString("PORTEROS",
        PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
        format: PdfStringFormat(alignment: PdfTextAlignment.left,),
        bounds: Rect.fromLTWH(50, 100,350, 140),
        brush: PdfSolidBrush(colorNegro)
    );
    page.graphics.drawString("DEFENSAS",
        PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
        format: PdfStringFormat(alignment: PdfTextAlignment.left,),
        bounds: Rect.fromLTWH(220, 100,350, 140),
        brush: PdfSolidBrush(colorNegro)
    );
    page.graphics.drawString("CENTROCAMPISTAS",
        PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
        format: PdfStringFormat(alignment: PdfTextAlignment.left,),
        bounds: Rect.fromLTWH(380, 100,350, 140),
        brush: PdfSolidBrush(colorNegro)
    );
    page.graphics.drawString("DELANTERO",
        PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
        format: PdfStringFormat(alignment: PdfTextAlignment.left,),
        bounds: Rect.fromLTWH(600, 100,350, 140),
        brush: PdfSolidBrush(colorNegro)
    );

  }


  Future campos(PdfPage page) async {
    //Draw text
   /* page.graphics.drawImage(
        PdfBitmap(await getImageFileFromAssets(
            "assets/img/campoblanco.png")),
        Rect.fromLTWH(0, 0, page.size.width -100, page.size.height -100));
*/
  }


  Future<Uint8List> getImageFileFromAssets(String path) async {
    ByteData imageData1 = await rootBundle.load(path);
    return imageData1.buffer.asUint8List();
  }

  Future<Uint8List> getImageFileFromAssetsLogo(String path) async {
    ByteData imageData1 = await rootBundle.load(path);
    return imageData1.buffer.asUint8List();
  }

}


