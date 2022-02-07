// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:mero_portfolio/widget/buyhistory.dart';
import 'package:mero_portfolio/widget/sellhistory.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
   final _operation = ["Buy", "Sell"];
     bool change = true;
    var _values = "Buy";
  @override
  Widget build(BuildContext context) {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DropdownButton<String>(
          value: _values,
           
          onChanged: (value) {
            setState(() {
               _values=value!;
               print("Selected option changed to  $value");
               change = false;
            });
         
          },
          
          items: _operation.map((String values) {
            return DropdownMenuItem<String>(
                value: values, child: Center(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(values),
                )));
          }).toList(),
         
        ),
        SizedBox(
          height: 0.0,
        ),
        //container
        Container(
          constraints: BoxConstraints(maxHeight: 90000),
          child: Expanded(
            child: Column(
              children: [
                change
                    ? Flexible(child: BuyHistory())
                    : Flexible(child: SellHistory()),
                    
              ],
            ),
          ),
        ),
      ],
    );
  }
}
