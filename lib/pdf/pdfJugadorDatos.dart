import 'dart:io';
import 'dart:typed_data';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets/font.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;
import 'package:http/http.dart' show get;

/// Represents the PDF widget class.
class PdfJugadorDatos {
  PdfColor colorAzul = PdfColor(10, 51, 110);
  PdfColor colorBlanco = PdfColor(255, 255, 255);
  PdfColor colorAzulClaro = PdfColor(203, 247, 248);
  PdfColor colorNegro = PdfColor(0, 0, 0);
  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 8,);
  final PdfFont contentFont8 = PdfStandardFont(PdfFontFamily.helvetica, 8,);
  final PdfFont contentFont12 = PdfStandardFont(PdfFontFamily.helvetica, 12);
  final PdfFont contentFont10 = PdfStandardFont(PdfFontFamily.helvetica, 10);
  final PdfFont contentFontCelda = PdfStandardFont(PdfFontFamily.helvetica, 8);
  final PdfFont contentFontCelda7 = PdfStandardFont(PdfFontFamily.helvetica, 7);
  final PdfFont contentFontCelda6= PdfStandardFont(PdfFontFamily.helvetica, 5);

  final Jugador _jugador;

  PdfJugadorDatos(this._jugador);

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

    var imgposicion = await get(Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/posicion%2F${_jugador.posicion.toLowerCase().replaceAll(" ", "")}.png?alt=media"));
    try{
      page.graphics.drawImage(
          PdfBitmap(imgposicion.bodyBytes.toList()),
          Rect.fromLTWH(15, 100, 60, 90));
      page2.graphics.drawImage(PdfBitmap(imgposicion.bodyBytes.toList()),
          Rect.fromLTWH(15, 100, 60, 90));
    }catch(e){}


    page2.graphics.drawString("Observaciones",
        PdfStandardFont(PdfFontFamily.helvetica, 16, ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(15, 200, 300, 30),
        pen: PdfPen(PdfColor(0, 0, 0), width : 0.5),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle,
          ));

    page2.graphics.drawString(_jugador.observaciones_1,
    PdfStandardFont(PdfFontFamily.helvetica, 12, ),
    brush: PdfBrushes.black,
    bounds: Rect.fromLTWH(15, 230, page2.size.width-100, page2.size.width-50),
    format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.top,
    ));

    List<String> caractFisico;
    List<String> caractDefensiva;
    List<String> caractOfensiva;
    List<String> caractPsicologia;
    if (_jugador.posicion.toUpperCase().contains("PORTERO")){
      caractFisico = Jugador.porteroFisico;
      caractDefensiva = Jugador.porteroDefensa;
      caractOfensiva = Jugador.porteroOfensivas;
      caractPsicologia = Jugador.porteroPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("LATERAL")){
      caractFisico = Jugador.lateralFisico;
      caractDefensiva = Jugador.lateralDefensa;
      caractOfensiva = Jugador.lateralOfensivas;
      caractPsicologia = Jugador.lateralPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("CARRILERO")){
      caractFisico = Jugador.carrileroFisico;
      caractDefensiva = Jugador.carrileroDefensa;
      caractOfensiva = Jugador.carrileroOfensivas;
      caractPsicologia = Jugador.carrileroPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("DEFENSA")){
      caractFisico = Jugador.centralFisico;
      caractDefensiva = Jugador.centralDefensa;
      caractOfensiva = Jugador.carrileroOfensivas;
      caractPsicologia = Jugador.centralPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("CENTRAL")){
      caractFisico = Jugador.centralFisico;
      caractDefensiva = Jugador.centralDefensa;
      caractOfensiva = Jugador.carrileroOfensivas;
      caractPsicologia = Jugador.centralPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("MEDIO")){
      caractFisico = Jugador.medioFisico;
      caractDefensiva = Jugador.medioDefensa;
      caractOfensiva = Jugador.medioOfensivas;
      caractPsicologia = Jugador.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("INTERIOR")){
      caractFisico = Jugador.medioFisico;
      caractDefensiva = Jugador.medioDefensa;
      caractOfensiva = Jugador.medioOfensivas;
      caractPsicologia = Jugador.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("CENTROCAMPISTA")){
      caractFisico = Jugador.medioFisico;
      caractDefensiva = Jugador.medioDefensa;
      caractOfensiva = Jugador.medioOfensivas;
      caractPsicologia = Jugador.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("PIVOTE")){
      caractFisico = Jugador.medioFisico;
      caractDefensiva = Jugador.medioDefensa;
      caractOfensiva = Jugador.medioOfensivas;
      caractPsicologia = Jugador.medioPsicologia;
    }else  if(_jugador.posicion.toUpperCase().contains("VOLANTE")){
      caractFisico = Jugador.medioFisico;
      caractDefensiva = Jugador.medioDefensa;
      caractOfensiva = Jugador.medioOfensivas;
      caractPsicologia = Jugador.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("DELANTERO")){
      caractFisico = Jugador.delanteroFisico;
      caractDefensiva = Jugador.delanteroDefensa;
      caractOfensiva = Jugador.delanteroOfensivas;
      caractPsicologia = Jugador.delanteroPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("PUNTA")) {
      caractFisico = Jugador.medioFisico;
      caractDefensiva = Jugador.medioDefensa;
      caractOfensiva = Jugador.medioOfensivas;
      caractPsicologia = Jugador.medioPsicologia;
    }else if (_jugador.posicion.toUpperCase().contains("EXTREMO")) {
      caractFisico = Jugador.extremoFisico;
      caractDefensiva = Jugador.extremoDefensa;
      caractOfensiva = Jugador.extremoOfensivas;
      caractPsicologia = Jugador.extremoPsicologia;
    }else {
      caractFisico = Jugador.porteroFisico;
      caractDefensiva = Jugador.porteroDefensa;
      caractOfensiva = Jugador.porteroOfensivas;
      caractPsicologia = Jugador.porteroPsicologia;
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
    drawGridFisico(page, gridFisico, resultFisico);
    drawGridDefensiva(page, gridDefensiva, resultDefensiva);
    drawGridOfensiva(page, gridOfensiva, resultOfensiva);
    drawGridPsicologia(page, gridPsicologia, resultPsicologia);
    //Draw grid
    //drawGrid1(page, gridCapacidadesFisico1, result);
    //drawGrid2(page, gridCapacidadesFisico2, result2);
    //drawGrid(page, gridCapacidadesFisico3 , result);
    //Add invoice footer
    drawFooter(page, pageSize);
    drawFooter(page2, pageSize);
    //Get image bytes and set into PDF grid cell as PDF bitmap object


    var imgjugador = await get(Uri.parse(Config.imagenJugador(_jugador)));

    var imgequipo = await get(Uri.parse(
    Config.escudo(_jugador.equipo)));

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
          Rect.fromLTWH(425, 8,65,65));
      page2.graphics.drawImage(PdfBitmap(imgjugador.bodyBytes.toList()),
          Rect.fromLTWH(425, 8,65,65));
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
    page.graphics.drawString(_jugador.jugador.replaceAll("č","c").replaceAll("Š","S").replaceAll("ć","c").replaceAll("š", "s").replaceAll("ã", "a").toUpperCase(),
        PdfStandardFont(PdfFontFamily.helvetica, 16),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(150, 10, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        _jugador.posicion, PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(150, 30, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        "${_jugador.paisNacimiento.toUpperCase()} (${_jugador.nacionalidad.toUpperCase()})", PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(150, 50, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Pie: ${_jugador.lateral.toUpperCase()}", PdfStandardFont(PdfFontFamily.helvetica, 8),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(150, 65, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        _jugador.equipo, PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 60, 150, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle, alignment: PdfTextAlignment.center));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0,pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    page.graphics.drawString(
        _jugador.veredicto==""?"Sin veredicto":_jugador.veredicto.toUpperCase(), PdfStandardFont(PdfFontFamily.helvetica, 15),
        brush: PdfBrushes.red,
        bounds: Rect.fromLTWH(pageSize.width/2-100, pageSize.height-50, 200, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle, alignment: PdfTextAlignment.center));

    //EMPRESA
    page.graphics.drawString('', PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Nombre: ${_jugador.jugador.replaceAll("č","c").replaceAll("Š","S").replaceAll("Ž","Z").replaceAll("ž","Z").replaceAll("ć","c").replaceAll("š", "s").replaceAll("ã", "a")}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(100, 80, 300, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Equipo: ${_jugador.equipo}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(100, 95, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Categoria: ${_jugador.categoria}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(100, 110, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Fecha: ${_jugador.fechaNacimiento}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(100, 125, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Posición alternativa: ${_jugador.posicionalternativa}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(100, 140, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Edad: ${Config.edadSub(_jugador.fechaNacimiento)}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: Config.edadSub(_jugador.fechaNacimiento)=="SUB-23"?PdfBrushes.green:PdfBrushes.red,
        bounds: Rect.fromLTWH(395, 80, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString('Ciclo 1: ${_jugador.nivel==null?"Sin nivel":_jugador.nivel}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.darkSlateBlue,
        bounds: Rect.fromLTWH(400, 100, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Ciclo 2: ${_jugador.nivel2==null?"Sin nivel":_jugador.nivel2}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.darkSlateBlue,
        bounds: Rect.fromLTWH(400, 115, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Ciclo 3: ${_jugador.nivel3==null?"Sin nivel":_jugador.nivel3}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.darkSlateBlue,
        bounds: Rect.fromLTWH(400, 130, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Ciclo 4: ${_jugador.nivel4==null?"Sin nivel":_jugador.nivel4}',  PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.darkSlateBlue,
        bounds: Rect.fromLTWH(400, 145, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('${Jugador.tipoJugador(_jugador.posicion,_jugador.tipo)}',  PdfStandardFont(PdfFontFamily.helvetica, 9),
        brush: PdfBrushes.green,
        bounds: Rect.fromLTWH(100, 170, 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));


    page.graphics.drawString('Alt/Peso: ${_jugador.altura} / ${_jugador.peso}  ', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(255, 80, 300, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));

    //Create a new PDF true type font.
   // PdfTrueTypeFont font = new PdfTrueTypeFont(new Font("Arial", 12, FontStyle.Regular), true);

    //Draw the Unicode text
   // page.Graphics.DrawString("€ $ ¥", font, PdfBrushes.Black, new PointF(10, 10));
     String valorAux=_jugador.valor.replaceAll("€", "");
    print(valorAux);
    page.graphics.drawString('Valor: ${valorAux}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(255, 95, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Prestamo: ${_jugador.prestamo}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(255, 110, 200, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.bottom));
    page.graphics.drawString('Contrato: ${_jugador.fechaContrato==null?'-':_jugador.fechaContrato}', contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(255, 125, 100, 33),
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
    headerRow1.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow1.style.textBrush = PdfBrushes.white;
    headerRow1.cells[0].value = 'Características ' +aux;
    headerRow1.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow1.cells[0].columnSpan=3;


    for(int i=0;i<caract.length;i++){
        final PdfGridRow row = grid.rows.add();
        row.cells[0].value = caract[i];
        row.cells[1].value="SI";
        row.cells[2].value="NO";
        row.cells[1].style.backgroundBrush=Jugador.dameElValor(caract[i], _jugador)==true?PdfSolidBrush(colorAzul):PdfSolidBrush(colorBlanco);
        row.cells[1].style.textBrush=Jugador.dameElValor(caract[i], _jugador)==true?PdfSolidBrush(colorBlanco):PdfSolidBrush(colorNegro);
        row.cells[2].style.backgroundBrush=Jugador.dameElValor(caract[i], _jugador)==false?PdfSolidBrush(colorAzul):PdfSolidBrush(colorBlanco);
        row.cells[2].style.textBrush=Jugador.dameElValor(caract[i], _jugador)==false?PdfSolidBrush(colorBlanco):PdfSolidBrush(colorNegro);


    }
    grid.columns[0].width = 150;
    grid.columns[1].width = 40;
    grid.columns[2].width = 40;
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
