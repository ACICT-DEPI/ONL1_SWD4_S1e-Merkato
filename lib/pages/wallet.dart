import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  List<bool> orderCheckedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
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
              child: Text('No orders found.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot orderDoc = snapshot.data!.docs[index];
                Map<String, dynamic> orderData = orderDoc.data() as Map<String, dynamic>;
                int total = 0;

                if (orderCheckedList.length <= index) {
                  orderCheckedList.add(false);
                }

                if (orderData['items'] != null) {
                  for (var item in orderData['items']) {
                    total += (item['total'] as int);
                  }
                }

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order #${orderDoc.id}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                            if (!orderCheckedList[index]) // Show an alert if order isn't checked
                              Text(
                                'Order not checked',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.0,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              orderData['delivery'] ? Icons.delivery_dining : Icons.storefront,
                              color: orderData['delivery'] ? Colors.green : Colors.blue,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              orderData['delivery'] ? 'Delivery' : 'Pick-up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: orderData['delivery'] ? Colors.green : Colors.blue,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'User ID: ${orderData['userId']}',
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        if (orderData['delivery'])
                          Text(
                            'Delivery Address: ${orderData['address']}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        Text(
                          'Phone Number: ${orderData['phoneNumber']}',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        if (orderData['comments'] != null && orderData['comments'].isNotEmpty)
                          Text(
                            'Comments: ${orderData['comments']}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        SizedBox(height: 8.0),
                        Divider(),
                        SizedBox(height: 8.0),
                        Text(
                          'Order Items:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        if (orderData['items'] != null)
                          ...((orderData['items'] as List<dynamic>).map((item) {
                            return ListTile(
                              title: Text(
                                item['name'] ?? '',
                                style: TextStyle(fontSize: 14.0),
                              ),
                              subtitle: Text(
                                'Quantity: ${item['quantity']}, Total: \$${item['total']}',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            );
                          }).toList()),
                        SizedBox(height: 16.0),
                        Center(
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Check the order
                                  setState(() {
                                    orderCheckedList[index] = true;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                    return orderCheckedList[index] ? Colors.green : Colors.red;
                                  }),
                                ),
                                child: Text(orderCheckedList[index] ? 'Order Checked' : 'Prepare Order',style: TextStyle(color: Colors.white,fontSize: 20),),
                              ),
                              SizedBox(width: 50.0),
                              
                              
                            ],
                          ),
                        ),SizedBox(height: 10.0),
                        
                        Text(
                          'Total for Order: \$${total}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
