// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var _email = "";
  var _password = "";
  var _repsw = "";
  bool change = false;
  TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
//get UID
  Future<String> getCurrentUID() async {
    return (firebaseauth.currentUser)!.uid;
  }

//registration
  // registration() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: _email, password: _password);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  moveToHome(String email,String password) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        change = true;
      });
      if (_password == _repsw) {
        try {
          UserCredential usercredentail = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
          print(usercredentail);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You've successfully Registered.Please Login..."),
            ),
          );
          // await Future.delayed(const Duration(seconds: 0));
          await Navigator.pushNamed(context, "/");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("The password provided is too weak."),
              ),
            );
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
            return ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("The account already exists for that email."),
              ),
            );
          }
        } catch (e) {
          print(e);
        }
      } else {
        print("passwordand repsw doesnt matched");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password and Confirm Password Wrong"),
          ),
        );
      }

      setState(() {
        change = false;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/signin.png",
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50.0),
                  child: TextFormField(
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      icon: Icon(FontAwesomeIcons.mobileAlt),
                      hintText: "Email",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Email Field cant be empty");
                      }
                      // elseif()
                      // {
                      //   return ("Re-Enter your Email");
                      // }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50.0),
                  child: TextFormField(
                    controller: passwordController,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Password Field cant be empty");
                      } else if (_password != _repsw) {
                        return ("Password and Re-Password should be match");
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _repsw = value;
                      });
                    },
                    decoration: const InputDecoration(
                      icon: Icon(FontAwesomeIcons.lock),
                      hintText: "Re-Password",
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
                    onTap: () => moveToHome( emailController.text,passwordController.text),
                    child: AnimatedContainer(
                       duration: const Duration(seconds: 0),
                      width: change ? 50.0 : 150.0,
                      height: 50.0,

                      alignment: Alignment.center,
                      child: change
                          ? const Icon(Icons.done)
                          : const Text(
                              "Signup",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
