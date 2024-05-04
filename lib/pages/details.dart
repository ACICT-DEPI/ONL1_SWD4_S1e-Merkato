import 'package:flutter/material.dart';
import 'package:marwan_be2/Database/database.dart';
import 'package:marwan_be2/Database/pref.dart';
import 'package:marwan_be2/widget/widget_support.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  String image, name, detail, price;
  Details(
      {required this.detail,
      required this.image,
      required this.name,
      required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;
  String? id;

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 50.0,
          left: 10,
          right: 20.0,
        ),
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
                )),
            SizedBox(height: 10.0),
/////////////////////////////////// image \\\\\\\\\\\\\\\\\\\\\\\
            Image.network(
              widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.contain,
            ),
            /////////////////////name\\\\\\\\\\\\\\\\\\
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
                ///////////////////////total price calac (for subtract counter) \\\\\\\\\\\\
                GestureDetector(
                  onTap: () {
                    if (a > 0) {
                      --a;
                      total = total - int.parse(widget.price);
                    }

                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  a.toString(),
                  style: Appwidget.HeadLinetextFeildStyle(),
                ),
                SizedBox(
                  width: 15.0,
                ),
                ///////////////////////total price calac (for add counter) \\\\\\\\\\\\
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                )
              ],
            ),
            ///////////////// Details\\\\\\\\\\\\\\\\
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.detail,
              style: Appwidget.HeadLinetextFeildStyle(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text(
                  'Cooking Tiem',
                  style: Appwidget.HeadLinetextFeildStyle(),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.alarm,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 10.0,
                ),
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
                      //////////////////////price\\\\\\\\\\\\\\\\\\
                      Text(
                        '\EGP' + total.toString(),
                        style: Appwidget.HeadLinetextFeildStyle(),
                      ),
                    ],
                  ),
///////////////////////////////// // add to cart code\\\\\\\\\\\\\\\\\\\\\\
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image,
                      };
                      await DatabaseMethods().addFoodtoCart(addFoodtoCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                        backgroundColor: Colors.orangeAccent,
                        content: Text(
                          "Food add to cart",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
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
