import 'package:flutter/foundation.dart';
import 'package:trevashop_v2/services/paySelection_services.dart';

import '../Model/product.dart';
import '../constants/Api.dart';
import '../services/localDatabase.dart';

class CommandeProvider with ChangeNotifier {
  int _checked = 0;
  double _price = 0;

  //Si Moyen_Transport = 0 alors le transport est avion si 1 le transport est bateau
  int Moyen_Transport = 2; //je l'initialise a 2

  String pays_nom;

  //type de livraison Agence => 0 , domicile -> 1
  int Type_Livraison = 2;
  int badge = 0;
  int get checked => _checked;
  double get price => _price;
  int get getBadge => badge;
  set checked(int value) {
    _checked = value;
    notifyListeners();
  }

  int get MoyenTransport => Moyen_Transport;
  int get TypeLivraison => Type_Livraison;

  void setMoyenTransport(int value) {
    Moyen_Transport = value;
    notifyListeners();
  }

  void setTypeLivraison(int value) {
    Type_Livraison = value;
    notifyListeners();
  }

  List<Product> _selected = [];

  List<Product> get selected => _selected;
  set selected(List<Product> value) {
    _selected = [];
    _selected = value;
    notifyListeners();
  }

  Future<void> contentPanierAdd(Product product) async {
    await LocalDatabaseManager().insertProduct(product);
    notifyListeners();
  }

  List<Product> _contentPanier = [];
  List<Product> get contentPanier => _contentPanier;
  set contentPanier(List<Product> value) {
    _contentPanier = value;
    notifyListeners();
  }

  void increaseNumber(Product it) {
    it.quantite = it.quantite + 1;
    notifyListeners();
  }

  double totalPrice() {
    _price = 0;

    for (var item in _selected) {
      _price = _price + (item.quantite * item.prix);
    }
    return _price;
  }

  void decreaseNumber(Product it) {
    if (it.quantite > 1) {
      it.quantite = it.quantite - 1;
    }
    notifyListeners();
  }

  clear() {
    selected = [];

    notifyListeners();
  }

  Future<void> contentOrRemove(Product product) async {
    print("produit" + product.toString());
    if (_selected.contains(product)) {
      print("remove");
      _selected.remove(product);
      notifyListeners();
    } else {
      _selected.add(product);

      print("add");
      notifyListeners();
    }
  }

  bool productInCard(Product product) {
    if (_selected.contains(product)) {
      return true;
    }
    return false;
  }

  Future<void> modifyContentPanierElement({
    @required int index,
    @required String nom,
    @required String description,
    @required int quantite,
    @required image,
  }) async {
    await LocalDatabaseManager.updateProduct(
      Product(
        id: contentPanier[index].id,
        nom: nom,
        description: description,
        quantite: quantite,
        images: image,
      ),
    );
  }

  Future<void> deleteContentPanierElement({
    @required int id,
  }) async {
    await LocalDatabaseManager.deleteProduct(id);
    for (var i = 0; i < contentPanier.length; i++) {
      if (contentPanier[i].id == id) {
        _contentPanier.removeAt(i);
      }
    }
    for (var i = 0; i < selected.length; i++) {
      if (selected[i] == true) {
        selected.removeAt(i);
      }
    }
    notifyListeners();
  }

  Future<List> getProducts() async {
    contentPanier = await LocalDatabaseManager().getPanier();
    badge = contentPanier.length;
    notifyListeners();
    return contentPanier;
  }

  // ignore: missing_return
  Future<List<dynamic>> getCommands(
    String token,
  ) async {
    try {
      final response = await Api.getCommands(token);

      int validate = response.status;
      print(validate);
      if (response.data.length != 0) {
        final data = response.data;
        notifyListeners();
        return data;
      } else {
        notifyListeners();
        //return {};
      }
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> getCommandsDetails(String token, int id) async {
    try {
      final response = await Api.getCommandsDetail(token, id);
      // print("response" + response.toString());
      int validate = response["status"];
      if (response["data"].length != null) {
        final data = response["data"];
        notifyListeners();
        return data;
      } else {
        notifyListeners();
        //return {};
      }
    } catch (err) {
      throw err;
    }
  }
}
