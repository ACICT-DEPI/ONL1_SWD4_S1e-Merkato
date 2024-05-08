import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marwan_be2/Database/database.dart';
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

  Widget allItemsvertical() {
    return Expanded(
      child: StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];

                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details(detail: ds["Details"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 9, right: 3),
                      child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 150.0,
                                    width: 130.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 40,),
                                      
                                      Container(
                                        
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          
                                          ds["Name"],
                                          style: Appwidget
                                              .boldTextFeildStyle(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                     
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "\EGP"+ds["Price"],
                                          style: Appwidget.HeadLinetextFeildStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
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
                Text('    WELCOME TO BE2 APP',
                    style: Appwidget.boldTextFeildStyle()),
                
              ],
            ),

            SizedBox(
              height: 20,
            ),
            Text('ALL YOU WANT IS HERE',
                style: Appwidget.HeadLinetextFeildStyle()),
            Text('Discover items', style: Appwidget.LiighttextFeildStyle()),
            SizedBox(
              height: 20.0,
            ),

            Container(margin: EdgeInsets.only(right: 20.0), child: showItem()),

            SizedBox(
              height: 20.0,
            ),

//////////////////////////// item adding\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

/////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

            allItemsvertical(),
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
          onTap: () async{
            Burger = true;
            Pizza = false;
            Drinks = false;
            Sauces = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Burger");
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
          onTap: ()async {
            Burger = false;
            Pizza = true;
            Drinks = false;
            Sauces = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
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
          onTap: ()async {
            Burger = false;
            Pizza = false;
            Drinks = true;
            Sauces = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Drinks");
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
          onTap: () async{
            Burger = false;
            Pizza = false;
            Drinks = false;
            Sauces = true;
            fooditemStream = await DatabaseMethods().getFoodItem("Appetizers");
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
                  'images/extras.png',
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
