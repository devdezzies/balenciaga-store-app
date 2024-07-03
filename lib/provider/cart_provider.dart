import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cartStorage = [];

  void addProductToCart(Map<String, dynamic> item) {
    cartStorage.add(item);
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> item) {
    cartStorage.remove(item);
    notifyListeners();
  }
}