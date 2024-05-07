import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String name;
  int quantity;
  final int total;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.total,
    required this.image,
  });
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int newQuantity) {
    final cartItem = _cartItems.firstWhere((item) => item.id == itemId);
    cartItem.quantity = newQuantity;
    notifyListeners();
  }
}
