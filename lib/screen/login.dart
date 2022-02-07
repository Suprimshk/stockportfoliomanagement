// ignore_for_file: unnecessary_null_comparison, avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _email = "";
  var _password = "";
  bool change = false;
  final _formkey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        change = true;
      });
      try {
        final newuser = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        if (newuser != null) {
          await Future.delayed(const Duration(seconds: 0));

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You've successfully Logedin..."),
            ),
          );
          // await Navigator.pushNamed(context, "/home");
          await Navigator.pushNamedAndRemoveUntil(
              context, "/dashboard", (route) => false);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No user found for that email."),
            ),
          );
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Wrong password provided for that user."),
            ),
          );
        }
      }

      setState(() {
        change = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Enter your Valid Email and Password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 5.0,
        //   centerTitle: true,
        //   title: const Text("Login Page"),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:170.0),
              CircleAvatar(radius: 60.0,
  backgroundImage: AssetImage('assets/images/login.png'),
             
                
               
               ) ,
             
              // const Center(
              //   child: Text(
              //     "Welcome ",
              //     style: TextStyle(
              //       fontSize: 40.0,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 15.0,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 50.0),
                      child: TextFormField(
                        obscureText: false,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.user),
                          hintText: "Email",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Email Field cant be empty");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 50.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Password Field cant be empty");
                          } else if (value.length < 8) {
                            return ("Password should be greater than 8");
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.lock),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(change ? 50 : 150),
                      color: Colors.purple,
                      child: InkWell(
                        onTap: () => moveToHome(context),
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 0),
                          width: change ? 50.0 : 150.0,
                          height: 50.0,
    
                          alignment: Alignment.center,
                          child: change
                              ? const Icon(Icons.done)
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(change? 50 : 150),
                          // color: Colors.purple),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/signup");
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ))
                      ],
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
