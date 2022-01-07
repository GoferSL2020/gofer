import 'dart:io';
import 'dart:typed_data';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/main.dart';
import 'package:iadvancedscout/model/partidosJugadores.dart';
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
class PdfEquipoTemporada {
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
  final Equipo _equipo;
  final Temporada _temporada;
  final Categoria _categoria;
  final Pais _pais;


  List<Player> _jugadores;
  List<Partido> _partidos;
  List<ImagenStorage> _imagenes=List();

  PdfEquipoTemporada(this._temporada,this._equipo, this._pais, this._categoria);
  double total=0;
  double promedio=0;

  CRUDEquipo dao = CRUDEquipo();



  Future<PartidoJugadores> partidoPartidoJugadores() async {
    _partidos=[];
    _partidos=await CRUDEquipo().getEquipoPartidos(_temporada, _pais, _categoria, _equipo);
    await new Future.delayed(new Duration(seconds: 3));
    //_partidos=partidosAux;
    _partidos.sort((a,b)=>a.jornada.compareTo(b.jornada));
    _jugadores=[];
    _jugadores= await CRUDJugador().fetchJugadores(_temporada, _pais, _categoria, _equipo.equipo);
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

     await partidoPartidoJugadores();

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
    page2.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(colorNegro));


    //Added 30 as a margin for the layout
    drawHeader(page, pageSize,1);
    drawHeader(page2, pageSize,1);
    //Draw grid
    getGridPartidos(page,page2,100);
    //Draw grid
    //drawGrid1(page, gridCapacidadesFisico1, result);
    //drawGrid2(page, gridCapacidadesFisico2, result2);
    //drawGrid(page, gridCapacidadesFisico3 , result);
    //Add invoice footer
    drawFooter(page, pageSize);
    drawFooter(page2, pageSize);
    //Get image bytes and set into PDF grid cell as PDF bitmap object


    var imgcategoria = await get(Uri.parse(Config.escudoCategoria(_categoria.categoria)));

    try{
      page.graphics.drawImage(
          PdfBitmap(imgcategoria.bodyBytes.toList()),
          Rect.fromLTWH(pageSize.width-50,10, 40, 40));
      page2.graphics.drawImage(PdfBitmap(imgcategoria.bodyBytes.toList()),
          Rect.fromLTWH(pageSize.width-50, 10, 40, 40));
    }catch(e){
      print(e.toString());
    }

    var imgequipo = await get(Uri.parse(
        Config.escudo(_equipo.equipo)));

    try{
      page.graphics.drawImage(
          PdfBitmap(imgequipo.bodyBytes.toList()),
          Rect.fromLTWH(10, 10, 70, 70));
      page2.graphics.drawImage(PdfBitmap(imgequipo.bodyBytes.toList()),
          Rect.fromLTWH(10, 10, 70, 70));
    }catch(e){
      print(e.toString());
    }
    //Added 30 as a margin for the layout
    try{
      page.graphics.setClip(
          path: PdfPath()..addEllipse(Rect.fromLTWH(685, 10, 55, 55)));
      page2.graphics.setClip(
          path: PdfPath()..addEllipse(Rect.fromLTWH(685, 10, 55, 55)));

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
    final File file = File('$path/${_equipo.equipo}.pdf');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    await open_file.OpenFile.open('$path/${_equipo.equipo}.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, int indice) {
    //Draw rectangle
    header(page, pageSize, indice);
    //Create data foramt and convert it to text.

  }

  void header(PdfPage page, Size pageSize, int indice) {
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(colorNegro),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 55));
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(colorNegro),
        bounds: Rect.fromLTWH(5, 100, pageSize.width - 5, 1));

    //JUGADOR
    //Šipčić
       page.graphics.drawString(
        _equipo.equipo.toUpperCase(), PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 15, pageSize.width, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,alignment:PdfTextAlignment.center));
    /*page.graphics.drawString(
        _categoria.categoria.replaceAll("ª","").replaceAll("ó", "o").toUpperCase(), contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,alignment:PdfTextAlignment.center));
*/

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


  getGridPartidos(PdfPage page, PdfPage page2,int posicion) async {
    int jornadas=_partidos.length;
    int altura=105;
    int ancho=105;
    int anchoMAX=30;
    if(jornadas<36)
      anchoMAX=35;
    double log=_partidos.length/2.round();
    for (int i=0;i<_jugadores.length;i++) {
     page.graphics.drawString("${_jugadores[i].dorsal==-2?"*":_jugadores[i].dorsal}. ${_jugadores[i].jugador.replaceAll("č","c").replaceAll("Š","S").replaceAll("ć","c").replaceAll("š", "s").replaceAll("ã", "a")}",
      PdfStandardFont(PdfFontFamily.helvetica, 7, style: PdfFontStyle.bold),
      format: PdfStringFormat(alignment: PdfTextAlignment.left,),
      bounds:  Rect.fromLTWH(10, altura.toDouble() , 120, 25),
      brush: PdfSolidBrush(colorNegro));
     page2.graphics.drawString("${_jugadores[i].dorsal==-2?"*":_jugadores[i].dorsal}. ${_jugadores[i].jugador.replaceAll("č","c").replaceAll("Š","S").replaceAll("ć","c").replaceAll("š", "s").replaceAll("ã", "a")}",
         PdfStandardFont(PdfFontFamily.helvetica, 7, style: PdfFontStyle.bold),
         format: PdfStringFormat(alignment: PdfTextAlignment.left,),
         bounds:  Rect.fromLTWH(10, altura.toDouble() , 120, 25),
         brush: PdfSolidBrush(colorNegro));

     altura=altura+13;
    }
    for (int j=0;j<log.toInt();j++) {
      page.graphics.drawString("Jor.${_partidos[j].jornada}",
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(ancho.toDouble(), 55 , 30, 25),
          brush: PdfSolidBrush(colorNegro));
      page.graphics.drawString("${_partidos[j].fecha}",
          PdfStandardFont(PdfFontFamily.helvetica, 5, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(ancho.toDouble(), 65 , 30, 15),
          brush: PdfSolidBrush(colorNegro));
      page.graphics.drawString("${_partidos[j].equipoCASA==_equipo.equipo?"L":"V"}",
          PdfStandardFont(PdfFontFamily.helvetica, 7, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(ancho.toDouble(), 72 , 10, 15),
          brush: PdfSolidBrush(_partidos[j].equipoCASA==_equipo.equipo?colorVerde:colorRojo));
      page.graphics.drawString("${_partidos[j].golesCASA}-${_partidos[j].golesFUERA}",
          PdfStandardFont(PdfFontFamily.helvetica, 7, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(ancho.toDouble()+5, 72 , 30, 15),
          brush: PdfSolidBrush(colorResultado(_partidos[j])));
      String equipo="";
      if(_partidos[j].equipoCASA==_equipo.equipo)
        equipo=_partidos[j].equipoFUERA;
      else
        equipo=_partidos[j].equipoCASA;
      try{
        var newList = _imagenes.firstWhere((element) => element.club == equipo);
        page.graphics.drawImage(
            PdfBitmap(newList.imagen.bodyBytes.toList()),
            Rect.fromLTWH(ancho.toDouble()+5,80,18,18));

      }catch(e){
        print(e);
      }
      altura=105;
      for(int k=0;k<_jugadores.length;k++) {
        print("${_partidos[j].jornada}:${_jugadores[k].jugador}:${_jugadores[k].puntaciones_jornada_1}:${_jugadores[k].puntaciones_jornada_2}");
        PdfColor color= colorAccion(puntuacionJornada(_partidos[j], _jugadores[k]));
        page.graphics.drawRectangle(
            brush: PdfSolidBrush(color),
            bounds: Rect.fromLTWH(ancho.toDouble(), altura.toDouble(),30, 15));
        page.graphics.drawString(puntuacionJornada(_partidos[j], _jugadores[k]),
            PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
            format: PdfStringFormat(alignment: PdfTextAlignment.center,),
            bounds: Rect.fromLTWH(ancho.toDouble(), altura.toDouble(),30, 15),
            brush: PdfSolidBrush(colorNegro,)
        );
        altura=altura+13;
      }
      ancho=ancho+anchoMAX;
    }
    ancho=105;
    for (int j=log.toInt();j<_partidos.length;j++) {
      page2.graphics.drawString("Jor.${_partidos[j].jornada}",
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(ancho.toDouble(), 55 , 30, 25),
          brush: PdfSolidBrush(colorNegro));
      page2.graphics.drawString("${_partidos[j].fecha}",
          PdfStandardFont(PdfFontFamily.helvetica, 5, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(ancho.toDouble(), 65 , 30, 15),
          brush: PdfSolidBrush(colorNegro));
      page2.graphics.drawString("${_partidos[j].equipoCASA==_equipo.equipo?"L":"V"}",
          PdfStandardFont(PdfFontFamily.helvetica, 7, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(ancho.toDouble(), 72 , 10, 15),
          brush: PdfSolidBrush(_partidos[j].equipoCASA==_equipo.equipo?colorVerde:colorRojo));
      page2.graphics.drawString("${_partidos[j].golesCASA}-${_partidos[j].golesFUERA}",
          PdfStandardFont(PdfFontFamily.helvetica, 7, style: PdfFontStyle.bold),
          format: PdfStringFormat(alignment: PdfTextAlignment.center,),
          bounds:  Rect.fromLTWH(ancho.toDouble()+5, 72 , 30, 15),
          brush: PdfSolidBrush(colorResultado(_partidos[j])));
      String equipo="";
      if(_partidos[j].equipoCASA==_equipo.equipo)
        equipo=_partidos[j].equipoFUERA;
      else
        equipo=_partidos[j].equipoCASA;
      try{
        var newList = _imagenes.firstWhere((element) => element.club == equipo);
        page2.graphics.drawImage(
            PdfBitmap(newList.imagen.bodyBytes.toList()),
            Rect.fromLTWH(ancho.toDouble()+5,80,18,18));

      }catch(e){
        print(e);
      }

      altura=105;
      for(int k=0;k<_jugadores.length;k++) {
        print("${_partidos[j].jornada}:${_jugadores[k].jugador}:${_jugadores[k].accion}:${_jugadores[k].puntuacion}");
        PdfColor color= colorAccion(puntuacionJornada(_partidos[j], _jugadores[k]));
        page2.graphics.drawRectangle(
            brush: PdfSolidBrush(color),
            bounds: Rect.fromLTWH(ancho.toDouble(), altura.toDouble(),30, 15));
        page2.graphics.drawString(puntuacionJornada(_partidos[j], _jugadores[k]),
            PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
            format: PdfStringFormat(alignment: PdfTextAlignment.center,),
            bounds: Rect.fromLTWH(ancho.toDouble(), altura.toDouble(),30, 15),
            brush: PdfSolidBrush(colorNegro));
        altura=altura+13;
      }
      ancho=ancho+anchoMAX;
    }

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

  String puntuacion(Partido p, Player jug) {
    String s=jug.puntuacion.toString();
    if((p.golesFUERA=="")&&(p.golesFUERA=="")){
      s="";
    }
    if(jug.puntuacion=="SIM"){
      s=jug.puntuacion;
    }
    if(jug.puntuacion=="SV"){
      s=jug.puntuacion;
    }
    if(jug.puntuacion=="SC"){
      s=jug.puntuacion;
    }
    if(jug.puntuacion=="A"){
      s=jug.puntuacion;
    }
    if(jug.puntuacion=="NA"){
      s=jug.puntuacion;
    }
    if(jug.puntuacion=="T"){
      s=jug.puntuacion;
    }
    if(jug.puntuacion=="S"){
      s=jug.puntuacion;
    }
    if(jug.puntuacion=="A"){
      s=jug.puntuacion;
    }
    print(s);
    return s;
  }

  String puntuacionJornada(Partido p, Player jug) {
    String s="";
    if(p.jornada==1) s=jug.puntaciones_jornada_1;
    if(p.jornada==2) s=jug.puntaciones_jornada_2;
    if(p.jornada==3) s=jug.puntaciones_jornada_3;
    if(p.jornada==4) s=jug.puntaciones_jornada_4;
    if(p.jornada==5) s=jug.puntaciones_jornada_5;
    if(p.jornada==6) s=jug.puntaciones_jornada_6;
    if(p.jornada==7) s=jug.puntaciones_jornada_7;
    if(p.jornada==8) s=jug.puntaciones_jornada_8;
    if(p.jornada==9) s=jug.puntaciones_jornada_9;
    if(p.jornada==10) s=jug.puntaciones_jornada_10;
    if(p.jornada==11) s=jug.puntaciones_jornada_11;
    if(p.jornada==12) s=jug.puntaciones_jornada_12;
    if(p.jornada==13) s=jug.puntaciones_jornada_13;
    if(p.jornada==14) s=jug.puntaciones_jornada_14;
    if(p.jornada==15) s=jug.puntaciones_jornada_15;
    if(p.jornada==16) s=jug.puntaciones_jornada_16;
    if(p.jornada==17) s=jug.puntaciones_jornada_17;
    if(p.jornada==18) s=jug.puntaciones_jornada_18;
    if(p.jornada==19) s=jug.puntaciones_jornada_19;
    if(p.jornada==20) s=jug.puntaciones_jornada_20;
    if(p.jornada==21) s=jug.puntaciones_jornada_21;
    if(p.jornada==22) s=jug.puntaciones_jornada_22;
    if(p.jornada==23) s=jug.puntaciones_jornada_23;
    if(p.jornada==24) s=jug.puntaciones_jornada_24;
    if(p.jornada==25) s=jug.puntaciones_jornada_25;
    if(p.jornada==26) s=jug.puntaciones_jornada_26;
    if(p.jornada==27) s=jug.puntaciones_jornada_27;
    if(p.jornada==28) s=jug.puntaciones_jornada_28;
    if(p.jornada==29) s=jug.puntaciones_jornada_29;
    if(p.jornada==30) s=jug.puntaciones_jornada_30;
    if(p.jornada==31) s=jug.puntaciones_jornada_31;
    if(p.jornada==32) s=jug.puntaciones_jornada_32;
    if(p.jornada==33) s=jug.puntaciones_jornada_33;
    if(p.jornada==34) s=jug.puntaciones_jornada_34;
    if(p.jornada==35) s=jug.puntaciones_jornada_35;
    if(p.jornada==36) s=jug.puntaciones_jornada_36;
    if(p.jornada==37) s=jug.puntaciones_jornada_37;
    if(p.jornada==38) s=jug.puntaciones_jornada_38;
    if(p.jornada==39) s=jug.puntaciones_jornada_39;
    if(p.jornada==40) s=jug.puntaciones_jornada_40;
    if(p.jornada==41) s=jug.puntaciones_jornada_41;
    if(p.jornada==42) s=jug.puntaciones_jornada_42;
    if(p.jornada==43) s=jug.puntaciones_jornada_43;
    if(p.jornada==44) s=jug.puntaciones_jornada_44;
    if(p.jornada==45) s=jug.puntaciones_jornada_45;
    if(p.jornada==46) s=jug.puntaciones_jornada_46;
    if(s==null)s="";
    print(s);
    return s;
  }

  PdfColor colorAccion(String accion) {
    PdfColor color=colorBlanco;
    if(accion=="SIM"){
      color=colorGris;
    }
    if(accion=="SV"){
      color=colorMorado;
    }
    if(accion=="SC"){
      color=colorAzulClaro;
    }
    if(accion=="A"){
      color=colorRojo;
    }
    if(accion=="T"){
      color=colorVerde;
    }
    if(accion=="S"){
      color=colorNaranja;
    }
    if(accion=="EX"){
      color=colorRojo;
    }
    if(accion=="NA"){
      color=colorAmarillo;
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
