import 'package:gsheets/gsheets.dart';
import 'package:iafootfeel/model/jugador.dart';
import 'package:iafootfeel/model/jugadorJornada.dart';
import 'package:iafootfeel/model/jugadorJornadaColumna.dart';
import 'package:iafootfeel/service/BBDDService.dart';


// your google auth credentials
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-298013",
  "private_key_id": "b92ed1bffea10669fff3073aeebcf8d3f3ee2694",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCaqapEqXa19bbx\nnS9RtdAvk/pPhbS6wbxxNkHaIijNEa+xcz5+ZtUfz/bMspsgP7A+rIhNHk+thD/F\nM8e/ydWXIODDVZ0Iltk2DlN0DsBhdN7KZpEtC+vDLDlAibbar7GAw+APgMo/BXfP\n6RJdiEi/9wX/rvx+JrMCXSt702J5RDB0Q5rdHrxgs0yl1yner/XtO0AnE503zXNZ\ntF/N/qlo9lYWSt+q6Va3AJFSWQYZok12lIFqDOZ8wEBpDhpfi80jJ9StBEOaE2iA\n8BadlhHZG/egkLuIkaiMPX5AeoDc0LAnfDeNjxiLnAOjACZR1IZ/+BtiVWpoyPT5\nDXIikgbvAgMBAAECggEADL0ozxr+MiKY/PGrchl9mk2f8mja5/8JHHIRnnvtzGZG\niGErppGlwEcK1vVnHZLhW2gumduDSJF6By4qp7tiIl6M5Mnqc0ipf3BSo16LrftI\nVnd4QbOXqa280XoGW6DZB/gaPmynO+WhZriV0KpnA5i/H740AdgCKpGuATb6B27b\nm3/pNLyISk4x+T6ZmxFZaujR8l6c8a+7i3DGwkbgwMOcG9YNs3W1vmXoXO4Ugx57\nAGervKP4a9np0OzFZb/nkAIms7NxuLt2vOhc+MGy/y5/gL9YWJEOVXs2VUv59jId\npkC90xwi8VLyulUSyBMcBKc8afQsOXD4LcyE6wG1EQKBgQDNJ9o+tgfyA4pcH6le\nak9zkwmbWLCISdBKsm0FgxIF96yowvlpWXwfsuvU7GROoXgcygmqWef3z9JWX+DW\naoYep7eIkaAMQkezzVMNxJE0F+zycI3Tgf/Ee1lsXnqKfHuOYxshkIUbPp+9471d\nYhOlSKRiUHNfWOwZ15F43yOu/QKBgQDA/kcuNvD90+OXTAI34kNFux6Jz/kScwgC\nFrZRU6r0FPtKI4GSs4eGr006+7P16yuztvGmlHlMZU1BEX7qfSo7Pl5ui2b+hPuh\nVajlgqx6T2NAB8E35LygIMCa0m4GBLQty6oFliDwzl2uTk3UW+M2BfISXLEXmbfJ\npFgWHsoPWwKBgCN6AcaYadVTAWke3IYEMksVITMo6hYXVZqlMi8i1EoN42CnnsO2\nAr3kjd2bJ1llmMS5t2Qq+e8jlAb1u4a4kwrYC+fk7t1P1OBl4DfgRw/QF1xxVEVA\nFL+gaP1RdTVfg2pC/x0Vxb7JXIxUxplQbX9GiY6qxNi3ItTxLynMxHntAoGBAL29\nQN3+xg/HMgqdf9DRcrIrtWpoPcgVr9nd2oE6cOhneGb7YXiJaMTRtGw46kTsYJrf\nUdUkQ90H+1vth4miZNK6Dr0/8JJqy7liLhr2zfux8TISbbQ1/fywNqwAFot0NHCR\nuyai4t/dA91Kvtn5PPjv/35uAu3hAwALw058FsvhAoGAQ/QdmeUjOXT2FSpGIvF+\ndRkQAD72pGsTnmxbOYEEBzHG/blzhBWb/hca5WMQgdoW0x3qrbKLrgCZzW3FT9UB\novJW8661Eh9TxPdWbhnYwh4UY1Jz8BzySyPGKSJAreful7DGBsaoGazT9Z+Se8hp\nWyS8XL8idw34+wwSdi+QF38=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-298013.iam.gserviceaccount.com",
  "client_id": "115059634290429565556",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-298013.iam.gserviceaccount.com"
} 
''';


// your google auth credentials
const _credentials2 = r'''
{
  "type": "service_account",
  "project_id": "iafootfeel",
  "private_key_id": "74ddeb02060a07e66d062f8c2d61915062be9c49",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCrI5p3fayQaiy5\nbvMN5F3IzA3tHI7l5xJyW2YBIRiOeLWCgdpFggP5Gw18OKwRX70Koec9+2VHoIJ4\np/jR/ii77x+yVYtyf9bZkqG+h1/PzCTNU5KnWfWkHmzSs40EnT2L7CWRI6Feer39\nRUFhP9EreNS65G7WULMElbLZ3v29pssku23jZy/u0r1oKJTqWDKOLHyJmOFKsKi4\n4qAXyK4kDvXGuWaCDlEAvgXWk+zpsU9DdFs2/oQcVktxNy5Qi3hcAFQ6X8yMt1eI\n7rSfRatuk+R3/Jfws9kv5Ie1I18dGFZG3MTQq+gE7aAQ/QSS7l0L5us4C1YX+6n7\nqbcV2oqRAgMBAAECggEABvzpLb/f7/Wl5dx16DdO7QgH+YqU+yY4RpscyycCza54\nGuAafYQVjXJhVpUp0XvLSEfcHVfKhuYy7aJOMqTiHOpirPF5RC+cIj4uhI0aiG2Z\ngxjKgDLYKN9lKiVSuMGC5de6oPaHfEgewdy2ErZ8X/4LEaaKMA4TgThrmSHV0oyP\nx8z4L1HiEK6Wh7BN0f+hDbHOPyLsJ9A6zdZlRPE9/i+SkvxMSpsaPb+HlwpiZhYP\npTTZvox+hKQbVI6q+kvVFmywoE74gGKQX42Oaa9EeBpYxXoHEZmT+zqpBqhKQIut\nJtrVuuk9qS4P0PSl20j8JkrAZ8QdhzpMxzw4+kYxkQKBgQDn/4CKKaNSxWAx6AzQ\nOwtizaGVQiIKUdLnSJtxgnikQcBM2tCdySgClEc+tzm2mu9QlqnDQpahKcV+6SR4\nsZMO50eir7J4oW6B3XIB9RsmHA+JtPOo1aw40V2q1p4ApcoFUk4P/pQkyl1nLumm\n3PfGhJ4WObaaQMcF/RkhaUJDuwKBgQC82D5VuxkQk2HIgiIhEYFTpLeuLC73noV+\nRnQJ6UH7ZcrzraS9WOjnaBXWLtpECdW6P6+GaOc14FRXX7PapZbkdO8fRRJF0oA/\nduDEVvfNtJdnaBOYqO9eF3tbyVlGqT/+0uJz++a6Miveq0+OsqFPCkJzjotUlcl+\nurzz89lYIwKBgQDb59NGo0s9xPt2steada1IPVRBb8tmbsL0Gl3FjX+favfFodAH\nEEqNj1Gs/+6DyX64q+dEv5SaNUcQEhxRDzku8klzywjn0VU3YdmUQ2o1iHmt9UjV\nK5ywyrv3mLFyObQxsR9vh8eSzAMXMF+nnGJ82O4kcRZGRsqgQZWVlvmJywKBgQCX\n6xZqfXNyhD4bwaSXGbACi/ZAJcc66MnXhfH/ryinh4I3ei+XK5lh37gBb/ui1I6d\noHIiHO4zx13SVGkpsiCrdO6RJ03F4cvOQmIbUSNU1r0eMPniy7SU6ysP8fDiCXI0\nG46VY8Z/b7EfFo2P7GAcZ9KBh+DKkR1h1/P+BOOKJQKBgEc2EupfWSsfnykwlwus\nj3Vu8MoMfofFVMw6Q8MvPpIqVTdO3iqoTPmbiD31kNZCLxD+MNaYD12M2Qht1FfC\nbuqn8YbiFnqD+9aTZvj1UMmAq4Q4SkNi7BDKwLkhh7F7xNUcvxg4+JdsIBp/6ygX\nzOjrZIknzsNv7jAaSR4xEB8L\n-----END PRIVATE KEY-----\n",
  "client_email": "iafootfeel@appspot.gserviceaccount.com",
  "client_id": "117737569868203427462",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/iafootfeel%40appspot.gserviceaccount.com"
}
''';
//https://docs.google.com/spreadsheets/d/1ZQlRTx_HIy4uuRhtnZEepVVMsVQ2ziFyQnCNcZNIHhE/edit#gid=1883769613
//https://docs.google.com/spreadsheets/d/1daE6rEeAeG4BoUo7oESsZijPJ4j6RBYoLUj9_JjIBGY/edit#gid=0
// your spreadsheet id
const _spreadsheetId = '1ZQlRTx_HIy4uuRhtnZEepVVMsVQ2ziFyQnCNcZNIHhE';
const _spreadsheetIdSCOUT = '1daE6rEeAeG4BoUo7oESsZijPJ4j6RBYoLUj9_JjIBGY';
//const _spreadsheetId = "1UaXisIauveXXL0qgdjG26v6s0pZyz67Vxg4PPpNk3iE";
void main() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  final gsheetsSCOUT = GSheets(_credentials2);
  // fetch spreadsheet by its id
  final ss = await    gsheets.spreadsheet(_spreadsheetId);
  final ssSCOUT = await    gsheets.spreadsheet(_spreadsheetIdSCOUT);
  // get worksheet by its title
  final sheet = await ss.worksheetByTitle('jugadores_IA');

  //ProductManager().insert(new Product(id:1,name: "AAAAA", quantity: 1, price: 1.0));
  /*ProductManager().insert(new Product(id:1,name: "BDDD", quantity: 1, price: 1.0));
  ProductManager().insert(new Product(id:2,name: "AAAA", quantity: 5, price: 2.0));
  ProductManager().insert(new Product(id:3,name: "BCCCDDD", quantity: 3, price: null));*/


}

class Product {
  const Product({
    this.id,
    this.name,
    this.quantity,
    this.price,
  });

  final int id;
  final String name;
  final int quantity;
  final double price;

  @override
  String toString() =>
      'Product{id: $id, _jugador: $name, _equipo: $quantity, price: $price}';

  factory Product.fromGsheets(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id'] ?? ''),
      name: json['_jugador'],
      quantity: json['_equipo'],
      price:json['price'],
    );
  }

  Map<String, dynamic> toGsheets() {
    return {
      'id': id,
      '_jugador': name,
      '_equipo': quantity,
      'price': price,
    };
  }


}
class ProductManager {
  final GSheets _gsheets = GSheets(_credentials);
  Spreadsheet _spreadsheet ;
  Worksheet _productSheet;
  Worksheet _jornadaSheet;
  Worksheet _jornadaPuntuacionesSheet;

  Future<void> init() async {
    _spreadsheet ??= await _gsheets.spreadsheet(_spreadsheetId);
  }

 /* Future<List<Product>> getAll() async {
    await init();
    final products = await _productSheet.values.allRows(fromRow: 2);
    return List.generate(
        products.length,
            (index) =>
            Product(
              id: int.tryParse(products[index][0] ?? ''),
              name: products[index][1],
              quantity: int.tryParse(products[index][2] ?? ''),
              price: double.tryParse(products[index][3] ?? ''),
            ));
  }*/

  Future<List<Product>> getAll() async {
    await init();
    final products = await _productSheet.values.map.allRows();
    return products.map((json) => Product.fromGsheets(json)).toList();
  }
  Future<Product> getById(String id) async {
    await init();
    final map = await _productSheet.values.map.rowByKey(
      id,
      fromColumn: 1,
    );

    return map == null ? null : Product.fromGsheets(map);
  }
  Future<double> priceOf(int id) async {
    await init();
    var price = await _productSheet.values.valueByKeys(
      columnKey: 'price',
      rowKey: id,
    );
    return double.tryParse(price ?? '');
  }

  Future<bool> setPriceFor(int id, double price) async {
    await init();
    return _productSheet.values.insertValueByKeys(
      price,
      columnKey: 'price',
      rowKey: id,
      eager: false,
    );
  }


  Future<bool> insert(Jugador jugador) async {
    await init();
    //print("EXCEL:${jugador.id}");
    return _productSheet.values.map.insertRowByKey(
      jugador.id,
      jugador.toGsheets(),
      appendMissing: true,
    );
  }

  Future<bool> insertJugadorHojaJornadaEquipo(JugadorJornada jugador) async {
    await init();
    //print("EXCEL:${jugador.id}");
    return _jornadaSheet.values.map.insertRowByKey(
      jugador.id,
      jugador.toGsheets(),
      appendMissing: true,
    );
  }

  Future<bool> insertJugadorHojaPuntuacionesJornada(JugadorJornadaColumna jugador, int row) async {
    await init();
    //_jornadaPuntuacionesSheet.values.valueByKeys(rowKey: 'row');

    await _jornadaPuntuacionesSheet.values.map.insertRowByKey(
      jugador.id,
      jugador.toGsheets(jugador.jornada, jugador.puntuaciones,row),
      appendMissing: true,
    );
  }

  Future<int> getRowID(JugadorJornadaColumna jugador) async {
    await init();
    //_jornadaPuntuacionesSheet.values.valueByKeys(rowKey: 'row');
    await _jornadaPuntuacionesSheet.values.map.rowByKey(
      jugador.id
    );

  }




  Future<bool> insertTodos(List<Jugador> listaJugador) async {
    await init();
    for (var i=0;i<listaJugador.length;i++){
      //print("EXCEL:${listaJugador[i].id}");
      _productSheet.values.map.insertRowByKey(
        listaJugador[i].id,
        listaJugador[i].toGsheets(),
        appendMissing: true,
      );
    }

  }

  Future<bool> deleteById(int id) async {
    await init();
    final index = await _productSheet.values.rowIndexOf(id);
    if (index > 0) {
      return _productSheet.deleteRow(index);
    }
    return false;
  }

  Future<int> filaById(String id) async {
    await init();
    final index = await _jornadaPuntuacionesSheet.values.rowIndexOf(id);
    return index;
  }



  Future<bool> delete(Product product) => deleteById(product.id);

}
