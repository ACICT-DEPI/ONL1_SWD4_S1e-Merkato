import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marwan_be2/Database/pref.dart';
import 'package:marwan_be2/my-cart/database_methods.dart.dart';

class DatabaseMethods {
  // Method to add user details to the database
  Future<void> addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(id).set(userInfoMap);
      print("User details added successfully");
    } catch (e) {
      print("Error adding user details: $e");
      throw e;
    }
  }

  // Method to add a new food item to the database
  Future<void> addFoodItem(Map<String, dynamic> foodItemMap, String name) async {
    try {
      await FirebaseFirestore.instance.collection(name).add(foodItemMap);
      print("Food item added successfully");
    } catch (e) {
      print("Error adding food item: $e");
      throw e;
    }
  }

  // Method to retrieve a stream of food items from the database
  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }

  // Method to add a food item to a user's cart
  Future<void> addFoodToCart(Map<String, dynamic> cartItem, String userId) async {
    try {
      // Get the Firestore reference to the user's cart
      DocumentReference cartRef = FirebaseFirestore.instance.collection("users").doc(userId).collection("Cart").doc();

      // Add the cart item with an auto-generated document ID
      await cartRef.set({
        "Name": cartItem["Name"],
        "Quantity": cartItem["Quantity"],
        "Image": cartItem["Image"],
        "total": cartItem["Total"], // Use "total" instead of "Total"
      });

      print("Food item added to cart successfully");
    } catch (e) {
      print("Error adding food item to cart: $e");
      throw e;
    }
  }

  // Method to retrieve the user's cart items
  Future<Stream<QuerySnapshot>> getFoodCart(String userId) async {
    return FirebaseFirestore.instance.collection("users").doc(userId).collection("Cart").snapshots();
  }

  // Method to update a food item in the user's cart
  Future<void> updateCartItem(String userId, String cartItemId, Map<String, dynamic> updatedFields) async {
    try {
      // Get the reference to the cart item using its ID
      DocumentReference cartItemRef = FirebaseFirestore.instance.collection("users").doc(userId).collection("Cart").doc(cartItemId);

      // Update the fields of the cart item
      await cartItemRef.update(updatedFields);

      print("Cart item updated successfully");
    } catch (e) {
      print("Error updating cart item: $e");
      throw e;
    }
  }

  // Method to remove a food item from the user's cart
  Future<void> removeCartItem(String userId, String cartItemId) async {
    try {
      // Get the reference to the cart item using its ID
      DocumentReference cartItemRef = FirebaseFirestore.instance.collection("users").doc(userId).collection("Cart").doc(cartItemId);

      // Delete the cart item from Firestore
      await cartItemRef.delete();

      print("Cart item removed successfully");
    } catch (e) {
      print("Error removing cart item: $e");
      throw e;
    }
  }
Future<void> clearCart(String userId) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).collection('Cart').get();
    print("Number of documents in Cart collection before deletion: ${querySnapshot.size}");
    for (DocumentSnapshot ds in querySnapshot.docs) {
      await ds.reference.delete();
    }
    querySnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).collection('Cart').get();
    print("Number of documents in Cart collection after deletion: ${querySnapshot.size}");
    print("Cart cleared.");
  } catch (e) {
    print("Error clearing cart: $e");
    throw e;
  }
}


 Future<void> addOrder(OrderModel order) async {
  try {
    await FirebaseFirestore.instance.collection("orders").add(order.toMap());
    print("Order added successfully");
  } catch (e) {
    print("Error adding order: $e");
    throw e;
  }
}

Future<void> confirmOrder(BuildContext context, OrderModel order) async {
  try {
    // Add the order to the database
    await addOrder(order);

    // Clear the cart
    String? userId = await SharedPreferenceHelper().getUserId();
    print("User ID: $userId");
    if (userId != null) {
      await clearCart(userId);
    }

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order placed successfully')),
    );

    // Navigate back to the home screen
    Navigator.pop(context);
  } catch (e) {
    // Show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error placing order')),
    );
  }
}




}
