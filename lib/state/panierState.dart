import 'package:flutter/material.dart';
import '../Model/CartItemData.dart';
import '../services/localDatabase.dart';
import '../Model/product.dart';

class PanierState extends ChangeNotifier {
  int _checked = 0;
  double _price = 0;
  bool allTake=false;
  int get checked => _checked;
  double get price => _price;
  set checked(int value) {
    _checked = value;
    notifyListeners();
  }

  List<Product> _selected = [];

  List<Product> get selected => _selected;
  set selected(List<Product> value) {
  //  _selected = [];
    _selected = value;
    notifyListeners();
  }


   clearSlelected(){
     allTake=false;
    this._selected=[];
    notifyListeners();
  }

  Future<void> contentPanierAdd(Product product) async {
    await LocalDatabaseManager().insertProduct(product);
    //await getProducts();
  }

  List<Product> _contentPanier = [];
  List<Product> get contentPanier => _contentPanier;
  setcontentPanier(List<Product> value) {
    _contentPanier = value;
    notifyListeners();
  }

  void increaseNumber(Product it) {
    it.quantite = it.quantite + 1;
    notifyListeners();
  }


  void decreaseNumber(Product it) {
    if (it.quantite > 1) {
      it.quantite = it.quantite - 1;
    }
    notifyListeners();
  }




Future<void>selectAll(){
  _selected=[];
  for(int i=0;i<_contentPanier.length;i++){
     _selected.add(contentPanier[i]);
  }
  allTake=true;
   notifyListeners();
}

Future<void>removeAll(){
  _selected=[];
  allTake=false;
   notifyListeners();
}
  Future<void> contentOrRemove(Product product) async {
    if(_selected==null){

 _selected.add(product);
 notifyListeners();
    }
    if (_selected.contains(product)) {
      print("remove");
      _selected.remove(product);
      notifyListeners();
    } else {
      _selected.add(product);

      print("add");
      notifyListeners();
    }
    //await LocalDatabaseManager.insertProduct(product);
    // await getProducts();
  }

  bool productInCard(Product product) {
    if(_selected==null){
      return false;
    }else
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
    @required String image,
  }) async {
    await LocalDatabaseManager.updateProduct(
      Product(
        id: index,
        nom: nom,
        description: description==null? "":description.replaceAll( ' ',  ''),
        quantite: quantite,
        images: image,
      ),
    );

    notifyListeners();
    // await getProducts();
    /* contentPanier[index] = _contentPanier[index].copyWith(
      description: description,
      quantite: quantite,
    );
    notifyListeners(); */
  }

  Future<void> deleteContentPanierElement({
    @required int id,
  }) async {
    await LocalDatabaseManager.deleteProduct(id);
    for (var i = 0; i < contentPanier.length; i++) {
      if (contentPanier[i].id == id) {
        _contentPanier.removeAt(i);
        i = contentPanier.length + 1;
      }
    }
    for (var i = 0; i < selected.length; i++) {
      if (selected[i] == true) {
        selected.removeAt(i);
        i = selected.length + 1;
      }
    }
    notifyListeners();
  }

Future<void> getProducts() async {
   var  contentPanierItems = await LocalDatabaseManager().getPanier();
    setcontentPanier(contentPanierItems);
   // return contentPanier;
  }
}
