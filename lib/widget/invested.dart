// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_portfolio/widget/totalsold.dart';

class Invested extends StatefulWidget {
  const Invested( { Key? key }) : super(key: key);

  @override
  _InvestedState createState() => _InvestedState();
}

class _InvestedState extends State<Invested> {
  
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String qty = "";
    String rate = "";
   double subtotal=0;
   double total=0;
  
   callback (totalinvested)
   {
     setState(() {
       total=totalinvested;
     });
   }
    return  StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc(uid)
              .collection("Buyhistory")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              // for (var result in snapshot.data!.docs)
           snapshot.data!.docs.forEach((result)
               {
                dynamic finqty = result.data() as Map<String, dynamic>;
                dynamic finrate = result.data() as Map<String, dynamic>;
               
               qty=  finqty['qty'].toString();
                rate = finrate['rate'].toString();
                var qtyy=double.parse(qty);
                   var ratee=double.parse(rate);
                //  var subtotal= finqty['qty'] *  finrate['rate'];
               subtotal= ratee * qtyy ;

               
                total = subtotal+total;
                  log(" total =$total");
             
              });
              return Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                 
                    
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text("Total Invested:", 
                       style: TextStyle(
                           color: Colors.black,
                            fontSize:20.0,
                       )),
                        ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                    total.toString(),
                         style: TextStyle(
                           color: Colors.black,
                            fontSize:20.0,
                   
                        ),
                    ),
                     ),
                 
                ],
              );
                  
            }
          });
          
  }
}
