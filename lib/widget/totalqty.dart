// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TotalQty extends StatefulWidget {
  const TotalQty({Key? key}) : super(key: key);

  @override
  _TotalQtyState createState() => _TotalQtyState();
}

class _TotalQtyState extends State<TotalQty> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     total
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String qty = "";

    double total = 0;
    
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc(uid)
            .collection("MyShare")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            // for (var result in snapshot.data!.docs)
            snapshot.data!.docs.forEach((result) {
              dynamic finqty = result.data() as Map<String, dynamic>;

              qty = finqty['qty'].toString();

              double qtyy = double.parse(qty);
              total = qtyy + total;
              log(" total =$total");
            });
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text("Total Unit:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    total.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
