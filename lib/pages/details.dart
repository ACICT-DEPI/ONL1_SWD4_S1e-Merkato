import 'package:flutter/material.dart';

import 'package:marwan_be2/widget/widget_support.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  int a=1;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: 
      Container(
        margin: EdgeInsets.only(top: 50.0,left: 10,right: 20.0,),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,)),
            SizedBox(height: 50.0),
            Image.asset('images/classic-burger.png',width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,fit: BoxFit.fill,),
            SizedBox(height: 20.0),
            
            Row(
              
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('classic peef burger ', style:Appwidget.boldTextFeildStyle(),),
                ],
              ),
              Spacer(),

            
              GestureDetector(
                onTap: () {
                  if (a>0) {
                    --a;
                  }
                  
                  setState(() {
                    
                  });
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.remove,color: Colors.white,size: 25.0,),
                ),
              ),
              SizedBox(width: 15.0,),
              
            Text(a.toString(),style: Appwidget.HeadLinetextFeildStyle(),),
             SizedBox(width: 15.0,),

             
               GestureDetector(
                onTap: () {
                  ++a;
                  setState(() {
                    
                  });
                },
                 child: Container(
                  decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.add,color: Colors.white,size: 25.0,),
                               ),
               )
            ],
          ),
          SizedBox(height: 20.0,),
          Text('Classic burger contains bread,ketchup sauce, tomatoes, lettuce and a piece of meat ',
          style: Appwidget.LiighttextFeildStyle(),),
          Row(children: [
            Text('Cooking Tiem',style: Appwidget.HeadLinetextFeildStyle(),),
            SizedBox(width: 10.0,),
            Icon(Icons.alarm ,color: Colors.orange,),
             SizedBox(width: 10.0,),
             Text('20 Min',style: Appwidget.HeadLinetextFeildStyle(),),
          ],),
          Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                Text('Total Price',style: Appwidget.SimitextFeildStyle(),),
                Text('\$25',style: Appwidget.HeadLinetextFeildStyle(),),
              ],),

              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
       
                      Text('Add to cart ',style: TextStyle(color: Colors.white,fontSize: 16.0,
                      fontFamily: 'Roboto' ,),),

                      // add to cart code 
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 252, 252, 252),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: 
                      Icon(Icons.shopping_cart_outlined,color: const Color.fromARGB(255, 0, 0, 0),)
                      
                      ,)
                    ],
                  ),
              )
              
                      ],),
            )

        ],
        ),
      ),
    );
  }
}