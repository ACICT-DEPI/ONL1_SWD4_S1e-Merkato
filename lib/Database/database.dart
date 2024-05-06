import 'package:cloud_firestore/cloud_firestore.dart';


// Class responsible for interacting with the Firestore database
class DatabaseMethods {
    // Method to add user details to the database
  // Takes a Map of user information and a unique user ID as parameters

  Future addUsserDetails(Map<String, dynamic> userInfoMap, String id) async {
  
     // Set the user details in the "users" collection with the provided ID
       return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

// Method to add a new food item to the database
  // Takes a Map of food item information and the name of the food item as parameters
  Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
        // Add the food item to a collection with the same name as the food item
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  // Method to retrieve a stream of food items from the database
  // Takes the name of the food item as a parameter

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }


  // Method to add a food item to a user's cart
  // Takes a Map of food item information and the user's ID as parameters
 Future addFoodtoCart(Map<String, dynamic> userInfoMap, String id, int total) async {
  // Add the total price to the userInfoMap
  userInfoMap["total"] = total;

  // Add the food item to the "Cart" subcollection of the user's document
  return await FirebaseFirestore.instance
      .collection("users")
      .doc(id)
      .collection("Cart")
      .add(userInfoMap);
}


  
  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return await FirebaseFirestore.instance.collection("Users").doc(id).collection("Cart").snapshots();
  }
}
