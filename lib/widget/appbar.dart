// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mero_portfolio/widget/drawer.dart';
import 'package:mero_portfolio/widget/popupmenu.dart';
class Appbar extends StatelessWidget {
  const Appbar({ Key? key }) : super(key: key);

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
      
    );
  }
}