import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marwan_be2/Database/database.dart';
import 'package:marwan_be2/Database/pref.dart';
import 'package:marwan_be2/widget/widget_support.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late Future<Stream<QuerySnapshot>> foodStreamFuture = Future.value(Stream.empty());

  @override
  void initState() {
    super.initState();
    loadFoodCart();
  }

  Future<void> loadFoodCart() async {
    try {
      String? userId = await SharedPreferenceHelper().getUserId();
      if (userId != null) {
        setState(() {
          foodStreamFuture = DatabaseMethods().getFoodCart(userId);
        });
      } else {
        setState(() {
          foodStreamFuture = Future.value(Stream.empty());
        });
      }
    } catch (e) {
      print("Error loading food cart: $e");
      setState(() {
        foodStreamFuture = Future.value(Stream.empty());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: FutureBuilder<Stream<QuerySnapshot>>(
        future: foodStreamFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No items in the cart.'),
            );
          } else {
            return StreamBuilder<QuerySnapshot>(
              stream: snapshot.data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No items in the cart.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return ListTile(
                        leading: Image.network(
                          ds['Image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(ds['Name']),
                        subtitle: Text('Quantity: ${ds['Quantity']}'),
                        trailing: Text('\$${ds['Total']}'),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
