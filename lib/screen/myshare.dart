
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_portfolio/widget/drawer.dart';
import 'package:mero_portfolio/widget/popupmenu.dart';

class MyShare extends StatefulWidget {
  const MyShare({ Key? key }) : super(key: key);

  @override
  State<MyShare> createState() => _MyShareState();
}

class _MyShareState extends State<MyShare> {
  @override
  Widget build(BuildContext context) {
     final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        actions: [
          //popupmenu
          PopupMenu(),
        ],
      ),
      //drawer
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.0,),
           Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 10.0),
              child: Table(
      
                  // textDirection: TextDirection.rtl,
                   defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  border: TableBorder.all(width: 1.0, color: Colors.black26),
                  children: [
                    TableRow(
                      children: [
                      // Padding(
                      //     padding: EdgeInsets.all(10.0),
                      //     child: Text(
                      //       "Name",
                      //       textScaleFactor: 1.5,
                      //     )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Qty",
                            textScaleFactor: 1.5,
                          )),
                    
                     
                    ]),
                  ]),
            ),
            Column(
              children: [
             
                Center(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('User')
                          .doc(uid)
                          .collection('MyShare')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
      
                        if (!snapshot.hasData) {
                          return Text("Document does not exist");
                        }
      
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.deepPurple));
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              // return ListView(
                              //                       children: [
                              //                         snapshot.data.docs.map((document) {
                              //                           return Container(
                              //                             child: Row(children: [
                              //                               Text("Name="${document.id}),
                              //                               Text("Qty="${document.id}),
                              //                             ],),
                              //                           )
                              //                         })
                              //                       ],
                              // ),
                            return   Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                child: Table(
                                    border: TableBorder.all(
                                        width: 1.0, color: Colors.black26),
                                    children: [
                                      TableRow(
      
                                          // decoration: ,
                                          children: [
                                             Padding(
                                                 padding:
                                                     EdgeInsets.all(10.0),
                                                 child: Text(
                                                   snapshot.data!.docs[index]
                                                       ['name'],
                                                   textScaleFactor: 1.5,
                                                 )),
                                            Padding(
                                                padding:
                                                    EdgeInsets.all(10.0),
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      ['qty'].toString(),
                                                  textScaleFactor: 1.5,
                                                )),
                                           
                                     
                                             
                                          ]),
                                    ]),
                              );
                            });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}