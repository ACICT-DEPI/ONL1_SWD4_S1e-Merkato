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
  late Future<Stream<QuerySnapshot>> foodStreamFuture =
      Future.value(Stream.empty());
  int total = 0;

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

  void handleCheckout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Checkout Options',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement logic to remove items from cart
                    // For now, just print a message
                    print('Removing items from cart...');
                    Navigator.pop(context); // Close bottom sheet
                  },
                  child: Text('Remove Item from Cart'),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter your address',
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter your phone number',
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement logic to proceed with checkout
                    print('Proceeding with checkout...');
                    Navigator.pop(context); // Close bottom sheet
                  },
                  child: Text('Proceed to Checkout'),
                ),
              ],
            ),
          ),
        );
      },
      isScrollControlled: true, // Set to true to make the bottom sheet take up full screen height
    );
  }

  void removeItemFromCart(String itemId) async {
    try {
      // Get the user ID
      String? userId = await SharedPreferenceHelper().getUserId();
      if (userId != null) {
        // Remove the item from the user's cart in Firestore
        await DatabaseMethods().removeCartItem(userId, itemId);
        print("Item $itemId removed from cart.");
      } else {
        print("User ID not found.");
      }
    } catch (e) {
      print("Error removing item from cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Stream<QuerySnapshot>>(
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
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('No items in the cart.'),
                        );
                      } else {
                        total = 0; // Reset total before calculating
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            total += (ds['total'] as int); // Calculate total
                            return ListTile(
                              leading: Image.network(
                                ds['Image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(ds['Name']),
                              subtitle: Text('Quantity: ${ds['Quantity']}'),
                              trailing: Text('\$${ds['total']}'),
                              onTap: () {
                                // Implement logic to remove item from cart
                                removeItemFromCart(ds.id);
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price",
                  style: Appwidget.boldTextFeildStyle(),
                ),
                Text(
                  "\$" + total.toString(),
                  style: Appwidget.SimitextFeildStyle(),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              handleCheckout(context);
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
