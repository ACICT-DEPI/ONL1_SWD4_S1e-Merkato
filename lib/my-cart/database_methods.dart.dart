import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Function to add an item to the user's cart in Firestore
  Future<void> addToCart(Map<String, dynamic> itemData) async {
    try {
      await FirebaseFirestore.instance.collection("cart").add(itemData);
    } catch (e) {
      throw Exception("Failed to add item to cart: $e");
    }
  }

  // Function to retrieve items from the cart collection in Firestore
  Stream<QuerySnapshot> getFoodCart(String userId) {
    return FirebaseFirestore.instance.collection("cart").snapshots();
  }
}