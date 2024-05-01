import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marwan_be2/pages/bottomNav.dart';
import 'package:marwan_be2/pages/login.dart';
import 'package:marwan_be2/widget/widget_support.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  String email = "", password = "", name = "";

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

//
//registration check code
  registration() async {
    // ignore: unnecessary_null_comparison
    if (password != null) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Color.fromARGB(255, 5, 5, 5),
          content: Text(
            "Registered successfully ",
            style: TextStyle(fontSize: 20.0),
          ),
        )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
      } on FirebaseException catch (e) {
        if (e.code == 'weak password') {
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password provied is too weak",
              style: TextStyle(fontSize: 20.0),
            ),
          )));
        } else if (e.code == "eamil is already-in-use ") {
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Account Already exsists",
              style: TextStyle(fontSize: 20.0),
            ),
          )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // sing in icons
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
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25.0, right: 30.0, left: 30.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'images/be2logo.png',
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                  ),
                  Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      //
/////////////////////////////////// singin textfeild//////////////////////////////

                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.0,
                            ),

                            Text(
                              'Sing UP',
                              style: Appwidget.boldTextFeildStyle(),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),

//////////////////////////////////// text fileds adding///////////////////////////////////
                            TextFormField(
                              controller: namecontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your Name";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: Appwidget.SimitextFeildStyle(),
                                prefixIcon: Icon(Icons.person_2_outlined),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),

                            TextFormField(
                              controller: emailcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your E-mail";
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return "Please Enter a valid Email";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: Appwidget.SimitextFeildStyle(),
                                prefixIcon: Icon(Icons.email_outlined),
                            
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),

                            TextFormField(
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your Password";
                                } else if (value.length < 7) {
                                  return "Password should be at least 7 characters";
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: Appwidget.SimitextFeildStyle(),
                                prefixIcon: Icon(Icons.password_outlined),
                                
                              ),
                            ),

                            SizedBox(
                              height: 50.0,
                            ),
//////////////////////////////// login botton adding///////////////////////////////////////
                            GestureDetector(
                              /////////////////////////////////check validate//////////////////////////////////////////
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    email = emailcontroller.text;
                                    name = namecontroller.text;
                                    password = passwordcontroller.text;
                                  });
                                }
                                registration();
                              },
                              child: Material(
                                elevation: 20.0,
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text('SING UP',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold)),
                                    )),
                              ),
                            ),

                            // end of text fileds adding
                            ///Already  have account
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Text(
                      "Already  have account? Login",
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