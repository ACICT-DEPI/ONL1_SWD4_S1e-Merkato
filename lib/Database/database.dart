import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Method to add user details to the database
  // Takes a Map of user information and a unique user ID as parameters
  Future<void> addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    // Set the user details in the "users" collection with the provided ID
    try {
      await FirebaseFirestore.instance.collection("users").doc(id).set(userInfoMap);
      print("User details added successfully");
    } catch (e) {
      print("Error adding user details: $e");
      throw e;
    }
  }

  // Method to add a new food item to the database
  // Takes a Map of food item information and the name of the food item as parameters
  Future<void> addFoodItem(Map<String, dynamic> foodItemMap, String name) async {
    // Add the food item to a collection with the same name as the food item
    try {
      await FirebaseFirestore.instance.collection(name).add(foodItemMap);
      print("Food item added successfully");
    } catch (e) {
      print("Error adding food item: $e");
      throw e;
    }
  }

  // Method to retrieve a stream of food items from the database
  // Takes the name of the food item as a parameter
  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }

  // Method to add a food item to a user's cart
  // Takes a Map of food item information and the user's ID as parameters
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
  // Takes the user's ID as a parameter
  Future<Stream<QuerySnapshot>> getFoodCart(String userId) async {
    return FirebaseFirestore.instance.collection("users").doc(userId).collection("Cart").snapshots();
  }

  // Method to update a food item in the user's cart
  // Takes the ID of the cart item to update and a Map containing the fields to update
  // Method to update a food item in the user's cart
// Takes the user's ID, the ID of the cart item to update, and a Map containing the fields to update
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

}
