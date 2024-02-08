import 'package:cyra_ecommerce/models/cart.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _list = [];
  List<CartModel> get cartItems => _list;

  double get totalPrice {
    double total = 0.0;
    for (var item in _list) {
      total = total + item.qty * item.price;
    }
    return total;
  }

  int? get count => _list.length;
  void addItem(
    int id,
    String name,
    double price,
    double qty,
    String image,
  ) {
    final product = CartModel(
      id: id,
      name: name,
      price: price,
      qty: qty,
      image: image,
    );
    _list.add(product);
    notifyListeners();
  }

  void increment(CartModel product) {
    product.increase();
    notifyListeners();
  }

  void reduceByOne(CartModel product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(CartModel product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}
