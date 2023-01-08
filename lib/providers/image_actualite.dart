import 'package:flutter/cupertino.dart';
import 'package:trevashop_v2/services/articleServices.dart';

class ImageActualite extends ChangeNotifier {
  List<dynamic> image = [];
  List<dynamic> promos = [];

  List<dynamic> get getImage => image;
  List<dynamic> get getPromos => promos;

  setImageActualite(String token) {
    getArticleByType("actualite",token).then((value) {
      image = value;
      notifyListeners();
    });
  }

  setImagePromo(String token) {
    getArticleByType("promo",token).then((value) {
      promos = value;
      notifyListeners();
    });
  }
}
