
import 'package:flutter/material.dart';
import 'package:marwan_be2/widget/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  ////////
  ///
  ///

  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(0),
              color: Color.fromARGB(244, 255, 153, 0),
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0, top: 10),
                child: Center(
                  child: Text(
                    'MY WALLET',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 253, 253),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              margin: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                children: [
                  Image.asset(
                    "images/wallet.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Wallet ",
                        style: Appwidget.LiighttextFeildStyle(),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        " \EGP" + "100",
                        style: Appwidget.HeadLinetextFeildStyle(),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Add money",
                style: Appwidget.boldTextFeildStyle(),
              ),
            ),
            SizedBox(height: 10.0),
            //////////////////add money amount \\\\\\\\\\\\\\\\\\\\\\\\
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\EGP' + "100",
                    style: Appwidget.SimitextFeildStyle(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\EGP' + "200",
                    style: Appwidget.SimitextFeildStyle(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\EGP' + "300",
                    style: Appwidget.SimitextFeildStyle(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\EGP' + "500",
                    style: Appwidget.SimitextFeildStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0),
              padding: EdgeInsets.symmetric(vertical: 12.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                "Add Money",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }


//////// money adding  \\\\\\\\\\\\\\\
 

  // Future<void> makePayment(String amount) async {
  //   try {
  //     paymentIntent = await createPaymentIntent(amount, 'INR');
  //     //Payment Sheet
  //     await Stripe.instance
  //         .initPaymentSheet(
  //             paymentSheetParameters: SetupPaymentSheetParameters(
  //                 paymentIntentClientSecret: paymentIntent!['client_secret'],
  //                 // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
  //                 // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
  //                 style: ThemeMode.dark,
  //                 merchantDisplayName: 'Adnan'))
  //         .then((value) {});

  //     ///now finally display payment sheeet
  //     displayPaymentSheet(amount);
  //   } catch (e, s) {
  //     print('exception:$e$s');
  //   }
  // }





}
