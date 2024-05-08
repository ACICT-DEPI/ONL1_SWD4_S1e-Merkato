import 'package:flutter/material.dart';
import 'package:marwan_be2/pages/home.dart';
import 'package:marwan_be2/pages/order.dart';
import 'package:marwan_be2/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  late List<Widget> pages;
  late Home homePage;
  late Profile profilePage;
  late Order orderPage;

  @override
  void initState() {
    homePage = Home();
    orderPage = Order();
    profilePage = Profile();

    pages = [homePage, orderPage, profilePage];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60.0,
        backgroundColor: Colors.white,
        color: Colors.orange,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          Icon(
            Icons.shopping_bag_rounded,
            color: Colors.black,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.black,
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
