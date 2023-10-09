import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gls/dao/CRUDMercancia.dart';

import '../modelo/categoria.dart';
import '../modelo/mercancia.dart';

class MercanciaService {
  static final CRUDMercancia _instanceCRUDProducto =
      new CRUDMercancia.internal();

  static final MercanciaService _instance = new MercanciaService.internal();

  MercanciaService.internal();

  factory MercanciaService() {
    return _instance;
  }

  void initState() {}

  Future<List<Mercancia>> fetchProductos(Categoria categoria) async {
    return _instanceCRUDProducto.fetchMercancia(categoria);
  }

  Future<List<Mercancia>> fetchProductosRecogidoOficina(int codigo) async {
    return _instanceCRUDProducto.fetchMercanciasRecogidoOficina(codigo);
  }

  Future<List<Mercancia>> fetchProductosRecogidoPlataforma() async {
    return _instanceCRUDProducto.fetchProductosRecogidoPlataforma();
  }

  Future<List<Mercancia>> fetchProductosRecogido() async {
    return _instanceCRUDProducto.fetchMercanciasRecogido();
  }

  Future<bool> estaElProducto(String id) async {
    return _instanceCRUDProducto.estaElProducto(id);
  }

  Stream<QuerySnapshot>? getDataCollectionProductos(Categoria categoria) {
    return _instanceCRUDProducto.getDataCollectionMercancias(categoria);
  }

  Future removeProducto(Mercancia mercancia) async {
    _instanceCRUDProducto.removeMercancia(mercancia);
  }

  Future updateProducto(Mercancia mercancia) async {
    return _instanceCRUDProducto.updateMercancia(mercancia);
  }

  Future addProducto(Mercancia mercancia) async {
    return _instanceCRUDProducto.addMercancia(mercancia);
  }
}
