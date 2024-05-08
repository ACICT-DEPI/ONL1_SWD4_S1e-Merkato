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
  bool isDelivery = false;
  String address = '';
  String phoneNumber = '';
  String comments = '';

  void calculateTotal() async {
    try {
      String? userId = await SharedPreferenceHelper().getUserId();
      if (userId != null) {
        Stream<QuerySnapshot> cartStream =
            await DatabaseMethods().getFoodCart(userId);
        int newTotal = 0;
        await for (QuerySnapshot snapshot in cartStream) {
          for (DocumentSnapshot ds in snapshot.docs) {
            newTotal += (ds['total'] as int);
          }
        }
        setState(() {
          total = newTotal;
        });
      }
    } catch (e) {
      print("Error calculating total: $e");
    }
  }

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
        return Container(
          height:
              MediaQuery.of(context).size.height * 0.8, // Set a specific height
          decoration: BoxDecoration(
            color: Colors.white, // Set the color to orange
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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
                      ListTile(
                        title: Text('Delivery'),
                        leading: Radio(
                          value: true,
                          groupValue: isDelivery,
                          onChanged: (value) {
                            setState(() {
                              isDelivery = value as bool;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Pick-up from Restaurant'),
                        leading: Radio(
                          value: false,
                          groupValue: isDelivery,
                          onChanged: (value) {
                            setState(() {
                              isDelivery = value as bool;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      if (isDelivery) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                address = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter your address',
                                hintText: 'Enter your address',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            if (address.isEmpty)
                              Text(
                                'Address is required',
                                style: TextStyle(color: Colors.red),
                              ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ],
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter your phone number',
                              hintText: 'Enter your phone number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          if (phoneNumber.isEmpty)
                            Text(
                              'Phone number is required',
                              style: TextStyle(color: Colors.red),
                            ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                      TextFormField(
                        onChanged: (value) {
                          comments = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Add any comment on your order',
                          hintText: 'Add any comment on your order',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          if (isDelivery && address.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Address is required for delivery'),
                              ),
                            );
                          } else if (phoneNumber.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Phone number is required'),
                              ),
                            );
                          } else {
                            confirmOrder(context, isDelivery, address,
                                phoneNumber, comments);
                          }
                        },
                        child: Text(
                          ' Confirm ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      isScrollControlled: true,
    );
  }

  void confirmOrder(BuildContext context, bool isDelivery, String address,
      String phoneNumber, String comments) async {
    try {
      String? userId = await SharedPreferenceHelper().getUserId();
      if (userId != null) {
        // Create a list to store cart items
        List<Map<String, dynamic>> cartItems = [];

        // Get cart items from Firestore
        QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('Cart')
            .get();

        // Add cart items to the list
        cartSnapshot.docs.forEach((doc) {
          cartItems.add(doc.data() as Map<String, dynamic>);
        });

        // Confirm the order and clear the cart
        await DatabaseMethods().confirmOrder(context, userId, isDelivery,
            address, phoneNumber, comments, cartItems);
      }
    } catch (e) {
      print("Error confirming order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while confirming the order'),
        ),
      );
    }
  }

////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<void> clearCart(String userId) async {
    try {
      await DatabaseMethods().clearCart(userId);
      print("Cart cleared.");
      setState(() {
        total = 0;
      });
    } catch (e) {
      print("Error clearing cart: $e");
    }
  }

  void removeItemFromCart(String itemId) async {
    try {
      String? userId = await SharedPreferenceHelper().getUserId();
      if (userId != null) {
        // Retrieve the item from the cart
        DocumentSnapshot itemSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('Cart')
            .doc(itemId)
            .get();

        // Convert the item data to a Map
        Map<String, dynamic> itemData =
            itemSnapshot.data() as Map<String, dynamic>;

        // Add the item to the Orders collection
        await DatabaseMethods().addOrderItemToOrder(userId, itemData);

        // Remove the item from the cart
        await DatabaseMethods().removeCartItem(userId, itemId);

        // Recalculate the total after removing the item
        calculateTotal();
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
      body: Column(
        children: [
          
          Container(margin: EdgeInsets.only(top: 40),
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(0),
              color: Color.fromARGB(244, 255, 153, 0),
              child: Container(
                
                padding: EdgeInsets.only(bottom: 10.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text(
                      'MY CART',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 15),
                    Icon(
                      Icons.shopping_cart,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                        total = 0;
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            total += (ds['total'] as int);
                            return ListTile(
                              leading: Image.network(
                                ds['Image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(ds['Name']),
                              subtitle: Text('Quantity: ${ds['Quantity']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('\EGP ${ds['total']}'),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      removeItemFromCart(ds.id);
                                    },
                                  ),
                                ],
                              ),
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
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              handleCheckout(context);
            },
            child: Text(
              'Checkout',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
