import 'dart:async';
import 'dart:typed_data';

import 'package:iadvancedscout/dao/paisDao.dart';
import 'package:iadvancedscout/model/pais.dart';

class PaisRequest {
  PaisDao con = new PaisDao();
  Future<int> createPais(Pais pais) {
    var result = con.savePais(pais);
    return result;
  }
  Future<List<Pais>> getPais() {
    var result = con.getAllPais();
    return result;
  }
  Future<int> deletePais(String pais) {
    var result = con.deletePais(pais);
    return result;
  }
}


abstract class CreatePaisCallBack {
  void onCreatePaisSuccess(int pais);
  void onCreatePaisError(String error);
}
abstract class GetPaisCallBack {
  void onGetPaisSuccess(List<Pais> pais);
  void onGetPaisError(String error);
}
abstract class DeletePaisCallBack {
  void onDeletePaisSuccess(int pais);
  void onDeletePaisError(String error);
}
class CreatePaisResponse {
  CreatePaisCallBack _callBackCreate;
  PaisRequest paisRequest = new PaisRequest();
  CreatePaisResponse(this._callBackCreate);
  doCreate(String pais, Uint8List imagen) {
    var fido = Pais( pais, imagen);

    paisRequest
        .createPais(fido)
        .then((pais) => _callBackCreate.onCreatePaisSuccess(pais))
        .catchError((onError) => _callBackCreate.onCreatePaisError(onError.toString()));
  }
}
class GetPaisResponse {
  GetPaisCallBack _callBackGet;
  PaisRequest paisRequest = new PaisRequest();
  GetPaisResponse(this._callBackGet);
  doGet() {
    paisRequest
        .getPais()
        .then((pais) => _callBackGet.onGetPaisSuccess(pais))
        .catchError((onError) => _callBackGet.onGetPaisError(onError.toString()));
  }
}
class DeletePaisResponse {
  DeletePaisCallBack _callBackDelete;
  PaisRequest paisRequest = new PaisRequest();
  DeletePaisResponse(this._callBackDelete);
  doDelete(String  pais) {

    paisRequest
        .deletePais(pais)
        .then((pais) => _callBackDelete.onDeletePaisSuccess(pais))
        .catchError((onError) => _callBackDelete.onDeletePaisError(onError.toString()));
  }
}
