import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marwan_be2/Database/pref.dart';
import 'package:marwan_be2/my-cart/Ordes-list.dart';

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
//////////////////////////////////////
 Future<void> confirmOrder(BuildContext context, String userId, bool isDelivery, String address,
      String phoneNumber, String comments, List<Map<String, dynamic>> cartItems) async {
    try {
      // Create a new order document
      DocumentReference orderRef = FirebaseFirestore.instance.collection("orders").doc();

      // Create a list to store order items
      List<Map<String, dynamic>> orderItems = [];

      // Loop through cart items and add them to order items list
      for (Map<String, dynamic> cartItem in cartItems) {
        orderItems.add({
          'name': cartItem['Name'],
          'quantity': cartItem['Quantity'],
          'total': cartItem['total'],
        });
      }

      // Add order details to the order document
      await orderRef.set({
        'userId': userId,
        'delivery': isDelivery,
        'address': address,
        'phoneNumber': phoneNumber,
        'comments': comments,
        'items': orderItems,
        // Add other order details like total, delivery address, etc. if needed
      });

      print("Order confirmed and items added to Orders collection successfully");

      // Clear the cart after order confirmation
      await clearCart(userId);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order confirmed and cart cleared.'),
        ),
      );

      // Navigate back to the home screen
      Navigator.pop(context);
    } catch (e) {
      print("Error confirming order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while confirming the order'),
        ),
      );
    }
  }
  //////////////////////////\\\\\\\\\\\\\\\\\\\

Future<void> addOrderItemToOrder(String userId, Map<String, dynamic> itemData) async {
  try {
    // Convert itemData to OrderItem object
    OrderItem orderItem = OrderItem(
      name: itemData['Name'],
      quantity: itemData['Quantity'],
      total: itemData['total'],
    );

    // Get a reference to the user's Orders collection
    CollectionReference ordersRef =
        FirebaseFirestore.instance.collection("users").doc(userId).collection("Orders");

    // Add the item to the Orders collection
    await ordersRef.add(orderItem.toMap());

    print("Item added to Orders collection successfully");
  } catch (e) {
    print("Error adding item to Orders collection: $e");
    throw e;
  }
}



}
