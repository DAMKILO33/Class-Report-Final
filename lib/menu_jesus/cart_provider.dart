import 'package:flutter/material.dart';
import '../model_diego/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<ProductModel> _items = [];

  List<ProductModel> get items => _items;

  void addProduct(ProductModel product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    _items.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.price);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
