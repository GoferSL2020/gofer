
/*
/// Represents the PDF widget class.
class PivoteCreatePdf {
  PdfColor colorAzul = PdfColor(10, 51, 110);
  PdfColor colorBlanco = PdfColor(255, 255, 255);
  PdfColor colorAzulClaro = PdfColor(223, 247, 248);
  PdfColor colorNegro = PdfColor(0, 0, 0);

  final Jugador _jugador;

  PivoteCreatePdf(this._jugador);

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
        pen: PdfPen(colorAzul));
    page2.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(colorAzul));

    page.graphics.drawImage(
        PdfBitmap(await getImageFileFromAssets(
            "assets/img/${_jugador.posicion.toLowerCase().replaceAll(" ", "")}.png")),
        Rect.fromLTWH(420, 120, 80, 110));


    //Draw grid
    //drawGrid1(page, gridCapacidadesFisico1, result);
    //drawGrid2(page, gridCapacidadesFisico2, result2);
    capacidadesFisico(page);
    capacidadesTecnica(page);
    capacidadesTactica(page);
    capacidadesPsicologia(page2);
    capacidadesObservaciones(page2);
    //drawGrid(page, gridCapacidadesFisico3 , result);
    //Add invoice footer
    //drawFooter(page, pageSize);
    //drawFooter(page2, pageSize);
    await drawHeader(page, pageSize);
    await drawHeader(page2, pageSize);
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

  //Draws the invoice header
  Future<PdfLayoutResult> drawHeader(
      PdfPage page, Size pageSize) async {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(colorAzul),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //JUGADOR
    page.graphics.drawString(_jugador.jugador.toUpperCase(),
        PdfStandardFont(PdfFontFamily.helvetica, 16),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(130, 10, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        _jugador.posicion, PdfStandardFont(PdfFontFamily.helvetica, 14),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(130, 40, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        _jugador.equipo, PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(10, 60, pageSize.width - 115, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    //EMPRESA
    page.graphics.drawString('', PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('IAdvanced', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 20, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    /*  PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));*/

    //Save the current graphics state
    PdfGraphicsState state = page.graphics.save();

//Translate the coordinate system to the  required position
    //   page.graphics.translateTransform(20, 100);

//Apply transparency
    //   page.graphics.setTransparency(0.5);

//Rotate the coordinate system
    //   page.graphics.rotateTransform(-45);

//Draw image

    page.graphics.drawImage(
        PdfBitmap(await getImageFileFromAssets("assets/img/icono.png")),
        Rect.fromLTWH(420, 0, 70, 70));
    page.graphics.drawImage(
        PdfBitmap(await getImageFileFromAssets(
            "assets/clubes/${_jugador.equipo}.png")),
        Rect.fromLTWH(10, 10, 50, 50));

    //Added 30 as a margin for the layout

//Restore the graphics state
    page.graphics.restore(state);

    return PdfTextElement(text: "", font: contentFont)
        .draw(page: page, bounds: Rect.fromLTWH(30, 120, 0, 0));
  }

  void capacidadesFisico(PdfPage page) async {
    //Added 30 as a margin for the layout
    final Size pageSize = page.getClientSize();

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 90, pageSize.width, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    page.graphics.drawString(
        'Capacidad Física', PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 95, 100, 20),
        brush: PdfSolidBrush(colorBlanco) );
    page.graphics.drawString(
        'Envergadura', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 145, 200, 20));
    elementoFisico(page, 125, 5, 'Alta', _jugador.fis_envergadura);
    elementoFisico(page, 125, 125, 'Media', _jugador.fis_envergadura);
    elementoFisico(page, 125, 240, 'Baja', _jugador.fis_envergadura);
    elementoBoolean(
        page, 160, 5, 'Agilidad', _jugador.fis_agilidad);
    elementoBoolean(
        page, 160, 125, 'Cambio de ritmos', _jugador.fis_cambioderitmos);
    elementoBoolean(page, 195, 5, 'Velocidad de reacción',
        _jugador.fis_velocidaddereaccion);
    elementoBoolean(page, 195, 125, 'Capacidad de salto', _jugador.fis_capacidaddesalto);
    elementoBoolean(
        page, 195, 240, 'Cuerpo a cuerpo', _jugador.fis_cuerpoacuerpo);

    elementoBoolean(page, 230, 5, 'Explosividad',
        _jugador.fis_explosividad);
    elementoBoolean(page, 230, 180, 'Fuerza potencia',
        _jugador.fis_fuerza_potencia);
    elementoBoolean(page, 230, 355, 'Velocidad de reacción', _jugador.fis_velocidaddereaccion);
    elementoBoolean(
        page, 275, 5, 'Potente en carrera', _jugador.fis_velocidaddedesplazamiento);

  }
  void capacidadesPsicologia(PdfPage page) async {
    //Added 30 as a margin for the layout
    final Size pageSize = page.getClientSize();

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 90, pageSize.width, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    page.graphics.drawString(
        'Cualidades Psiccológicas', PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 95, 300, 20),
        brush: PdfSolidBrush(colorBlanco) );
        page.graphics.drawString(
            'Concentración', PdfStandardFont(PdfFontFamily.helvetica, 9),
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            bounds: Rect.fromLTWH(5, 115, 200, 20));
        elementoFisico(
            page, 130, 5, 'Bajo', psicologia(_jugador.psic_concentracion));
        elementoFisico(
            page, 130, 125, 'Medio', psicologia(_jugador.psic_concentracion));
        elementoFisico(
            page, 130, 245, 'Correcto', psicologia(_jugador.psic_concentracion));
        elementoFisico(
          page, 130, 365, 'Alto', psicologia(_jugador.psic_concentracion));

    page.graphics.drawString(
        'Competitivo', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 155, 200, 20));
    elementoFisico(
        page, 170, 5, 'Bajo', psicologia(_jugador.psic_competitivo));
    elementoFisico(
        page, 170, 125, 'Medio', psicologia(_jugador.psic_competitivo));
    elementoFisico(
        page, 170, 245, 'Correcto', psicologia(_jugador.psic_competitivo));
    elementoFisico(
        page, 170, 365, 'Alto', psicologia(_jugador.psic_competitivo));

    page.graphics.drawString(
        'Disciplinado', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 195, 205, 20));
    elementoFisico(
        page, 210, 5, 'Bajo', psicologia(_jugador.psic_disciplinado));
    elementoFisico(
        page, 210, 125, 'Medio', psicologia(_jugador.psic_disciplinado));
    elementoFisico(
        page, 210, 245, 'Correcto', psicologia(_jugador.psic_disciplinado));
    elementoFisico(
        page, 210, 365, 'Alto', psicologia(_jugador.psic_disciplinado));



    page.graphics.drawString(
        'Esfuerzo', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 235, 200, 20));
    elementoFisico(
        page, 250, 5, 'Bajo', psicologia(_jugador.psic_esfurezo));
    elementoFisico(
        page, 250, 125, 'Medio', psicologia(_jugador.psic_esfurezo));
    elementoFisico(
        page, 250, 245, 'Correcto', psicologia(_jugador.psic_esfurezo));
    elementoFisico(
        page, 250, 365, 'Alto', psicologia(_jugador.psic_esfurezo));



    page.graphics.drawString(
        'Liderazgo', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 275, 200, 20));
    elementoFisico(
        page, 290, 5, 'Bajo', psicologia(_jugador.psic_liderazgo));
    elementoFisico(
        page, 290, 125, 'Medio', psicologia(_jugador.psic_liderazgo));
    elementoFisico(
        page, 290, 245, 'Correcto', psicologia(_jugador.psic_liderazgo));
    elementoFisico(
        page, 290, 365, 'Alto', psicologia(_jugador.psic_liderazgo));

  }

  String psicologia(int a){
    if (a==0) return "Discreto";
    if (a==1) return "Medio";
    if (a==2) return "Correcto";
    if (a==3) return "Alto";
    
  }

  void capacidadesTecnica(PdfPage page) async {
    final Size pageSize = page.getClientSize();

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 365, pageSize.width, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    //Added 30 as a margin for the layout
    page.graphics.drawString('Destreza específica (técnica)',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 370, 200, 20),
        brush: PdfSolidBrush(colorBlanco) );
    page.graphics.drawString(
        'Perfil', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 390, 200, 20));
    elementoFisico(page, 405, 5, 'Diestro', _jugador.tec_perfil);
    elementoFisico(page, 405, 125, 'Zurdo', _jugador.tec_perfil);
    elementoFisico(page, 405, 240, 'Ambidiestro', _jugador.tec_perfil);
    page.graphics.drawString(
        'Gestos técnicos', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 425, 200, 20));
    elementoFisico(page, 440, 5, 'Muy buenos', _jugador.tec_gestostecnicos);
    elementoFisico(page, 440, 125, 'Normal', _jugador.tec_gestostecnicos);
    elementoFisico(
        page, 440, 240, 'Malo Tecnicamente', _jugador.tec_gestostecnicos);

    page.graphics.drawString(
        'Juego aéreo disputas', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 465, 200, 20));
    elementoNotas(page,480, 5,'Juego áereo',_jugador.tec_disputas);
    page.graphics.drawString(
        'Uso de balón', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 495, 200, 20));
    elementoNotas(page,510, 5,'Pases cortos',_jugador.tec_pasesfiltrados);
    elementoNotas2(page,510, 250,'Juego a 1-2 toques',_jugador.tec_juegoa12toques);
    elementoNotas(page,525, 5,'Pases filtrados',_jugador.tec_pasesfiltrados);
    elementoNotas2(page,525, 250,'Cap juego combinado',_jugador.tec_capacidadjuegocombinado);
    elementoNotas(page,540, 5,'Desplaz. medios',_jugador.tec_desplazamientosmedios);
    elementoNotas2(page,540, 250,'Pases largos',_jugador.tec_paseslargos);
    elementoNotas(page,555, 5,'Conducciones',_jugador.tec_salidaconducciones);
    page.graphics.drawString(
        'Controles', PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 575, 200, 20));

    elementoNotas(page,590, 5,'Generales',_jugador.tec_generales);
    elementoNotas(page,590, 250,'Orientados',_jugador.tec_orientados);
    elementoNotas2(page,605, 5,'Golpeos a puerta',_jugador.tec_golpeosapuerta);
    elementoNotas2(page,605, 250,'Duelos 1vs1',_jugador.tec_duelos1vs1);
    elementoNotas2(page,620, 5,'Provoca situaciones de 1vs1',_jugador.tec_provocasituacionesde1vs1);
    elementoNotas2(page,620, 250,'Jugar a pierna cambiada',_jugador.tec_jugarapiernacambiada);

  }
  void capacidadesTactica(PdfPage page) async {
    final Size pageSize = page.getClientSize();
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 640, pageSize.width, 18),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    //Added 30 as a margin for the layout
    page.graphics.drawString('Destreza específica (táctica)',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 645, 200, 20),
        brush: PdfSolidBrush(colorBlanco) );
    elementoNotas(page,660, 5,'Acoso/presión sobre oponente',_jugador.tac_acosopresionsobreoponente);//
    elementoNotas(page,660, 300,'Vigilancias',_jugador.tac_vigilancias);//
    elementoNotas(page,675, 5,'Resp.llevar juego ofensivo',_jugador.tac_responsabilidadllevarjuegoofensivo);//
    elementoNotas(page,675, 300,'Coberturas',_jugador.tac_coberturas);//
    elementoNotas(page,690, 5,'Basculación y relación intralínea',_jugador.tac_basculacionyrelacionintralinea);
    elementoNotas(page,690, 300,'Repliegues',_jugador.tac_repliegues);//
    elementoNotas(page,705, 5,'Acciones 2das jugadas',_jugador.tac_accionen2dasjugadas);//
    elementoNotas(page,705, 300,'Anticipaciones',_jugador.tac_anticipaciones);//
    elementoNotas(page,720, 5,'Equilibrio At-Def',_jugador.tac_equilibrioatdef);//
    elementoNotas(page,720, 300,'Contundencia',_jugador.tac_contundencia);//
    elementoNotas(page,735, 5,'Interrumpir cortar juego rival',_jugador.tac_interrumpircortarjuegorival);//
    elementoNotas2(page,735, 300,'Cambios de ritmo juego',_jugador.tac_cambiosderitmojuego);//
    elementoNotas(page,750, 5,'Llegada a área rival',_jugador.tac_llegadaaarearival);//

  }


  void capacidadesObservaciones(PdfPage page) async {
    final Size pageSize = page.getClientSize();
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 325, pageSize.width, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    //Added 30 as a margin for the layout
    page.graphics.drawString('Capacidades físico-condicionales',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 330, 300, 20),
        brush: PdfSolidBrush(colorBlanco) );

    page.graphics.drawString(_jugador.observaciones_1,
        PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 345, pageSize.width, 60),
        brush: PdfSolidBrush(colorNegro) );

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 425, pageSize.width, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    page.graphics.drawString('Destreza específica (técnica)',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5,430 , 300, 20),
        brush: PdfSolidBrush(colorBlanco) );

     page.graphics.drawString(_jugador.observaciones_2,
        PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 445, pageSize.width, 80),
        brush: PdfSolidBrush(colorNegro) );

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 530, pageSize.width, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    page.graphics.drawString('Destreza específica (táctica)',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5,535 , 300, 20),
        brush: PdfSolidBrush(colorBlanco) );

    page.graphics.drawString(_jugador.observaciones_3,
        PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 550, pageSize.width, 80),
        brush: PdfSolidBrush(colorNegro) );

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 640, pageSize.width, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    page.graphics.drawString('Cualidades psicológicas',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5,645 , 300, 20),
        brush: PdfSolidBrush(colorBlanco) );

    page.graphics.drawString(_jugador.observaciones_4,
        PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(5, 660, pageSize.width, 80),
        brush: PdfSolidBrush(colorNegro) );

  }


  void elementoNotas(PdfPage page, double row, double col, String texto, int valor) {
     page.graphics.drawString(
        texto, PdfStandardFont(PdfFontFamily.helvetica, 8),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(col, row, 150, 20));
       var aux=10.0;
       var celdas=col+(texto.length>15?150:80);
    for(var i=1;i<=5;i++){
      aux=10.0*i;
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH((celdas)+aux+2, row, 12, 12),
          brush: PdfSolidBrush(valor==i?colorAzul:colorAzulClaro));
      page.graphics.drawString(
          i.toString(), PdfStandardFont(PdfFontFamily.helvetica, 8),
          format: PdfStringFormat(alignment: PdfTextAlignment.left),
          brush: PdfSolidBrush(valor==i?colorBlanco:colorNegro),
          bounds: Rect.fromLTWH((celdas)+aux+5, row+2, 12, 12));
    
    }
  }
  void elementoNotas2(PdfPage page, double row, double col, String texto, int valor) {
    page.graphics.drawString(
        texto, PdfStandardFont(PdfFontFamily.helvetica, 8),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(col, row, 120, 20));
    var aux=10.0;
    var celdas=col+80;
    for(var i=1;i<=5;i++){
      aux=10.0*i;
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH((celdas)+aux+2, row, 12, 12),
          brush: PdfSolidBrush(valor==i?colorAzul:colorAzulClaro));
      page.graphics.drawString(
          i.toString(), PdfStandardFont(PdfFontFamily.helvetica, 8),
          format: PdfStringFormat(alignment: PdfTextAlignment.left),
          brush: PdfSolidBrush(valor==i?colorBlanco:colorNegro),
          bounds: Rect.fromLTWH((celdas)+aux+5, row+2, 12, 12));

    }
  }


  void elementoBoolean(
      PdfPage page, double row, double col, String texto, bool valor) {
    page.graphics.drawString(texto, PdfStandardFont(PdfFontFamily.helvetica, 9),
        brush: valor == true ? PdfBrushes.darkGreen : PdfBrushes.red,
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(col, row, 180, 20));
  }

  void elementoFisico(
      PdfPage page, double row, double col, String texto, String valor) {
    PdfColor color;
    PdfBrushes colorTexto;
    texto == valor ? color = colorAzul : color = colorAzulClaro;
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(color), bounds: Rect.fromLTWH(col, row, 125, 15));
    page.graphics.drawString(texto, PdfStandardFont(PdfFontFamily.helvetica, 7),
        format: PdfStringFormat(
            lineAlignment: PdfVerticalAlignment.middle,
            alignment: PdfTextAlignment.center),
        brush: texto == valor ? PdfBrushes.white : PdfBrushes.black,
        bounds: Rect.fromLTWH(col, row, 125, 15));
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

  //Draws the grid
  void drawGrid1(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
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
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 40, 0, 0));
  }

  void drawGrid2(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
//Draw grand total.
    page.graphics.drawString('VELOCIDAD DE REACCIÓN',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(270, 270, 0, 0));

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
        page: page,
        bounds: Rect.fromLTWH(300, result.bounds.bottom + 40, 0, 0));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 20),
        Offset(pageSize.width, pageSize.height - 20));

    const String footerContent =
        '''InAdvanced by Equalia. Avda. de la Albufera 321, 28031 (Madrid), inAdvanced@inAdvanced.com''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 8),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 20, pageSize.height - 15, 0, 0));
  }

  //Create PDF grid and return

  //Create and row for the grid.
  void addCapacidadesFisico(String capacidad, String datos, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].stringFormat.alignment = PdfTextAlignment.left;

    row.cells[0].value = capacidad;
    if (datos == true)
      row.cells[1].style.backgroundBrush = PdfSolidBrush(PdfColor(10, 127, 0));
    if (datos == false)
      row.cells[1].style.backgroundBrush = PdfSolidBrush(PdfColor(147, 0, 0));
    row.cells[1].value = datos;
  }

  //Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    /*for (int i = 0; i < grid.rows.count; i++) {
      final String value = grid.rows[i].cells[grid.columns.count - 1].value;
      total += double.parse(value);
    }*/
    return total;
  }
}
*/