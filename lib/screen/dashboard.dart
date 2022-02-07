// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mero_portfolio/Database%20Manager/shares.dart';
import 'package:mero_portfolio/widget/myportfolio.dart';
import 'package:mero_portfolio/widget/totalshare.dart';
import 'package:mero_portfolio/widget/buyhistory.dart';
import 'package:mero_portfolio/widget/drawer.dart';
import 'package:mero_portfolio/widget/popupmenu.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: MaterialApp(
      // home: DefaultTabController(
      //   length: 2,
      child: Scaffold(
          //appbar
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
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.width*0.9,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: MyPortfolio(),
                        ),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                         [
                           Expanded(
                            
                             child:
                                 TotalShare(),
                             
                           )
                           ])),
                        SizedBox(
                          height: 20.0,
                        ),
                      
                      ],
                    ),
                  ),
                  Shares(),
                ],
              ),
            ),
          )),
    );
  }
}
