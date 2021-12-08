import 'dart:io';
import 'dart:typed_data';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/equipo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;
import 'package:http/http.dart' show get;

/// Represents the PDF widget class.
class PdfEntrenadorDatos {
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

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 8,);
  final PdfFont contentFont8 = PdfStandardFont(PdfFontFamily.helvetica, 8,);
  final PdfFont contentFont12 = PdfStandardFont(PdfFontFamily.helvetica, 12);
  final PdfFont contentFont10 = PdfStandardFont(PdfFontFamily.helvetica, 10);
  final PdfFont contentFontCelda = PdfStandardFont(PdfFontFamily.helvetica, 8);
  final PdfFont contentFontCelda7 = PdfStandardFont(PdfFontFamily.helvetica, 7);
  final PdfFont contentFontCelda6= PdfStandardFont(PdfFontFamily.helvetica, 5);

  final Entrenador _entrenador;
  final Equipo _equipo;
  final Temporada _temporada;

  PdfEntrenadorDatos(this._temporada,this._equipo, this._entrenador);

  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    final PdfPage page2 = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(colorNegro));


    page2.graphics.drawString("Observaciones",
        PdfStandardFont(PdfFontFamily.helvetica, 16, ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(15, 200, 300, 30),
        pen: PdfPen(PdfColor(0, 0, 0), width : 0.5),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,
          ));

    page2.graphics.drawString(_entrenador.observaciones,
    PdfStandardFont(PdfFontFamily.helvetica, 12, ),
    brush: PdfBrushes.black,
    bounds: Rect.fromLTWH(15, 230, page2.size.width-100, page2.size.width-50),
    format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.top,
    ));

    List<String> caractConceptualestructuralHabitual;
    List<String> caractConceptualplanteamientoTacticoGeneral;
    List<String> caractConceptualestructuracionJuegoColectivo;
    List<String> caractConceptualadaptabilidadJuegoColectivo;
    List<String> caractFormalocupacionRacionalEspacio;
    List<String> caractFormalasentamientoDefensivo;
    List<String> caractFormalasentamientoOfensivo;
    List<String> caractFormalespaciosdeintervencion;
    List<String> caractFuncionalinicioDeJuego;
    List<String> caractFuncionalprogresionFinalizacioJuego;
    List<String> caractFuncionaltransicionesDefensivas;
    List<String> caractFuncionaljuegoDefensivo;
    List<String> caractFuncionaltransicionesOfensivas;
    List<String> caractFuncionalritmosDeJuego;
    List<String> caractFuncionalgradosDeLibertad;
    List<String> caractFuncionalvariabilidadEstrategeciaLocalVisitante;





    caractConceptualestructuralHabitual = Entrenador.estructuralHabitual;
    caractConceptualplanteamientoTacticoGeneral = Entrenador.planteamientoTacticoGeneral;
    caractConceptualestructuracionJuegoColectivo = Entrenador.estructuracionJuegoColectivo;
    caractConceptualadaptabilidadJuegoColectivo = Entrenador.adaptabilidadJuegoColectivo;

    caractFormalocupacionRacionalEspacio=Entrenador.ocupacionRacionalEspacio;
    caractFormalasentamientoDefensivo=Entrenador.asentamientoDefensivo;
    caractFormalasentamientoOfensivo=Entrenador.asentamientoOfensivo;
    caractFormalespaciosdeintervencion=Entrenador.espaciosdeintervencion;

    caractFuncionalinicioDeJuego=Entrenador.inicioDeJuego;
    caractFuncionalprogresionFinalizacioJuego=Entrenador.progresionFinalizacioJuego;
    caractFuncionaltransicionesDefensivas=Entrenador.transicionesDefensivas;
    caractFuncionaljuegoDefensivo=Entrenador.juegoDefensivo;
    caractFuncionaltransicionesOfensivas=Entrenador.transicionesOfensivas;
    caractFuncionalritmosDeJuego=Entrenador.ritmosDeJuego;
    caractFuncionalgradosDeLibertad=Entrenador.gradosDeLibertad;
    caractFuncionalvariabilidadEstrategeciaLocalVisitante=Entrenador.variabilidadEstrategeciaLocalVisitante;


    final PdfGrid gridConceptual1 = getGrid("Estructural Habitual",caractConceptualestructuralHabitual,1);
    final PdfGrid gridConceptual2= getGrid("Planteamiento Táctico General",caractConceptualplanteamientoTacticoGeneral,1);
    final PdfGrid gridConceptual3 = getGrid("Estructuración Juego Colectivo",caractConceptualestructuracionJuegoColectivo,1);
    final PdfGrid gridConceptual4 = getGrid("Adaptabilidad Juego Colectivo",caractConceptualadaptabilidadJuegoColectivo,1);

    final PdfGrid gridFormal1 = getGrid("Ocupación Racional Espacio",caractFormalocupacionRacionalEspacio,2);
    final PdfGrid gridFormal2= getGrid("Asentamiento Defensivo",caractFormalasentamientoDefensivo,2);
    final PdfGrid gridFormal3 = getGrid("Asentamiento Ofensivo",caractFormalasentamientoOfensivo,2);
    final PdfGrid gridFormal4 = getGrid("Espacios de Intervención",caractFormalespaciosdeintervencion,2);
    final PdfGrid gridFuncional1 = getGrid("Inicio de Juego",caractFuncionalinicioDeJuego,3);
    final PdfGrid gridFuncional2= getGrid("Progresión Finalizacion Juego",caractFuncionalprogresionFinalizacioJuego,3);
    final PdfGrid gridFuncional3 = getGrid("Transiciones Defensivas",caractFuncionaltransicionesDefensivas,3);
    final PdfGrid gridFuncional4 = getGrid("Juego Defensivo",caractFuncionaljuegoDefensivo,3);
    final PdfGrid gridFuncional5 = getGrid("Transiciones Ofensivas",caractFuncionaltransicionesOfensivas,3);
    final PdfGrid gridFuncional6 = getGrid("Ritmos de Juego",caractFuncionalritmosDeJuego,3);
    final PdfGrid gridFuncional7 = getGrid("Grados de Libertad",caractFuncionalgradosDeLibertad,3);
    final PdfGrid gridFuncional8 = getGrid("Variabilidad Estrategía Local/Visitante",caractFuncionalvariabilidadEstrategeciaLocalVisitante,3);



    caractFuncionalinicioDeJuego=Entrenador.inicioDeJuego;
    caractFuncionalprogresionFinalizacioJuego=Entrenador.progresionFinalizacioJuego;
    caractFuncionaltransicionesDefensivas=Entrenador.transicionesDefensivas;
    caractFuncionaljuegoDefensivo=Entrenador.juegoDefensivo;
    caractFuncionaltransicionesOfensivas=Entrenador.transicionesOfensivas;
    caractFuncionalritmosDeJuego=Entrenador.ritmosDeJuego;
    caractFuncionalgradosDeLibertad=Entrenador.gradosDeLibertad;
    caractFuncionalvariabilidadEstrategeciaLocalVisitante=Entrenador.variabilidadEstrategeciaLocalVisitante;

    //Added 30 as a margin for the layout
    drawHeader(page, pageSize,null,1);
    drawHeader(page2, pageSize,null,2);

    gridConceptual1.draw(
        page: page, bounds: Rect.fromLTWH(10, 170, 0, 0));
    gridConceptual2.draw(
        page: page, bounds: Rect.fromLTWH(10, 360, 0, 0));
    gridConceptual3.draw(
        page: page, bounds: Rect.fromLTWH(10, 450, 0, 0));
    gridConceptual4.draw(
        page: page, bounds: Rect.fromLTWH(10, 530, 0, 0));

    gridFormal1.draw(
        page: page, bounds: Rect.fromLTWH(180, 170, 0, 0));
    gridFormal2.draw(
        page: page, bounds: Rect.fromLTWH(180, 285, 0, 0));
    gridFormal3.draw(
        page: page, bounds: Rect.fromLTWH(180, 360, 0, 0));
    gridFormal4.draw(
        page: page, bounds: Rect.fromLTWH(180, 450, 0, 0));

    page.graphics.drawString('Variante defensiva: ${_entrenador.for_variante_defensiva==null?'-':_entrenador.for_variante_defensiva}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(180, 510, 200, 150),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.top));
    page.graphics.drawString('Variante ofensiva: ${_entrenador.for_variante_ofensiva==null?'-':_entrenador.for_variante_ofensiva}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(180, 600, 200, 150),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.top));


    gridFuncional1.draw(
        page: page, bounds: Rect.fromLTWH(350, 170, 0, 0));
    gridFuncional2.draw(
        page: page, bounds: Rect.fromLTWH(350, 240, 0, 0));
    gridFuncional3.draw(
        page: page, bounds: Rect.fromLTWH(350, 295, 0, 0));
    gridFuncional4.draw(
        page: page, bounds: Rect.fromLTWH(350, 380, 0, 0));
    gridFuncional5.draw(
        page: page, bounds: Rect.fromLTWH(350, 450, 0, 0));
    gridFuncional6.draw(
        page: page, bounds: Rect.fromLTWH(350, 520, 0, 0));
    gridFuncional7.draw(
        page: page, bounds: Rect.fromLTWH(350, 600, 0, 0));
    gridFuncional8.draw(
        page: page, bounds: Rect.fromLTWH(350, 670, 0, 0));
    //Draw grid
    //drawGrid1(page, gridCapacidadesFisico1, result);
    //drawGrid2(page, gridCapacidadesFisico2, result2);
    //drawGrid(page, gridCapacidadesFisico3 , result);
    //Add invoice footer
    drawFooter(page, pageSize);
    drawFooter(page2, pageSize);
    //Get image bytes and set into PDF grid cell as PDF bitmap object


    var imgjugador = await get(Uri.parse(Config.imagenEntrenador(_entrenador)));

    var imgequipo = await get(Uri.parse(
    Config.escudo(_entrenador.equipo)));

    try{
      page.graphics.drawImage(
          PdfBitmap(imgequipo.bodyBytes.toList()),
          Rect.fromLTWH(10, 10, 50, 50));
      page2.graphics.drawImage(PdfBitmap(imgequipo.bodyBytes.toList()),
          Rect.fromLTWH(10, 10, 50, 50));
    }catch(e){}
    //Added 30 as a margin for the layout
    page.graphics.setClip(
        path: PdfPath()..addEllipse(Rect.fromLTWH(430, 15, 55, 55)));
    page2.graphics.setClip(
        path: PdfPath()..addEllipse(Rect.fromLTWH(430, 15, 55, 55)));
    try{
      page.graphics.drawImage(
          PdfBitmap(imgjugador.bodyBytes.toList()),
          Rect.fromLTWH(425, 15,65,65));
      page2.graphics.drawImage(PdfBitmap(imgjugador.bodyBytes.toList()),
          Rect.fromLTWH(425, 15,65,65));
    }catch(e){
      page.graphics.drawImage(
          PdfBitmap(await getImageFileFromAssets("assets/img/icono.png")),
          Rect.fromLTWH(430, 5,60,75));
      page2.graphics.drawImage(
          PdfBitmap(await getImageFileFromAssets("assets/img/icono.png")),
          Rect.fromLTWH(430, 5,60,75));
    }



    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Get the storage folder location using path_provider package.
    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/output.pdf');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    await open_file.OpenFile.open('$path/output.pdf');
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
        page: page, bounds: Rect.fromLTWH(10, 215, 0, 0));
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
        page: page, bounds: Rect.fromLTWH(260, 215, 0, 0));
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
        page: page, bounds: Rect.fromLTWH(10, 380, 0, 0));
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
        page: page, bounds: Rect.fromLTWH(260, 380, 0, 0));
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
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //JUGADOR
    //Šipčić
    page.graphics.drawString(_entrenador.entrenador.replaceAll("č","c").replaceAll("Š","S").replaceAll("ć","c").replaceAll("š", "s").replaceAll("ã", "a").toUpperCase(),
        PdfStandardFont(PdfFontFamily.helvetica, 16),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(150, 10, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        "${_entrenador.paisNacimiento.toUpperCase()} (${_entrenador.nacionalidad.toUpperCase()})", PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(150, 50, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        _entrenador.equipo, PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(15, 60, 200, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle, alignment: PdfTextAlignment.left));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0,pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(0, 0, 0 )));

    //EMPRESA
    page.graphics.drawString('', PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Nombre: ${_entrenador.entrenador.replaceAll("č","c").replaceAll("Š","S").replaceAll("Ž","Z").replaceAll("ž","Z").replaceAll("ć","c").replaceAll("š", "s").replaceAll("ã", "a")}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(10, 80, 300, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Equipo: ${_entrenador.equipo}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(10, 95, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Categoria: ${_entrenador.categoria}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(10, 110, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Fecha: ${_entrenador.fechaNacimiento}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(400, 80, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Edad: ${Config.edadSub(_entrenador.fechaNacimiento)}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: Config.edadSub(_entrenador.fechaNacimiento)=="SUB-23"?PdfBrushes.green:PdfBrushes.red,
        bounds: Rect.fromLTWH(400, 95, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString(
        _entrenador.activo==""?"Activo":_entrenador.activo.toUpperCase(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        brush: _entrenador.activo=="Activo"?PdfBrushes.green:PdfBrushes.red,
        bounds: Rect.fromLTWH(400, 125, 200, 33),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle, alignment: PdfTextAlignment.left));

    //Create a new PDF true type font.
   // PdfTrueTypeFont font = new PdfTrueTypeFont(new Font("Arial", 12, FontStyle.Regular), true);

    //Draw the Unicode text
   // page.Graphics.DrawString("€ $ ¥", font, PdfBrushes.Black, new PointF(10, 10));

    page.graphics.drawString('Fecha Fichaje: ${_entrenador.fechaFichaje==null?'-':_entrenador.fechaFichaje}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(155, 80, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Fecha Fin de contrato: ${_entrenador.fechaFinContrato==null?'-':_entrenador.fechaFinContrato}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(155, 95, 200, 33),
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



  PdfGrid getGrid(String aux, List<String> caract, int color) {
//Create a PDF grid
    
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 3);
    //Create the header row of the grid.
    final PdfGridRow headerRow1 = grid.headers.add(1)[0];
    //Set style
    if(color==1)
      headerRow1.style.backgroundBrush = PdfSolidBrush(colorNegro);
    if(color==2)
      headerRow1.style.backgroundBrush = PdfSolidBrush(colorNegro);
    if(color==3)
      headerRow1.style.backgroundBrush = PdfSolidBrush(colorNegro);
     //headerRow1.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));

    headerRow1.style.textBrush = PdfBrushes.white;
    headerRow1.cells[0].value = aux;
    headerRow1.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow1.cells[0].columnSpan=3;


    for(int i=0;i<caract.length;i++){
        final PdfGridRow row = grid.rows.add();
        row.cells[0].value = caract[i];
        row.cells[1].value="SI";
        row.cells[2].value="NO";
        row.cells[1].style.backgroundBrush=Entrenador.dameElValor(caract[i], _entrenador)==true?PdfSolidBrush(colorAzul):PdfSolidBrush(colorBlanco);
        row.cells[1].style.textBrush=Entrenador.dameElValor(caract[i], _entrenador)==true?PdfSolidBrush(colorBlanco):PdfSolidBrush(colorNegro);
        row.cells[2].style.backgroundBrush=Entrenador.dameElValor(caract[i], _entrenador)==false?PdfSolidBrush(colorAzul):PdfSolidBrush(colorBlanco);
        row.cells[2].style.textBrush=Entrenador.dameElValor(caract[i], _entrenador)==false?PdfSolidBrush(colorBlanco):PdfSolidBrush(colorNegro);


    }
    grid.columns[0].width = 90;
    grid.columns[1].width = 35;
    grid.columns[2].width = 35;
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