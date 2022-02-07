// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mero_portfolio/widget/buyhistory.dart';
import 'package:mero_portfolio/widget/buyhistory.dart';
import 'package:mero_portfolio/widget/drawer.dart';
import 'package:mero_portfolio/widget/dropdown.dart';
import 'package:mero_portfolio/widget/popupmenu.dart';
import 'package:mero_portfolio/widget/sellhistory.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  @override
  Widget build(BuildContext context) {
   
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
                 height: MediaQuery.of(context).size.height*0.9,
                // width: MediaQuery.of(context).size.width*0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Dropdown(),
              
               
                SizedBox(height: 30.0),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
