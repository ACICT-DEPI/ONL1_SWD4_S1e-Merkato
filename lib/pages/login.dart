import 'package:flutter/material.dart';
import 'package:marwan_be2/pages/singin.dart';
import 'package:marwan_be2/widget/widget_support.dart';


class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
            child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromARGB(188, 255, 102, 0),
                    Color.fromARGB(235, 245, 139, 0),
                  ])),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25.0, right: 30.0, left: 30.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'images/be2logo.png',
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                  ),
                  Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
        
                          Text(
                            'Login',
                            style: Appwidget.boldTextFeildStyle(),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
        
                          // text fileds adding
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: Appwidget.SimitextFeildStyle(),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
        
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: Appwidget.SimitextFeildStyle(),
                              prefixIcon: Icon(Icons.password_outlined),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 35.0,
                          ),
        
                          // login botton
                          Material(
                            elevation: 20.0,
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                width: 200.0,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text('LOGIN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold)),
                                )),
                          ),
        
                          // end of text fileds adding
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SingUp()));
                    },
                    child: Text(
                      "Don't have account? Sign Up",
                      style: Appwidget.HeadLinetextFeildStyle(),
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
