import 'package:flutter/material.dart';
import 'package:marwan_be2/pages/home.dart';
import 'package:marwan_be2/pages/order.dart';
import 'package:marwan_be2/pages/profile.dart';
import 'package:marwan_be2/pages/wallet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';



class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currenTabindex=0;

// HOME PAGE NAV BAR ADDING
  late List<Widget>pages;
  late Widget curretPage;
  late Home homepage;
  late Profile profile;
  late Order order;
  late Wallet wallet;

  @override
  void initState() {
    homepage=Home();
    order=Order();
    wallet=Wallet();
    profile=Profile();
   
    pages=[homepage,order,wallet,profile];


    super.initState();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: CurvedNavigationBar
        (
           height:60.0 ,
           backgroundColor: Colors.white,
           color: Colors.orange,

           animationDuration: Duration(milliseconds: 500) ,
           onTap: (int index){
              setState(() {
                currenTabindex=index;
              });
                
           },
          
          items: 
        [Icon
        (Icons.home_outlined,
        color: Colors.black,
        ),
        Icon
        (Icons.shopping_bag_rounded,
        color: Colors.black,
        ),
        Icon
        (Icons.wallet_outlined,
        color: Colors.black,
        ),
        Icon
        (Icons.person_outline,
        color: Colors.black,
        ),
        ] ),
        body: pages[currenTabindex],
    );
  }
}

