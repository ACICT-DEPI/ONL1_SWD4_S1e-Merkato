import 'package:flutter/material.dart';
import 'package:marwan_be2/Database/database.dart';
import 'package:marwan_be2/Database/pref.dart';
import 'package:marwan_be2/widget/widget_support.dart';

class Details extends StatefulWidget {
  final String image, name, detail, price;

  const Details({
    required this.detail,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  late String? userId;

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  Future<void> getSharedPref() async {
    userId = await SharedPreferenceHelper().getUserId();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> addToCart() async {
    if (userId != null) {
      try {
        int totalPrice = int.parse(widget.price) * quantity;
        Map<String, dynamic> cartItem = {
          "Name": widget.name,
          "Quantity": quantity.toString(),
          "Image": widget.image,
          "Total": totalPrice,
        };

        await DatabaseMethods().addFoodToCart(cartItem, userId!);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              duration: Duration(milliseconds: 1000),
              content: Text("Item added to cart", style: Appwidget.HeadLinetextFeildStyle()),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text("Failed to add food to cart"),
            ),
          );
        }
        print("Error adding food to cart: $e");
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("User ID not found"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 10, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Image.network(
              widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: Appwidget.boldTextFeildStyle(),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                Text(
                  quantity.toString(),
                  style: Appwidget.HeadLinetextFeildStyle(),
                ),
                SizedBox(width: 15.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              widget.detail,
              style: Appwidget.HeadLinetextFeildStyle(),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  'Cooking Time',
                  style: Appwidget.HeadLinetextFeildStyle(),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.alarm,
                  color: Colors.orange,
                ),
                SizedBox(width: 10.0),
                Text(
                  '20 Min',
                  style: Appwidget.HeadLinetextFeildStyle(),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: Appwidget.SimitextFeildStyle(),
                      ),
                      Text(
                        '\EGP' + (int.parse(widget.price) * quantity).toString(),
                        style: Appwidget.HeadLinetextFeildStyle(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: addToCart,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Add to cart ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 252, 252, 252),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
