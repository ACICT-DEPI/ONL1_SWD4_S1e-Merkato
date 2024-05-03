import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marwan_be2/firebase/database.dart';
import 'package:marwan_be2/pages/details.dart';

import 'package:marwan_be2/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool Burger = false, Pizza = false, Drinks = false, Sauces = false;

  Stream? fooditemStream;

  ontheLoad() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Burger");
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }
  

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Details()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                ClipRRect(
                                   borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    
                                    ds["Image"],
                                    height: 130.0,
                                    width: 170.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  ds["Name"],
                                  style: Appwidget.boldTextFeildStyle(),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  ds["Details"],
                                  style: Appwidget.LiighttextFeildStyle(),
                                ),
                                Text(
                                  ds["Price"],
                                  style: Appwidget.HeadLinetextFeildStyle(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 9.0, right: 1.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('WELCOME TO BE2 APP',
                    style: Appwidget.boldTextFeildStyle()),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Color.fromARGB(255, 245, 245, 243),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 30,
            ),
            Text('ALL YOU WANT IS HERE',
                style: Appwidget.HeadLinetextFeildStyle()),
            Text('Discover items', style: Appwidget.LiighttextFeildStyle()),
            SizedBox(
              height: 20.0,
            ),

            Container(margin: EdgeInsets.only(right: 20.0), child: showItem()),

            SizedBox(
              height: 30.0,
            ),

//////////////////////////// item adding\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

            Container(
              
              height: 290, child: allItems()),
/////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            SizedBox(
              height: 20.0,
            ),

            //// las vages burger adding
            Container(
              margin: EdgeInsets.only(right: 15.0),
              child: Material(
                elevation: 6.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // las vages image here
                      Image.asset(
                        'images/classic-burger.png',
                        height: 100.0,
                        width: 120.0,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            'las Vages Burger',
                            style: Appwidget.HeadLinetextFeildStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            'Beef burger with pineaolle pieces',
                            style: Appwidget.LiighttextFeildStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            '\$25',
                            style: Appwidget.boldTextFeildStyle(),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              ),
            ),

            ///
          ],
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //  burger icon adding
        GestureDetector(
          onTap: () {
            Burger = true;
            Pizza = false;
            Drinks = false;
            Sauces = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      Burger ? Colors.orange : Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/burgerrs.png',
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        // pizza icon adding
        GestureDetector(
          onTap: () {
            Burger = false;
            Pizza = true;
            Drinks = false;
            Sauces = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      Pizza ? Colors.orange : Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/pizza icon.png',
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // drinks icon adding
        GestureDetector(
          onTap: () {
            Burger = false;
            Pizza = false;
            Drinks = true;
            Sauces = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      Drinks ? Colors.orange : Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'images/drinks-icon.png',
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // sauces icon adding
        GestureDetector(
          onTap: () {
            Burger = false;
            Pizza = false;
            Drinks = false;
            Sauces = true;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      Sauces ? Colors.orange : Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/sauces.png',
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
