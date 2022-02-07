// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shares extends StatefulWidget {
  const Shares({Key? key}) : super(key: key);

  @override
  _SharesState createState() => _SharesState();
}

class _SharesState extends State<Shares> {
  // final Stream<Querysnapshot> firebaseDB=FirebaseFirestore.instance.collection("share").snapshots();
  final Stream<QuerySnapshot> firebaseDB =
      FirebaseFirestore.instance.collection('share').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseDB,
        builder: (BuildContext conext, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (!snapshot.hasData) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Colors.deepPurple));
          }
          // final List storedocs = [];
          // snapshot.data!.docs.map((DocumentSnapshot document) {
          //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          //   storedocs.add(data);
          //   print(storedocs);
          // });
          return  SingleChildScrollView(
                child: ListView.builder(
                   shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,  index) {
                  return Card(
                    elevation: 0.5,
                    margin: EdgeInsets.symmetric(vertical: 1.0,),
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]["name"]),
                      subtitle: Text(snapshot.data!.docs[index]["fullname"]),
                      trailing:Row(
                        mainAxisSize: MainAxisSize.min ,
                        children: [
                          Text("Rs",style: TextStyle(fontSize: 15.0,color: Colors.red.shade800),),
                          SizedBox(width: 3.0,),
                          Text(snapshot.data!.docs[index]["price"]),
                        ],
                      ) ,
                      
                  
                    ),
                  );
                }),
             

          );
        });
  }
}
