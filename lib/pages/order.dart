import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marwan_be2/Database/database.dart';
import 'package:marwan_be2/Database/pref.dart';
import 'package:marwan_be2/my-cart/database_methods.dart.dart';
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
        return StatefulBuilder(
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
                        labelText: 'Add any comments (optional)',
                        hintText: 'Add any comments (optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (isDelivery && address.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Address is required for delivery'),
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
                      child: Text('Proceed to Checkout'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      isScrollControlled: true,
    );
  }

void confirmOrder(BuildContext context, bool isDelivery, String address, String phoneNumber, String comments) async {
  try {
    String? userId = await SharedPreferenceHelper().getUserId();
    if (userId != null) {
      // Here you can perform any actions necessary to confirm the order,
      // such as sending order details to a backend server or displaying a summary to the user.

      // Clear the cart
      await clearCart(userId);

      // Show a confirmation dialog to the user
      bool confirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Order'),
            content: Text('Do you want to confirm this order?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true); // Return true if confirmed
                },
                child: Text('Confirm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false); // Return false if canceled
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );

      if (confirmed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order confirmed and cart cleared.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order not confirmed. Cart was not cleared.'),
          ),
        );
      }
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
////////////////////\\\\\\\\\\\\\\\\\\\\\\

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
        await DatabaseMethods().removeCartItem(userId, itemId);
        print("Item $itemId removed from cart.");
        calculateTotal();
      } else {
        print("User ID not found.");
      }
    } catch (e) {
      print("Error removing item from cart: $e");
    }
  }

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
