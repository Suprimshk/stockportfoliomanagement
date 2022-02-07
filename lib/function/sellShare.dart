// ignore_for_file: unused_import, file_names, avoid_print, empty_catches, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> sellShare(String name, String qty, ) async {
  try {
    var value = double.parse(qty);
    
    final uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('MyShare')
        .doc(name);

    return await FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(documentReference);
          if (!snapshot.exists) {
            return "No Stock Found with Particular Name";
          }
         

          double newamt =
              (snapshot.data() as Map<String, dynamic>)['qty'] - value;
          transaction.update(documentReference, {'qty': newamt});
          // double newrate =
          //     (snapshot.data() as Map<String, dynamic>)['rate']+rate;
          // transaction.update(documentReference, {'rate': newrate});
          return true;
        })
        .then((value) => print("sucessful"))
        .catchError((error) => print("Failed to buy: $error"));
  } catch (e) {}
}
sellHistory(String name,String qty,String rate)
{

      var status;
     final uid = FirebaseAuth.instance.currentUser!.uid;
       CollectionReference buys = FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('Sellhistory');

   
      
      return buys
          .add({
            'name': name, 
            'rate': rate, 
            'qty': qty,
            'status':"Sell"
        
          })
          .then((value) => print("Share Added"))
          .catchError((error) => print("Failed to add share: $error"));
        
         
    
}