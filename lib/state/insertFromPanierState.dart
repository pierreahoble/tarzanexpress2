import 'package:flutter/material.dart';

class InsertFromPanierState extends ChangeNotifier {
  List<bool> _selected = [];
  List<bool> get selected => _selected;
  set selected(List<bool> value) {
    _selected = value;
    notifyListeners();
  }

  selectedAdd(bool val) {
    _selected.add(false);
    notifyListeners();
  }

  List<int> _inserted = [];
  List<int> get inserted => _inserted;
  set inserted(List<int> value) {
    _inserted = value;
    notifyListeners();
  }

  insertedAdd(int val) {
    _inserted.add(val);
    notifyListeners();
  }

  clear() {
    selected = [];
    inserted = [];
  }

  clearAll() {
    _selected = [];
    _inserted = [];
    notifyListeners();
  }

  modifySelectedElement({
    @required int index,
    @required bool val,
  }) {
    _selected[index] = val;
    notifyListeners();
  }
}
