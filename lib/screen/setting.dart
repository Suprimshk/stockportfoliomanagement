
// ignore_for_file: prefer_const_constructors, empty_catches, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_portfolio/widget/popupmenu.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var _newpsw = "";
  var confirm = "";
   var newPassword="";
  final newPasswordController= TextEditingController();
  // @override
  // void dispose() {
  //   newPasswordController.dispose();
  //   super.dispose();
  // }
  final _formkey=GlobalKey<FormState>();
  final currentUser=FirebaseAuth.instance.currentUser;
 
changepsw(BuildContext context) 
async {
   if (_formkey.currentState!.validate()) {
      setState(() {
       newPassword=newPasswordController.text;
      });
  }
  try {
    if (_newpsw!=confirm)
    {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text("New Password and Confirmed Password not matched."),
     ),);
    }
    else{
      
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, "/");
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text("Your password has been changed Sucessfully...Please Login."),
     ),);

    }
  } catch (e) {
  }
//  Navigator.pushNamed(context, "/");
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SettingPage"),
          actions: [
            PopupMenu(),
          ],
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Form(
              key:_formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
                    child: TextFormField(
                      controller: newPasswordController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text("Please Enter your New Password."),
     ),);
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "New Password",
                      ),
                      onChanged: (value) {
                        setState(() {
                          _newpsw = value;
                        });
                      },
                    ),
                  ),
                  //end of first input fieled
                  SizedBox(height: 18.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
                    child: TextFormField(
                      validator: (value){
                            if (value!.isEmpty)
                            {
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text("Please Enter New Password."),
     ),);
                            }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                      ),
                      onChanged: (value) {
                        setState(() {
                          confirm = value;
                        });
                      },
                    ),
                  ),
                  //end of second input fieled
                  SizedBox(height: 28.0),
                  //button
                  Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.purple,
                    child: InkWell(
                      onTap: ()=>changepsw(context),
                      hoverColor: Colors.amber,
                      child: Container(
                        color: Colors.deepPurple,
                        padding: EdgeInsets.all(18.0),
            
                        // decoration: Decoration(
            
                        // ),
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

