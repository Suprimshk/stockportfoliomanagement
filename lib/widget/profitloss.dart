// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mero_portfolio/widget/invested.dart';
import 'package:mero_portfolio/widget/totalsold.dart';

class ProfitLoss extends StatefulWidget { 
 final totalinvested="";
  final totalsold="";

  const ProfitLoss({  final totalinvested="", final totalsold="", Key? key }) : super(key: key);

  @override
  _ProfitLossState createState() => _ProfitLossState();
}

class _ProfitLossState extends State<ProfitLoss> {
  @override
  Widget build(BuildContext context) { 
    return Container(
     child: Column(children: [
       Invested( ),
       TotalSold()
       ]),

    );
  }
}