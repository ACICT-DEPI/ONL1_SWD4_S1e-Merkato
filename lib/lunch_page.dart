import 'package:flutter/material.dart';
import 'package:marwan_be2/admin/admin_login.dart';
import 'package:marwan_be2/pages/singin.dart';

class LunchPage extends StatelessWidget {
  const LunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // "MY CART" section at the top
            Material(
              
              color: Color.fromARGB(244, 255, 153, 0),
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BE2 FOOD APP',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Center(
                      child: Image.asset(
                        'images/be2logo.png',
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                    ),
            SizedBox(height: 0), 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SingUp()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "LET'S START WITH USER",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminLogin()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "LET'S START WITH ADMIN",
                    style: TextStyle(fontSize: 18, color: Colors.black,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
