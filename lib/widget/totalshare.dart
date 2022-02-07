// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';

import 'package:mero_portfolio/widget/invested.dart';
import 'package:mero_portfolio/widget/totalqty.dart';
import 'package:mero_portfolio/widget/totalsold.dart';

class TotalShare extends StatefulWidget {
  const TotalShare({Key? key}) : super(key: key);

  @override
  _TotalShareState createState() => _TotalShareState();
}

class _TotalShareState extends State<TotalShare> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Invested(),
               TotalSold(),
         
              TotalQty(),
             
            ],
          ),
        ),
      ),
    );
  }
}
