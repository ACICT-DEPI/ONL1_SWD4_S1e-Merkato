import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersListPage extends StatelessWidget {
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
                return ListTile(
                  title: Text('Order #${orderDoc.id}'),
                  subtitle: Text('Total: \$${orderData['total']}'),
                  onTap: () {
                    // Navigate to order details page if needed
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
