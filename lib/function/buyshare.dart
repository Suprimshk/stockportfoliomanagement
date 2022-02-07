
// ignore_for_file: avoid_print, empty_catches, prefer_typing_uninitialized_variables, unused_local_variable

  //MY SHARE..........................................
  import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> myShare(String name, String qty, String rate) async {
    
    try {
      var value = double.parse(qty);
      
      // var name="";
      //  double rate = double.parse(rate);
      final uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('MyShare')
          .doc(name);

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
            DocumentSnapshot snapshot =
                await transaction.get(documentReference);
            if (!snapshot.exists) {
              documentReference.set({'qty': value});
                //  documentReference.set({'name': name});
              // documentReference.set({'rate': rate});
              return true;
            }

            double newamt =
                (snapshot.data() as Map<String, dynamic>)['qty'] + value;
                 transaction.update(documentReference, {'qty': newamt});
            // documentReference.set({'name': name});
            // double newrate =
            //     (snapshot.data() as Map<String, dynamic>)['rate']+rate; 
          //  log(name);
          //    log(qty);
            // transaction.update(documentReference, {'rate': newrate});
            return true;
            
          })
          .then((value) => print("sucessful"))
          .catchError((error) => print("Failed to buy: $error"));
    } catch (e) {}

  }

  //add share.................................................


    Future<void> addShare(String name, String qty, String rate)
   {
      var status;
     final uid = FirebaseAuth.instance.currentUser!.uid;
       CollectionReference buys = FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('Buyhistory');

  //  total(name,rate,qty);
      
      return buys
          .add({
            'name': name,
            'qty': qty,
            'rate': rate, 
            
            'status':"Buy"
        
          })
          .then((value) => print("Share Added"))
          .catchError((error) => print("Failed to add share: $error"));
          // total=${buys['qty']*buys['rate']};
         
    }

 