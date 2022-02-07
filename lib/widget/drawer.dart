// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  // const MyDrawer({ Key? key }) : super(key: key);
final useremail=FirebaseAuth.instance.currentUser!.email;
  var imgurl =
      "https://i.pinimg.com/564x/33/75/f5/3375f51742dd5b2f02fdafd87fd382a1.jpg";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Drawer(
        child: Container(
          color: Colors.deepPurple,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  curve: Curves.bounceOut,
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: UserAccountsDrawerHeader(
                      margin: EdgeInsets.zero,
                       accountName: Text("Suprim Shakya"),
                      accountEmail: Text("$useremail"),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCDA9P_S2I7Yil9o_ZjpEgeLy7N1MGkrFDkeyAIBXl7Mp6lwLT1E26x8Yh53sGewAKxlM&usqp=CAU"),
                        radius: (30.0),
                      ),
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.deepPurpleAccent,
                      onTap: (){
                        Navigator.pushNamed(context, "/dashboard");
                      },
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.home,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Dashboard",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    // InkWell(
                    //    splashColor: Colors.yellow,
                    //   onTap: ()
                    //   {
                    //     Navigator.pushNamed(context, "/profile");
                    //   },
                    //   child: ListTile(
                    //     leading: Icon(
                    //       FontAwesomeIcons.user,
                    //       color: Colors.white,
                    //     ),
                    //     title: Text("Profile",
                    //         style: TextStyle(color: Colors.white)),
                    //   ),
                    // ),
                    //   InkWell(
                    //    splashColor: Colors.yellow,
                    //   onTap: ()
                    //   {
                    //     Navigator.pushNamed(context, "/myshare");
                    //   },
                    //   child: ListTile(
                    //     leading: Icon(
                    //       FontAwesomeIcons.database,
                    //       color: Colors.white,
                    //     ),
                    //     title: Text("My Share",
                    //         style: TextStyle(color: Colors.white)),
                    //   ),
                    // ),
                    //history
                      InkWell(
                       splashColor: Colors.yellow,
                      onTap: ()
                      {
                        Navigator.pushNamed(context, "/history");
                      },
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.history,
                          color: Colors.white,
                        ),
                        title: Text("History",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    //buysell
                        InkWell(
                       splashColor: Colors.yellow,
                      onTap: ()
                      {
                        Navigator.pushNamed(context, "/buysell");
                      },
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.database,
                          color: Colors.white,
                        ),
                        title: Text("Buy/Sell",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
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
