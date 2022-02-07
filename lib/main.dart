// ignore_for_file: prefer_const_constructors, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_portfolio/screen/buysell.dart';
import 'package:mero_portfolio/screen/dashboard.dart';
import 'package:mero_portfolio/widget/buyhistory.dart';
import 'package:mero_portfolio/screen/history.dart';
import 'package:mero_portfolio/screen/login.dart';
import 'package:mero_portfolio/screen/myshare.dart';
import 'package:mero_portfolio/screen/setting.dart';
import 'package:mero_portfolio/screen/signup.dart';
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    FirebaseFirestore.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     debugShowCheckedModeBanner: false,
       themeMode:ThemeMode.light,
       theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
             textTheme: const TextTheme(
           headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
           headline6: TextStyle(fontSize: 20.0, ),
           bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
         ),
       primarySwatch: Colors.deepPurple,
          appBarTheme:AppBarTheme(
            iconTheme: IconThemeData(color:Colors.black),
          
            elevation:0.0,
            backgroundColor: Colors.deepPurple,
          )
       ),
   
       darkTheme:ThemeData(
          // iconTheme: Icon(FontAwesomeIcons.user),
         fontFamily: GoogleFonts.lato().fontFamily,
         primarySwatch: Colors.red),
      routes:
       {
        
        "/":(context)=>Login(),
        "/signup":(context)=>Signup(),
        "/dashboard":(context)=>Dashboard(),
        // "/profile":(context)=>Profile(),
         "/setting":(context)=>Setting(),
          "/history":(context)=>History(),
         "/buysell":(context)=>Buysell(rate: null, qty: null, name: null,),
        //  "/myshare":(context)=>MyShare(),

      },
    );
  }
}


