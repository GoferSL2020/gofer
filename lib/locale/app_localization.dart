import'package:flutter/material.dart';
import'package:intl/intl.dart';
import'../l10n/messages_all.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }


  String get terapia{return Intl.message('terapia');}
  String get terapia_palabra {return Intl.message('terapia_palabra');}
  String get silabas {return Intl.message('silabas');}
  String get ajustes {return Intl.message('ajustes');}
  String get nombre {return Intl.message('nombre');}
  String get anio {return Intl.message('año');}
  String get idioma{return Intl.message('idioma');}
  String get termino {return Intl.message('termino');}
  String get politica {return Intl.message('politica');}
  String get crear_mail {return Intl.message('crear_mail');}
  String get vocales {return Intl.message('vocales');}
  String get directa {return Intl.message('directa');}
  String get indirecta {return Intl.message('indirecta');}
  String get trabadas {return Intl.message('trabadas');}
  String get palabras_frases {return Intl.message('palabras_frases');}
  String get numeros {return Intl.message('numeros');}
  String get lenguajes {return Intl.message('lenguajes');}
  String get sinonimos {return Intl.message('sinonimos');}
  String get antonimos {return Intl.message('antonimos');}
  String get ordenar {return Intl.message('ordenar');}
  String get partes {return Intl.message('partes');}
  String get asi_suenan {return Intl.message('asi_suenan');}
  String get animales {return Intl.message('animales');}
  String get alimentos {return Intl.message('alimentos');}
  String get objectos {return Intl.message('objectos');}
  String get suma {return Intl.message('suma');}
  String get resta {return Intl.message('resta');}
  String get palabras_invnetadas {return Intl.message('palabras_invnetadas');}
  String get palabras_usadas {return Intl.message('palabras_usadas');}
  String get frase_abs {return Intl.message('frase_abs');}
  String get frase {return Intl.message('frase');}
  String get verbos {return Intl.message('verbos');}
  String get adjetivos {return Intl.message('adjetivos');}
  String get adverbios {return Intl.message('adverbios');}
  String get nombre_personas {return Intl.message('nombre_personas');}
  String get profesiones {return Intl.message('profesiones');}
  String get palabras_cuerpo {return Intl.message('palabras_cuerpo');}
  String get paises {return Intl.message('paises');}
  String get filtro {return Intl.message('filtro');}
  String get aceptar {return Intl.message('aceptar');}
  String get palabras_aceptar {return Intl.message('palabras_aceptar');}
  String get palabras {return Intl.message('palabras');}
  String get listas {return Intl.message('listas');}
  String get frases {return Intl.message('frases');}
  String get lista_verbos {return Intl.message('lista_verbos');}
  String get conjugacion {return Intl.message('conjugacion');}
  String get lista_nombres {return Intl.message('lista_nombres');}
  String get ayuda {return Intl.message('ayuda');}
  String get ver {return Intl.message('ver');}
  String get limpiar {return Intl.message('limpiar');}
  String get micrifono {return Intl.message('micrifono');}
  String get nombres {return Intl.message('nombres');}
  String get cifras {return Intl.message('cifras');}
  String get sumandos {return Intl.message('sumandos');}
  String get filtro_numeros {return Intl.message('filtro_numeros');}
  String get numero_alert_mal {return Intl.message('numero_alert_mal');}
  String get numero_alert_ok {return Intl.message('numero_alert_ok');}
  String get palabra_alert_mal {return Intl.message('palabra_alert_mal');}
  String get palabra_alert_ok {return Intl.message('palabra_alert_ok');}
  String get frase_alert_mal {return Intl.message('frase_alert_mal');}
  String get frase_alert_ok {return Intl.message('frase_alert_ok');}
  String get sinonimo_alert_mal {return Intl.message('sinonimo_alert_mal');}
  String get sinonimo_alert_ok {return Intl.message('sinonimo_alert_ok');}
  String get antonimo_alert_mal {return Intl.message('antonimo_alert_mal');}
  String get antonimo_alert_ok {return Intl.message('antonimo_alert_ok');}
  String get lista_animales {return Intl.message('lista_animales');}
  String get lista_alimentos {return Intl.message('lista_alimentos');}
  String get lista_objectos {return Intl.message('lista_objectos');}
  String get otra {return Intl.message('otra');}
  String get siguiente {return Intl.message('siguiente');}
  String get perfil {return Intl.message('perfil');}
  String get lista_de {return Intl.message('lista_de');}
  String get acertar {return Intl.message('acertar');}
  String get poner_filtro {return Intl.message('poner_filtro');}
  String get la_frase_hay {return Intl.message('la_frase_hay');}
  String get poner_frase {return Intl.message('poner_frase');}
  String get el_total_es_el {return Intl.message('el_total_es_el');}
  String get el_sinonimo_es {return Intl.message('el_sinonimo_es');}
  String get verdadero {return Intl.message('verdadero');}
  String get falso {return Intl.message('falso');}
  String get el_antonimo_es {return Intl.message('el_antonimo_es');}
  String get la_palabra_es {return Intl.message('la_palabra_es');}
  String get singemail {return Intl.message('singemail');}
  String get lento {return Intl.message('lento');}
  String get normal {return Intl.message('normal');}
  String get Hay_nueve_ejercicios {return Intl.message('Hay_nueve_ejercicios');}
  String get Hay_tres_ejercicios {return Intl.message('Hay_tres_ejercicios');}
  String get Hay_seis_ejercicios {return Intl.message('Hay_seis_ejercicios');}
  String get Hay_dos_ejercicios {return Intl.message('Hay_dos_ejercicios');}
  String get Hay_ocho_ejercicios {return Intl.message('Hay_ocho_ejercicios');}
  String get Hay_diez_ejercicios {return Intl.message('Hay_diez_ejercicios');}
  String get Hay_cuatro_ejercicios {return Intl.message('Hay_cuatro_ejercicios');}
  String get Hay {return Intl.message('Hay');}
  String get ejercicios {return Intl.message('ejercicios');}

  String get cuatro_letras {return Intl.message('cuatro_letras');}
  String get seis_letras {return Intl.message('seis_letras');}
  String get ocho_letras {return Intl.message('ocho_letras');}
  String get diez_letras {return Intl.message('diez_letras');}
  String get todas_letras {return Intl.message('todas_letras');}
  String get nivel {return Intl.message('nivel');}
  String get nivel_2 {return Intl.message('nivel_2');}
  String get letras {return Intl.message('letras');}
  String get poner_palabra {return Intl.message('poner_palabra');}
  String get imagen {return Intl.message('imagen');}
  String get tus_palabras {return Intl.message('tus_palabras');}
  String get no_hay {return Intl.message('no_hay');}
  String get de_menos {return Intl.message('de_menos');}
  String get acertar_animales {return Intl.message('acertar_animales');}
  String get acertar_objetos {return Intl.message('acertar_objetos');}
  String get acertar_alimentos {return Intl.message('acertar_alimentos');}
  String get acertar_todas {return Intl.message('acertar_todas');}
  String get sin {return Intl.message('sin');}
  String get con {return Intl.message('con');}
  String get deportes {return Intl.message('deportes');}
  String get colores {return Intl.message('colores');}


  String traducir(String a){
    return Intl.message(
      a,
      name: a,
      desc:'',
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en','es'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
