import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
//////// set new item in database 
  Future addFoodItem(Map<String,dynamic> userInfoMap,String name)async{
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

   Future <Stream<QuerySnapshot>> getFoodItem(String name )async{
    return await FirebaseFirestore.instance.collection(name).snapshots();

   }
}