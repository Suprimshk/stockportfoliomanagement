// ignore: file_names
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_portfolio/widget/drawer.dart';
import 'package:mero_portfolio/widget/popupmenu.dart';

class BuyHistory extends StatefulWidget {
  const BuyHistory({Key? key}) : super(key: key);

  @override
  _BuyHistoryState createState() => _BuyHistoryState();
}

class _BuyHistoryState extends State<BuyHistory> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: Table(

                  // textDirection: TextDirection.rtl,
                  defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  border: TableBorder.all(width: 1.0, color: Colors.black26),
                  children: [
                    TableRow(children: [
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Name",
                            textScaleFactor: 1.5,
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Qty",
                            textScaleFactor: 1.5,
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Rate",
                            textScaleFactor: 1.5,
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Status",
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
                          .collection('Buyhistory')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (!snapshot.hasData) {
                          return Text("Document does not exist");
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.deepPurple));
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Table(
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
                                                      snapshot.data!
                                                          .docs[index]['qty']
                                                          .toString(),
                                                      textScaleFactor: 1.5,
                                                    )),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Text(
                                                      snapshot.data!
                                                          .docs[index]['rate']
                                                          .toString(),
                                                      textScaleFactor: 1.5,
                                                    )),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Text(
                                                      snapshot.data!.docs[index]
                                                          ['status'],
                                                      textScaleFactor: 1.5,
                                                    )),
                                              ]),
                                        ]),
                                  ],
                                ),
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
