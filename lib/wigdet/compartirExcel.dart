import 'dart:io';



import 'package:iafootfeel/dao/CRUDJugador.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class CompartirExcel {


  ponerCabecera(Worksheet sheet) {
    //Adding cell style.

    styleCabecera?.backColor = '#D9E1F2';
    styleCabecera?.hAlign = HAlignType.center;
    styleCabecera?.vAlign = VAlignType.center;
    styleCabecera?.bold = true;
    styleCabecera?.wrapText = true;
    sheet.getRangeByName('A1:GL1').cellStyle = styleCabecera!;

    styleCabecera2?.backColor = '#F78B09';
    styleCabecera2?.hAlign = HAlignType.center;
    styleCabecera2?.vAlign = VAlignType.center;
    styleCabecera2?.bold = true;
    styleCabecera2?.wrapText = true;

    int columna = 1;
    sheet.getRangeByIndex(1, columna).text = "Firmado".toUpperCase();
    columna++; //idjugador,
    sheet.getRangeByIndex(1, columna).text = "Proceso".toUpperCase();
    columna++; //idjugador,
    sheet.getRangeByIndex(1, columna).text = "Agente FootFeel".toUpperCase();
    columna++; //idjugador,
    sheet.getRangeByIndex(1, columna).text = "Pais".toUpperCase();
    columna++; //_pais,
    sheet.getRangeByIndex(1, columna).text = "Jugador".toUpperCase();
    columna++; //_jugador,
    sheet.getRangeByIndex(1, columna).text = "Equipo".toUpperCase();
    columna++; //_equipo,
    sheet.getRangeByIndex(1, columna).text = "Competeción".toUpperCase();
    columna++; //_categoria,
    sheet.getRangeByIndex(1, columna).text = "Categoria".toUpperCase();
    columna++; //_categoria,
    sheet.getRangeByIndex(1, columna).text = "Selección".toUpperCase();
    columna++; //_categoria,
    sheet.getRangeByIndex(1, columna).text = "Fecha Nacimiento".toUpperCase();
    columna++; //_fechaNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Edad Categoria".toUpperCase();
    columna++; //_fechaNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Posicion".toUpperCase();
    columna++; //_posicion,
    sheet.getRangeByIndex(1, columna).text =
        "Posicion alternativa".toUpperCase();
    columna++; //_posicionalternativa,
    sheet.getRangeByIndex(1, columna).text = "Lateral".toUpperCase();
    columna++; //_lateral,
    sheet.getRangeByIndex(1, columna).text = "Peso".toUpperCase();
    columna++; //_peso,
    sheet.getRangeByIndex(1, columna).text = "Altura".toUpperCase();
    columna++; //_altura,
    sheet.getRangeByIndex(1, columna).text = "Nacionalidad 1".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Nacionalidad 2".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text =
        "Contrato Representacion".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text =
        "Fecha Vencimiento contrato ".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text =
        "Contrato Federación".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text =
        "Contrato Protección Datos".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text =
        "Servicio Comunicación".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Instagram".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Twitter".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Transfermark".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text =
        "Contrato Marca Deportiva".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Marca Deportiva".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Calzado".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text =
        "Fecha Finalización Marca ".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text =
        "Fecha Finalizacion Club ".toUpperCase();
    columna++; //_paisNacimiento,
    sheet.getRangeByIndex(1, columna).text = "Periodo 1".toUpperCase();
    columna++; //_nivel,
    sheet.getRangeByIndex(1, columna).text = "Periodo 2".toUpperCase();
    columna++;
    sheet.getRangeByIndex(1, columna).text = "Rendiminento".toUpperCase();
    columna++; //_nivel2,
    sheet.getRangeByIndex(1, columna).text =
        "Descripción Jugador".toUpperCase();
    columna++; //_altura,
    sheet.getRangeByIndex(1, columna).text =
        "Observaciones Scouter".toUpperCase();
    columna++; //_altura,
    sheet.getRangeByIndex(1, columna).text = "Agente".toUpperCase();
    columna++; //_altura,
    sheet.getRangeByIndex(1, columna).text = "Contacto".toUpperCase();
    columna++;
    sheet.getRangeByIndex(1, columna).text = "Reunión".toUpperCase();
    columna++; //_altura,/_altura,
   //_altura,
    sheet.getRangeByIndex(1, columna).text = "Comentarios Captación".toUpperCase();
    columna++; //_altura,
    sheet.getRangeByIndex(1, columna).text = "nombre";
    columna++; //BBDDService()
    sheet.getRangeByIndex(1, columna).text = "email";
    columna++; //BBDDService()
    sheet.getRangeByIndex(1, columna).text = "id";
    columna++; //BBDDService()


  }

  CellStyle? styleAplazado;
  CellStyle? styleNA;
  CellStyle? styleEX;
  CellStyle? styleSIM;
  CellStyle? styleSV;
  CellStyle? styleTitular;
  CellStyle? styleSuplente;
  CellStyle? styleBlanco;
  CellStyle? styleCabecera;
  CellStyle? styleCabecera2;

  CellStyle? styleSuperlativo;
  CellStyle? styleSuper;
  CellStyle? styleDestacado;
  CellStyle? styleIntermedio;
  CellStyle? styleDudoso;
  CellStyle? styleBajo;
  CellStyle? styleNAD;

  Future<void> generateExcel() async {
    final Workbook workbook = Workbook(0);
    //Adding a Sheet with name to workbook.
    final Worksheet sheet1 = workbook.worksheets.addWithName('FootFeel');
    sheet1.showGridlines = true;
    sheet1.enableSheetCalculations();

    styleAplazado = new CellStyle(workbook);
    styleNA = new CellStyle(workbook);
    styleSIM = new CellStyle(workbook);
    styleSV = new CellStyle(workbook);
    styleTitular = new CellStyle(workbook);
    styleSuplente = new CellStyle(workbook);
    styleBlanco = new CellStyle(workbook);
    styleEX = new CellStyle(workbook);
    styleCabecera = new CellStyle(workbook);
    styleCabecera2= new CellStyle(workbook);

    styleSuperlativo = new CellStyle(workbook);
    styleSuper = new CellStyle(workbook);
    styleDestacado = new CellStyle(workbook);
    styleIntermedio = new CellStyle(workbook);
    styleDudoso = new CellStyle(workbook);
    styleBajo = new CellStyle(workbook);
    styleNAD = new CellStyle(workbook);

    styleBlanco?.backColor = "#FFFFFF";
    styleAplazado?.backColor = "#3383FF";
    styleNA?.backColor = "#FFE333";
    styleSIM?.backColor = "#C1C0BE";
    styleSV?.backColor = "#C38EFC";
    styleTitular?.backColor = "#6ACC70";
    styleSuplente?.backColor = "#FFA94F";
    styleEX?.backColor = "#FF4F4F";

    styleSuperlativo?.backColor = "#057C15";
    styleSuper?.backColor = "#09F729";
    styleDestacado?.backColor = "#F7F309";
    styleIntermedio?.backColor = "#F78B09";
    styleDudoso?.backColor = "#FB36DD";
    styleBajo?.backColor = "#931C01";
    styleNAD?.backColor = "#6BEBFF";

    styleBlanco?.hAlign = HAlignType.center;
    styleAplazado?.hAlign = HAlignType.center;
    styleNA?.hAlign = HAlignType.center;
    styleSIM?.hAlign = HAlignType.center;
    styleSV?.hAlign = HAlignType.center;
    styleTitular?.hAlign = HAlignType.center;
    styleSuplente?.hAlign = HAlignType.center;
    styleSuplente?.hAlign = HAlignType.center;
    styleEX?.hAlign = HAlignType.center;
    sheet1.enableSheetCalculations();
    ponerCabecera(sheet1);
    int fila = 2;

    List<Player> jugadores =await CRUDJugador().fetchJugadores();
    int columna = 1;
    for (var jug in jugadores) {
      columna = 1;
      //sheet1.getRangeByIndex(fila, columna).value=jug.idjugador;columna++;
      ponerCeldaValor(sheet1, fila, columna, jug.firmado);
      columna++; //_jugador,
      ponerCeldaValor(sheet1, fila, columna, jug.proceso);
      columna++; //_jugador,
      ponerCeldaValor(sheet1, fila, columna, jug.scouter);
      columna++; //_jugador,
      ponerCeldaValor(sheet1, fila, columna, jug.pais);
      columna++; //_equipo,
      ponerCeldaValor(sheet1, fila, columna, jug.jugador);
      columna++; //_categoria,
      ponerCeldaValor(sheet1, fila, columna, jug.equipo);
      columna++; //_dorsal,
      ponerCeldaValor(sheet1, fila, columna, jug.competecion);
      columna++;
      ponerCeldaValor(sheet1, fila, columna, jug.categoria + " "+ jug.catCantera);
      columna++; //_lateral,
      ponerCeldaValor(sheet1, fila, columna, jug.seleccion);
      columna++; //_lateral,
      ponerCeldaValor(sheet1, fila, columna, jug.fechaNacimiento);
      columna++; //_posicion,
      ponerCeldaValor(sheet1, fila, columna, jug.edadCategoria());
      columna++; //_posicionalternativa,
      ponerCeldaValor(sheet1, fila, columna, jug.posicion);
      columna++; //_pais,
      ponerCeldaValor(sheet1, fila, columna, jug.posicionalternativa);
      columna++; //_fechaNacimiento,
      ponerCeldaValor(sheet1, fila, columna, jug.lateral);
      columna++; //_
      ponerCeldaValor(sheet1, fila, columna, jug.peso);
      columna++; //_peso,
      ponerCeldaValor(sheet1, fila, columna, jug.altura);
      columna++; //_altura,
       ponerCeldaValor(sheet1, fila, columna, jug.nacionalidad);
      columna++; //_ccaa,
      ponerCeldaValor(sheet1, fila, columna, jug.nacionalidad2);
      columna++; //_nacionalidad,
      ponerCeldaValor(sheet1, fila, columna, jug.contratoRepresentacion);
      columna++; //_contrato,
      ponerCeldaValor(sheet1, fila, columna, jug.fechaVencimientoContrato);
      columna++; //_fechaContrato,
      ponerCeldaValor(sheet1, fila, columna, jug.contratoFederacion);
      columna++; //_veredicto,
      ponerCeldaValor(sheet1, fila, columna, jug.contratoProteccionDatos);
      columna++; //_prestamo,
      ponerCeldaValor(sheet1, fila, columna, jug.servicioComunicacion);
      columna++; //_nivel,
      ponerCeldaValor(sheet1, fila, columna, jug.instagram);
      columna++; //_nivel2,
      ponerCeldaValor(sheet1, fila, columna, jug.twitter);
      columna++; //_nivel3,
      ponerCeldaValor(sheet1, fila, columna, jug.transfermark);
      columna++; //_nivel3,
      ponerCeldaValor(sheet1, fila, columna, jug.contratoMarcaDeportiva);
      columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.marcaDeportiva);
      columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.calzado.toString());
      columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.fechaFinalizacionMarca);
      columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.fechaContrato);
      columna++; //_nivel4,
      ponerCeldaValorNivel(sheet1, fila, columna, jug.nivel);
      columna++; //_nivel4,
      ponerCeldaValorNivel(sheet1, fila, columna, jug.nivel2);columna++; //_nivel4,
      ponerCeldaValorNivel(sheet1, fila, columna, jug.rendimiento);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.descripcion);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.observaciones);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.agente);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.contacto);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.reunion);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.comentarios);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.nombre);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.email);columna++; //_nivel4,
      ponerCeldaValor(sheet1, fila, columna, jug.key);columna++; //_nivel4,
      fila++;
    }

    print("ABRRRRRRRRRRRRRRREEEE");
    final List<int> bytes = workbook.saveAsStream();
    print("ABRRRRRRRRRRRRRRREEEE");
    workbook.dispose();

    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/Jugadores.xlsx');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    print("ABRRRRRRRRRRRRRRREEEE");
    await open_file.OpenFile.open('$path/Jugadores.xlsx');
    //Launch file.
    //await FileSaveHelper.saveAndLaunchFile(bytes, 'ExpensesReport.xlsx');
  }

  ponerCeldaValor(Worksheet sheet1, int fila, int columna, var jug) {
    sheet1.getRangeByIndex(fila, columna).value = jug;
  }

  ponerCeldaValorNivel(Worksheet sheet1, int fila, int columna, String jug) {
    print(jug);
    if (jug == null) jug = "";
    sheet1.getRangeByIndex(fila, columna).value = jug.toUpperCase();
    if (jug.toUpperCase() == "TOP") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleSuperlativo!;
    }
    if (jug.toUpperCase() == "DESTACADO")
    {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleSuper!;
    }
    if (jug.toUpperCase() == "ACORDE A LA CATEGORÍA") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleIntermedio!;
    }
    if (jug.toUpperCase() == "DISCRETO") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleDudoso!;
    }
    if (jug.toUpperCase() == "NO HA JUGADO") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleDestacado!;
    }
  }

  ponerCeldaValorCaracter(Worksheet sheet1, int fila, int columna, bool jug) {
    if (jug == true) {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleAplazado!;
      sheet1.getRangeByIndex(fila, columna).value = jug;
    } else {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleBlanco!;
      sheet1.getRangeByIndex(fila, columna).value = jug;
    }
  }

  ponerCeldaValorPuntuacion(
      Worksheet sheet1, int fila, int columna, String jug, String estado) {
    double punt = 0.0;
    print(jug);
    try {
      punt = double.parse(jug.replaceAll(",", "."));
      print(punt);
      sheet1.getRangeByIndex(fila, columna).value = punt;
      sheet1.getRangeByIndex(fila, columna).numberFormat = '#,##0.00';

      //jug=punt.toString();
    } catch (e) {
      sheet1.getRangeByIndex(fila, columna).value = estado;
    }
    if (jug == null) {
      jug = "";
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleBlanco!;
      sheet1.getRangeByIndex(fila, columna).value = "";
    } //jug=jug.replaceAll(",", ".");
    if (estado == "SV") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleSV!;
      sheet1.getRangeByIndex(fila, columna).value = "SV";
    }
    if (estado == "EX") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleEX!;
      if ((jug == null) || (jug == ""))
        sheet1.getRangeByIndex(fila, columna).value = "EX";
    }
    if (estado == "SIM") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleSIM!;
      sheet1.getRangeByIndex(fila, columna).value = "SIM";
    }
    if (estado == "A") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleAplazado!;
      sheet1.getRangeByIndex(fila, columna).value = "A";
    }
    if (estado == "NA") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleNA!;
      sheet1.getRangeByIndex(fila, columna).value = "NA";
    }
    if (estado == "T") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleTitular!;
      if ((jug == null) || (jug == ""))
        sheet1.getRangeByIndex(fila, columna).value = "T";
    }
    if (estado == "S") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleSuplente!;
      if ((jug == null) || (jug == ""))
        sheet1.getRangeByIndex(fila, columna).value = "S";
    }
    //sheet1.getRangeByIndex(fila, columna).numberFormat='#,##0.000';
  }

  ponerCeldaValorInt(Worksheet sheet1, int fila, int columna, int jug) {
    sheet1.getRangeByIndex(fila, columna).value = jug;
    if (sheet1.getRangeByIndex(fila, columna).value == "SV") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleSV!;
    }
    if (sheet1.getRangeByIndex(fila, columna).value == "SIM") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleSIM!;
    }
    if (sheet1.getRangeByIndex(fila, columna).value == "A") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleAplazado!;
    }
    if (sheet1.getRangeByIndex(fila, columna).value == "NA") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleNA!;
    }
    if (sheet1.getRangeByIndex(fila, columna).value == "T") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleTitular!;
    }
    if (sheet1.getRangeByIndex(fila, columna).value == "S") {
      sheet1.getRangeByIndex(fila, columna).cellStyle = styleSuplente!;
    }
    if (sheet1.getRangeByIndex(fila, columna).value == null) {
      sheet1.getRangeByIndex(fila, columna).value = "";
    }
  }
}
