import 'dart:io';
import 'dart:typed_data';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/main.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;
import 'package:http/http.dart' show get;



/// Represents the PDF widget class.
class PdfJugadorDatosScout2 {
  PdfColor colorAzul = PdfColor(68, 114, 196);
  PdfColor colorNegro = PdfColor(0, 0, 0);
  PdfColor colorAzulClaro = PdfColor(0,138,216);
  PdfColor colorBlanco= PdfColor(255, 255, 255);
  // PdfColor colorSegundo= PdfColor(130, 5, 28);
  PdfColor colorGris= PdfColor(219,226,233);
  PdfColor colorVerde= PdfColor(170,219,30);
  PdfColor colorRojo= PdfColor(225,6,0);
  PdfColor colorAmarillo= PdfColor(255, 255, 0);
  PdfColor colorMorado= PdfColor(199,36,177);
  PdfColor colorNaranja= PdfColor(255, 165, 0);

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9,);
  final PdfFont contentFont12 = PdfStandardFont(PdfFontFamily.helvetica, 12);
  final PdfFont contentFont10 = PdfStandardFont(PdfFontFamily.helvetica, 10);
  final PdfFont contentFontCelda = PdfStandardFont(PdfFontFamily.helvetica, 8);
  final PdfFont contentFontCelda7 = PdfStandardFont(PdfFontFamily.helvetica, 7);
  final PdfFont contentFontCelda6 = PdfStandardFont(PdfFontFamily.helvetica, 6);
  final PdfFont contentFontCelda5 = PdfStandardFont(PdfFontFamily.helvetica, 5);
  final PdfFont contentFontCelda12 = PdfStandardFont(PdfFontFamily.courier, 20, style: PdfFontStyle.bold);
  final PdfFont contentFontCelda20 = PdfStandardFont(PdfFontFamily.courier, 20, style: PdfFontStyle.bold);
  final Player _jugador;
  final Equipo _equipo;
  final Temporada _temporada;
  final Categoria _categoria;
  final Pais _pais;



  List<Partido> _partidos;
  List<ImagenStorage> _imagenes=List();

  PdfJugadorDatosScout2(this._temporada,this._equipo, this._jugador, this._pais, this._categoria);
  double total=0;
  double promedio=0;

  CRUDEquipo dao = CRUDEquipo();

  Future<List<Partido>> partidosJornada() async {
    var partidos =await dao.getEquipoPartidos(
        _temporada, _pais, _categoria, _equipo);
    await new Future.delayed(new Duration(seconds: 1));
    partidos.sort((a, b) => a.jornada.compareTo(b.jornada));
    int longitudPuntuaciones=0;
    for (var i=0;i<partidos.length;i++) {
      partidos[i].putuacionJugadorPartido=new AccionPutuacionJugadorPartido();
      var imgequipo;
      if (partidos[i].equipoCASA == _equipo.equipo)
        partidos[i].putuacionJugadorPartido =await dao.getPuntosPartidos(
            _temporada, _pais, _categoria, _equipo, partidos[i], _jugador, "jugadoresCASA" );
      else
        partidos[i].putuacionJugadorPartido =await dao.getPuntosPartidos(
            _temporada, _pais, _categoria, _equipo, partidos[i], _jugador, "jugadoresFUERA" );

      double aux=0;
      try{
        aux=double.parse(partidos[i].putuacionJugadorPartido.putuacion);
        aux>0?longitudPuntuaciones++:null;

      }catch(o){
        aux=0;
      }

      total+=aux;
    }
    promedio=total/longitudPuntuaciones;
    _partidos= partidos;
    _partidos.sort((a, b) => a.jornada.compareTo(b.jornada));

    return partidos;
  }

   imagenesJornadaStorag()  async {
     await Config.imagenesClubes.forEach((element) {
       _imagenes.add(element);
       element.club;

      });


   }

    Future<List<dynamic>> imagenesJornada() async {
      for (var d in _partidos) {
        var imgequipo;
        if (d.equipoCASA == _equipo.equipo)
          imgequipo = await get(Uri.parse(
              Config.escudo(d.equipoFUERA)));
        else
          imgequipo = await get(Uri.parse(
              Config.escudo(d.equipoCASA)));
        ImagenStorage img = new ImagenStorage();
        img.imagen = imgequipo;
        if (d.equipoCASA == _equipo.equipo)
          img.club =d.equipoFUERA;
        else
          img.club =d.equipoCASA;

        _imagenes.add(img);

      }

  }



  Future<void> generateInvoice() async {

     await partidosJornada();
    await imagenesJornada();

    //Create a PDF document.
    final PdfDocument document = PdfDocument();
     document.pageSettings.size = PdfPageSize.a4;
//Change the page orientation to landscape
    document.pageSettings.orientation = PdfPageOrientation.landscape;

    //Add page to the PDF
    final PdfPage page = document.pages.add();
    final PdfPage page2 = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(colorNegro));

     var imgposicion = await get(Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/posicion%2F${_jugador.posicion.toLowerCase().replaceAll(" ", "")}.png?alt=media"));
    try{
      page.graphics.drawImage(
          PdfBitmap(imgposicion.bodyBytes.toList()),
          Rect.fromLTWH(652, 100, 105, 70));
      page2.graphics.drawImage(PdfBitmap(imgposicion.bodyBytes.toList()),
          Rect.fromLTWH(652, 100, 105, 70));
    }catch(e){}


    page2.graphics.drawString("Observaciones",
        PdfStandardFont(PdfFontFamily.helvetica, 10, ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(0, 330, 300, 30),
        pen: PdfPen(PdfColor(0, 0, 0), width : 0.5),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,
          ));

    page2.graphics.drawString(_jugador.observaciones,
    PdfStandardFont(PdfFontFamily.helvetica, 8, ),
    brush: PdfBrushes.black,
    bounds: Rect.fromLTWH(0, 350, 330, 200),
    format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.top,
    ));

    puntuaciones(page);

    List<String> caractFisico;
    List<String> caractDefensiva;
    List<String> caractOfensiva;
    List<String> caractPsicologia;
    if (_jugador.posicion.toUpperCase().contains("PORTERO")){
      caractFisico = Player.porteroFisico;
      caractDefensiva = Player.porteroDefensa;
      caractOfensiva = Player.porteroOfensivas;
      caractPsicologia = Player.porteroPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("LATERAL")){
      caractFisico = Player.lateralFisico;
      caractDefensiva = Player.lateralDefensa;
      caractOfensiva = Player.lateralOfensivas;
      caractPsicologia = Player.lateralPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("CARRILERO")){
      caractFisico = Player.carrileroFisico;
      caractDefensiva = Player.carrileroDefensa;
      caractOfensiva = Player.carrileroOfensivas;
      caractPsicologia = Player.carrileroPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("DEFENSA")){
      caractFisico = Player.centralFisico;
      caractDefensiva = Player.centralDefensa;
      caractOfensiva = Player.carrileroOfensivas;
      caractPsicologia = Player.centralPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("CENTRAL")){
      caractFisico = Player.centralFisico;
      caractDefensiva = Player.centralDefensa;
      caractOfensiva = Player.carrileroOfensivas;
      caractPsicologia = Player.centralPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("MEDIO")){
      caractFisico = Player.medioFisico;
      caractDefensiva = Player.medioDefensa;
      caractOfensiva = Player.medioOfensivas;
      caractPsicologia = Player.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("INTERIOR")){
      caractFisico = Player.medioFisico;
      caractDefensiva = Player.medioDefensa;
      caractOfensiva = Player.medioOfensivas;
      caractPsicologia = Player.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("CENTROCAMPISTA")){
      caractFisico = Player.medioFisico;
      caractDefensiva = Player.medioDefensa;
      caractOfensiva = Player.medioOfensivas;
      caractPsicologia = Player.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("PIVOTE")){
      caractFisico = Player.medioFisico;
      caractDefensiva = Player.medioDefensa;
      caractOfensiva = Player.medioOfensivas;
      caractPsicologia = Player.medioPsicologia;
    }else  if(_jugador.posicion.toUpperCase().contains("VOLANTE")){
      caractFisico = Player.medioFisico;
      caractDefensiva = Player.medioDefensa;
      caractOfensiva = Player.medioOfensivas;
      caractPsicologia = Player.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("DELANTERO")){
      caractFisico = Player.delanteroFisico;
      caractDefensiva = Player.delanteroDefensa;
      caractOfensiva = Player.delanteroOfensivas;
      caractPsicologia = Player.delanteroPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("PUNTA")) {
      caractFisico = Player.medioFisico;
      caractDefensiva = Player.medioDefensa;
      caractOfensiva = Player.medioOfensivas;
      caractPsicologia = Player.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("EXTREMO")) {
      caractFisico = Player.extremoFisico;
      caractDefensiva = Player.extremoDefensa;
      caractOfensiva = Player.extremoOfensivas;
      caractPsicologia = Player.extremoPsicologia;
    }else {
      caractFisico = Player.porteroFisico;
      caractDefensiva = Player.porteroDefensa;
      caractOfensiva = Player.porteroOfensivas;
      caractPsicologia = Player.porteroPsicologia;
    }
    final PdfGrid gridFisico = getGrid("Fisico",caractFisico);
    final PdfGrid gridDefensiva= getGrid("Defensiva",caractDefensiva);
    final PdfGrid gridOfensiva = getGrid("Ofensiva",caractOfensiva);
    final PdfGrid gridPsicologia = getGrid("Psicologia",caractPsicologia);


    //Added 30 as a margin for the layout
    drawHeader(page, pageSize,gridFisico,1);
    drawHeader(page2, pageSize,null,2);
    final PdfLayoutResult resultFisico= drawHeader(page, pageSize,gridFisico,1);
    final PdfLayoutResult resultOfensiva= drawHeader(page, pageSize, gridOfensiva,1);
    final PdfLayoutResult resultDefensiva= drawHeader(page, pageSize, gridDefensiva,1);
    final PdfLayoutResult resultPsicologia= drawHeader(page, pageSize, gridPsicologia,1);
    //Draw grid
    getGridPartidos(page,150);
    drawGridFisico(page2, gridFisico, resultFisico);
    drawGridDefensiva(page2, gridDefensiva, resultDefensiva);
    drawGridOfensiva(page2, gridOfensiva, resultOfensiva);
    drawGridPsicologia(page2, gridPsicologia, resultPsicologia);
    //Draw grid
    //drawGrid1(page, gridCapacidadesFisico1, result);
    //drawGrid2(page, gridCapacidadesFisico2, result2);
    //drawGrid(page, gridCapacidadesFisico3 , result);
    //Add invoice footer
    drawFooter(page, pageSize);
    drawFooter(page2, pageSize);
    //Get image bytes and set into PDF grid cell as PDF bitmap object


    var imgjugador = await get(Uri.parse(Config.imagenJugador(_equipo, _jugador)));

    var imgequipo = await get(Uri.parse(
    Config.escudo(_jugador.equipo)));

    try{
      page.graphics.drawImage(
          PdfBitmap(imgequipo.bodyBytes.toList()),
          Rect.fromLTWH(10, 10, 70, 70));
      page2.graphics.drawImage(PdfBitmap(imgequipo.bodyBytes.toList()),
          Rect.fromLTWH(10, 10, 70, 70));
    }catch(e){}
    //Added 30 as a margin for the layout
    try{
      page.graphics.setClip(
          path: PdfPath()..addEllipse(Rect.fromLTWH(685, 10, 55, 55)));
      page2.graphics.setClip(
          path: PdfPath()..addEllipse(Rect.fromLTWH(685, 10, 55, 55)));
      page.graphics.drawImage(
          PdfBitmap(imgjugador.bodyBytes.toList()),
          Rect.fromLTWH(685, 7,65,65));
      page2.graphics.drawImage(PdfBitmap(imgjugador.bodyBytes.toList()),
          Rect.fromLTWH(685, 7,65,65));
    }catch(e){
      page.graphics.drawImage(
          PdfBitmap(await getImageFileFromAssets("assets/img/icono.png")),
          Rect.fromLTWH(685, 5,60,75));
      page2.graphics.drawImage(
          PdfBitmap(await getImageFileFromAssets("assets/img/icono.png")),
          Rect.fromLTWH(685, 5,60,75));
    }



    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Get the storage folder location using path_provider package.
    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/${_jugador.idjugador}.pdf');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    await open_file.OpenFile.open('$path/${_jugador.idjugador}.pdf');
  }


  void puntuaciones(PdfPage page){
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(colorNegro),
        bounds: Rect.fromLTWH(650, 175, 1, page.size.height-170));

    page.graphics.drawString('Edad\n ${Config.edadSub(_jugador.fechaNacimiento)}',  PdfStandardFont(PdfFontFamily.helvetica, 15),
        brush: Config.edadSub(_jugador.fechaNacimiento)=="SUB-23"?PdfBrushes.green:PdfBrushes.red,
        bounds: Rect.fromLTWH(660, 170, 100, 50),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString('Ciclo 1: ${_jugador.nivel=="null"?"Sin nivel":_jugador.nivel}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.darkSlateBlue,
        bounds: Rect.fromLTWH(660, 210, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Ciclo 2: ${_jugador.nivel2=="null"?"Sin nivel":_jugador.nivel2}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.darkSlateBlue,
        bounds: Rect.fromLTWH(660, 225, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Ciclo 3: ${_jugador.nivel3=="null"?"Sin nivel":_jugador.nivel3}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.darkSlateBlue,
        bounds: Rect.fromLTWH(660, 240, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Ciclo 4: ${_jugador.nivel4=="null"?"Sin nivel":_jugador.nivel4}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.darkSlateBlue,
        bounds: Rect.fromLTWH(660, 255, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString("PUNTUACIÓN\n TOTAL",  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(660, 300, 100, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString("$total",  PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(660, 330, 100, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString("PROMEDIO",  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(660, 350, 100, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString("${promedio.toStringAsFixed(2)}",  PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(660, 380, 100, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString("INDICADOR\n SUBJETIVO PxP",  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(660, 410, 100, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString("${(promedio*total).toStringAsFixed(4)}",  PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(660, 440, 100, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString('${Player.tipoJugador(_jugador.posicion,_jugador.tipo)}',  PdfStandardFont(PdfFontFamily.helvetica, 9),
        brush: PdfBrushes.green,
        bounds: Rect.fromLTWH(10, 140, 600, 25),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));

  }

  void drawGridFisico(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
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
        page: page, bounds: Rect.fromLTWH(10, 180, 0, 0));
  }
  void drawGridPsicologia(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
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
        page: page, bounds: Rect.fromLTWH(200, 180, 0, 0));
  }
  void drawGridDefensiva(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
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
        page: page, bounds: Rect.fromLTWH(390, 180, 0, 0));
  }
  void drawGridOfensiva(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
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
        page: page, bounds: Rect.fromLTWH(580, 180, 0, 0));
  }


  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid, int indice) {
    //Draw rectangle
    header(page, pageSize, indice);
    //Create data foramt and convert it to text.

  }

  void header(PdfPage page, Size pageSize, int indice) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(colorNegro),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 95));
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(colorNegro),
        bounds: Rect.fromLTWH(10, 175, pageSize.width - 15, 1));

    //JUGADOR
    //Šipčić
    page.graphics.drawString(
        _jugador.jugador.replaceAll("č","c").replaceAll("Š","S").replaceAll("ć","c").replaceAll("š", "s").replaceAll("ã", "a").toUpperCase()
            +" - " +
        _jugador.posicion,
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 5, pageSize.width, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,alignment:PdfTextAlignment.center));
      page.graphics.drawString(
        _equipo.equipo.toUpperCase(), PdfStandardFont(PdfFontFamily.helvetica, 16),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 30, pageSize.width, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,alignment:PdfTextAlignment.center));
    page.graphics.drawString(
        "${_jugador.paisNacimiento.toUpperCase()} (${_jugador.nacionalidad.toUpperCase()})", PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 55, pageSize.width, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,alignment:PdfTextAlignment.center));
    page.graphics.drawString("Pie: ${_jugador.lateral.toUpperCase()}", PdfStandardFont(PdfFontFamily.helvetica, 8),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 67, pageSize.width , 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,alignment:PdfTextAlignment.center));
      page.graphics.drawString(
        _jugador.veredicto==""?"Sin veredicto":_jugador.veredicto.toUpperCase(), PdfStandardFont(PdfFontFamily.helvetica, 15),
        brush: PdfBrushes.yellow,
        bounds: Rect.fromLTWH(page.size.width-190, 63, 100, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle, alignment: PdfTextAlignment.center));

    //EMPRESA
   /* page.graphics.drawString('', PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));*/
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Nombre: ${_jugador.jugador.replaceAll("č","c").replaceAll("Š","S").replaceAll("Ž","Z").replaceAll("ž","Z").replaceAll("ć","c").replaceAll("š", "s").replaceAll("ã", "a")}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(10, 80, 300, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Categoria: ${_jugador.categoria}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(10, 95, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Pos. alternativa: ${_jugador.posicionalternativa}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(10, 110, 250, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));


    page.graphics.drawString('Fecha Nac.: ${_jugador.fechaNacimiento}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(260, 80, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString('Altura: ${_jugador.altura}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(260, 95, 300, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Peso: ${_jugador.peso}  ', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(260, 110, 300, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));

    //Create a new PDF true type font.
   // PdfTrueTypeFont font = new PdfTrueTypeFont(new Font("Arial", 12, FontStyle.Regular), true);

    //Draw the Unicode text
   // page.Graphics.DrawString("€ $ ¥", font, PdfBrushes.Black, new PointF(10, 10));
     String valorAux=_jugador.valor.replaceAll("€", "");
    page.graphics.drawString('Valor: ${valorAux}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(400, 80, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Prestamo: ${_jugador.prestamo}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(400, 95, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Contrato: ${_jugador.fechaContrato==null?'-':_jugador.fechaContrato}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(400, 110, 100, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));


    /*  PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));*/

    //Save the current graphics state
   // PdfGraphicsState state = page.graphics.save();

//Translate the coordinate system to the  required position
    //   page.graphics.translateTransform(20, 100);

//Apply transparency
    //   page.graphics.setTransparency(0.5);

//Rotate the coordinate system
    //   page.graphics.rotateTransform(-45);

//Draw image


  }



  PdfGrid getGrid(String aux, List<String> caract) {
//Create a PDF grid

    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 3);
    //Create the header row of the grid.
    final PdfGridRow headerRow1 = grid.headers.add(1)[0];
    //Set style
    headerRow1.style.backgroundBrush = PdfSolidBrush(colorNegro);
    headerRow1.style.textBrush = PdfBrushes.white;
    headerRow1.cells[0].value = 'Características ' +aux;
    headerRow1.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow1.cells[0].columnSpan=3;


    for(int i=0;i<caract.length;i++){
        final PdfGridRow row = grid.rows.add();
        row.cells[0].value = caract[i];
        row.cells[1].value="SI";
        row.cells[2].value="NO";
        row.cells[1].style.backgroundBrush=Player.dameElValor(caract[i], _jugador)==true?PdfSolidBrush(colorAzul):PdfSolidBrush(colorBlanco);
        row.cells[1].style.textBrush=Player.dameElValor(caract[i], _jugador)==true?PdfSolidBrush(colorBlanco):PdfSolidBrush(colorNegro);
        row.cells[2].style.backgroundBrush=Player.dameElValor(caract[i], _jugador)==false?PdfSolidBrush(colorAzul):PdfSolidBrush(colorBlanco);
        row.cells[2].style.textBrush=Player.dameElValor(caract[i], _jugador)==false?PdfSolidBrush(colorBlanco):PdfSolidBrush(colorNegro);


    }
    grid.columns[0].width = 120;
    grid.columns[1].width = 25;
    grid.columns[2].width = 25;
    for (int i = 0; i < headerRow1.cells.count; i++) {
      headerRow1.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        cell.stringFormat.alignment = PdfTextAlignment.center;
        cell.style.cellPadding =
            PdfPaddings(bottom: 0, left: 5, right: 5, top: 2);
        cell.style.font=contentFontCelda7;
      }
    }
    return grid;
  }


  getGridPartidos(PdfPage page, int posicion) async {
    int altura=180;
    double log=_partidos.length/2.round();
    for (int i=0;i<log.toInt();i++) {
           page.graphics.drawString("J. ${_partidos[i].jornada.toString()} - ${_partidos[i].fecha
            .toString()} ",
            PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
            format: PdfStringFormat(alignment: PdfTextAlignment.left,),
            bounds:  Rect.fromLTWH(10, altura.toDouble() , 90, 25),
            brush: PdfSolidBrush(colorNegro));
        page.graphics.drawString("${_partidos[i].equipoCASA==_equipo.equipo?"L":"V"}",
            PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
            format: PdfStringFormat(alignment: PdfTextAlignment.center,),
            bounds:  Rect.fromLTWH(100, altura.toDouble() , 10, 25),
            brush: PdfSolidBrush(_partidos[i].equipoCASA==_equipo.equipo?colorVerde:colorRojo));


        PdfColor  colorRES=colorResultado(_partidos[i]);
        page.graphics.drawString("${_partidos[i].golesCASA} - ${_partidos[i].golesFUERA}",
            PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
            format: PdfStringFormat(alignment: PdfTextAlignment.center,),
            bounds: Rect.fromLTWH(115, altura.toDouble(),20, 25),
            brush: PdfSolidBrush(colorRES,)
        );
           page.graphics.drawString("${_partidos[i].equipoCASA==_equipo.equipo?_partidos[i].equipoFUERA:_partidos[i].equipoCASA}",
          PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.italic),
          format: PdfStringFormat(alignment: PdfTextAlignment.left,),
          bounds: Rect.fromLTWH(160, altura.toDouble(),130, 25),
          brush: PdfSolidBrush(colorNegro,)
      );

           PdfColor color= colorAccion(_partidos[i]);

           page.graphics.drawRectangle(
               brush: PdfSolidBrush(color),
               bounds: Rect.fromLTWH(295, altura.toDouble(),20, 15));

           page.graphics.drawString(puntuacion(_partidos[i]),
               PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
               format: PdfStringFormat(alignment: PdfTextAlignment.center,),
               bounds: Rect.fromLTWH(295, altura.toDouble(),20, 15),
               brush: PdfSolidBrush(colorNegro,)
           );
      String equipo="";
      if(_partidos[i].equipoCASA==_equipo.equipo)
       equipo=_partidos[i].equipoFUERA;
      else
       equipo=_partidos[i].equipoCASA;

      try{
        var newList = _imagenes.firstWhere((element) => element.club == equipo);
         page.graphics.drawImage(
            PdfBitmap(newList.imagen.bodyBytes.toList()),
         Rect.fromLTWH(145, altura.toDouble(), 10, 10));

      }catch(e){
        print(e);
      }

           altura=altura+15;
    }
     altura=180;
    for (int i=log.toInt();i<_partidos.length;i++) {
      page.graphics.drawString("J. ${_partidos[i].jornada.toString()} - ${_partidos[i].fecha
          .toString()} ",
          PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.left,),
          bounds:  Rect.fromLTWH(330, altura.toDouble() , 90, 25),
          brush: PdfSolidBrush(colorNegro));
      page.graphics.drawString("${_partidos[i].equipoCASA==_equipo.equipo?"L":"V"}",
          PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(420, altura.toDouble() , 10, 25),
          brush: PdfSolidBrush(_partidos[i].equipoCASA==_equipo.equipo?colorVerde:colorRojo));

      page.graphics.drawString("${_partidos[i].golesCASA} - ${_partidos[i].golesFUERA}",
          PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds: Rect.fromLTWH(440, altura.toDouble(),20, 25),
          brush: PdfSolidBrush(colorNegro,)
      );
      page.graphics.drawString("${_partidos[i].equipoCASA==_equipo.equipo?_partidos[i].equipoFUERA:_partidos[i].equipoCASA}",
          PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.italic),
          format: PdfStringFormat(alignment: PdfTextAlignment.left,),
          bounds: Rect.fromLTWH(485, altura.toDouble(),130, 25),
          brush: PdfSolidBrush(colorNegro,)
      );
      PdfColor color= colorAccion(_partidos[i]);


      page.graphics.drawRectangle(
          brush: PdfSolidBrush(color),
          bounds: Rect.fromLTWH(615, altura.toDouble(),20, 15));


      page.graphics.drawString(puntuacion(_partidos[i]),
          PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds: Rect.fromLTWH(615, altura.toDouble(),20, 15),
          brush: PdfSolidBrush(colorNegro,)
      );
      String equipo="";
      if(_partidos[i].equipoCASA==_equipo.equipo)
        equipo=_partidos[i].equipoFUERA;
      else
        equipo=_partidos[i].equipoCASA;

      try{

        var newList = _imagenes.firstWhere((element) => element.club == equipo);
         page.graphics.drawImage(
            PdfBitmap(newList.imagen.bodyBytes.toList()),
            Rect.fromLTWH(470, altura.toDouble(), 10, 10));

      }catch(e){
        print(e);
      }
      //PdfBitmap(newList.imagen.bodyBytes.toList()),

      /*     var imgequipo ;
      if(_partidos[i].equipoCASA==_equipo.equipo)
        imgequipo=await get(Uri.parse("https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/clubes%2F${Config.escudoClubes(_partidos[i].equipoFUERA)}?alt=media"));
      else
        imgequipo=await get(Uri.parse("https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/clubes%2F${Config.escudoClubes(_partidos[i].equipoCASA)}?alt=media"));
      try{
        page.graphics.drawImage(
            PdfBitmap(imgequipo.bodyBytes.toList()),
            Rect.fromLTWH(600, altura.toDouble(), 25, 25));
      }catch(e){}
*/

      altura=altura+15;
    }

  }
  String puntuacion(Partido p) {
    String s=p.putuacionJugadorPartido.putuacion;
      if((p.golesFUERA=="")&&(p.golesFUERA=="")){
        s="";
      }
      if(p.putuacionJugadorPartido.accion=="SIM"){
        s=p.putuacionJugadorPartido.accion;
      }
      if(p.putuacionJugadorPartido.accion=="SV"){
        s=p.putuacionJugadorPartido.accion;
      }
      if(p.putuacionJugadorPartido.accion=="SC"){
        s=p.putuacionJugadorPartido.accion;
      }
      if(p.putuacionJugadorPartido.accion=="A"){
        s=p.putuacionJugadorPartido.accion;
      }
      if(p.putuacionJugadorPartido.accion=="SC"){
        s=p.putuacionJugadorPartido.accion;
      }
      if(p.putuacionJugadorPartido.accion=="T"){
        s=p.putuacionJugadorPartido.accion;
      }
    if(p.putuacionJugadorPartido.accion=="S"){
      s=p.putuacionJugadorPartido.accion;
    }
    if(p.putuacionJugadorPartido.accion=="NA"){
      s=p.putuacionJugadorPartido.accion;
    }
      return s;
  }

  PdfColor colorAccion(Partido p) {
    PdfColor color=colorBlanco;
    if(p.putuacionJugadorPartido.accion=="SIM"){
      color=colorGris;
    }
    if(p.putuacionJugadorPartido.accion=="SV"){
      color=colorMorado;
    }
    if(p.putuacionJugadorPartido.accion=="SC"){
      color=colorAzulClaro;
    }
    if(p.putuacionJugadorPartido.accion=="A"){
      color=colorRojo;
    }
    if(p.putuacionJugadorPartido.accion=="T"){
      color=colorVerde;
    }
    if(p.putuacionJugadorPartido.accion=="S"){
      color=colorNaranja;
    }
    if(p.putuacionJugadorPartido.accion=="EX"){
      color=colorRojo;
    }
    if(p.putuacionJugadorPartido.accion=="NA"){
      color=colorAmarillo;
    }
    return color;
  }


  PdfColor colorResultado(Partido p) {
    PdfColor color=colorNegro;
    if(p.golesFUERA==p.golesCASA){
      color=colorAzulClaro;
    }else{
      if(p.equipoCASA==_equipo.equipo){
        color=int.parse(p.golesCASA)>int.parse(p.golesFUERA)?
        colorVerde:
        colorRojo;
      }
      else{
        color=int.parse(p.golesCASA)>int.parse(p.golesFUERA)?
        colorRojo:
        colorVerde;
      }
    }
    return color;
  }


  Future<Uint8List> getImageFileFromAssets(String path) async {
    ByteData imageData1 = await rootBundle.load(path);
    return imageData1.buffer.asUint8List();
  }

  Future<Uint8List> getImageFileFromAssetsLogo(String path) async {
    ByteData imageData1 = await rootBundle.load(path);
    return imageData1.buffer.asUint8List();
  }
  /*final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file.path;*/


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

}
