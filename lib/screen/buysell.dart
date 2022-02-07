// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, empty_catches, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_portfolio/function/buyshare.dart';
import 'package:mero_portfolio/function/sellShare.dart';
import 'package:mero_portfolio/widget/drawer.dart';
import 'package:mero_portfolio/widget/popupmenu.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:string_validator/string_validator.dart';
// import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class Buysell extends StatefulWidget {
  final name;
  final qty;
  final rate;

  const Buysell(
      {Key? key, required this.name, required this.rate, required this.qty})
      : super(key: key);

  @override
  State<Buysell> createState() => _BuysellState();
}

class _BuysellState extends State<Buysell> {
  var name="";
  var qty="";
  var total="";
  var rate="" ;
  bool isSwitched = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  //cancelfunction...............................
  cancel(BuildContext context) {
    _nameController.clear();
    _qtyController.clear();
    _rateController.clear();
  }

  //buySharefunction..........................................
  Future<void> buyShare(String name, String qty, String rate) async {
    
    try {
      var value = double.parse(qty);
    
      // var rate = double.parse(rate);
      final uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('BuyPShare')
          .doc(name);

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
            DocumentSnapshot snapshot =
                await transaction.get(documentReference);
            if (!snapshot.exists) {
              documentReference.set({'qty': value});
        
              // documentReference.set({'rate': rate});
              return true;
            }

            double newamt =
                (snapshot.data() as Map<String, dynamic>)['qty'] + value;
                 transaction.update(documentReference, {'qty': newamt});
            // double newrate =
            //     (snapshot.data() as Map<String, dynamic>)['rate']+rate; 
            // transaction.update(documentReference, {'rate': newrate});
            return newamt;
            
          })
          .then((value) => print("sucessful"))
          .catchError((error) => print("Failed to buy: $error"));
    } catch (e) {}
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          //Form...........................................
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                  ),

                  //Rolling switch
                  RollingSwitch.widget(
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    //right
                    rollingInfoRight: RollingWidgetInfo(
                      backgroundColor: Colors.blue,
                      text: Text('Buy'),
                    ),
                    //left
                    rollingInfoLeft: RollingWidgetInfo(
                      backgroundColor: Colors.red,
                      text: Text('Sell'),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),

                  //name
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty && !isUppercase(value)) {
                        return ("Please Enter Name of Stock");
                      }
                      if (!isUppercase(value)) {
                        return ("Please Enter in UPPERCASE");
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        value = name;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Symbol",
                      label: Text("Symbol"),
                    ),
                  ),
                  //qty
                  TextFormField(
                     keyboardType: TextInputType.number,
                    controller: _qtyController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Quantity");
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        value = qty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "0",
                      label: Text("Qty"),
                    ),
                  ),
                  //rate
                  TextFormField(
                     keyboardType: TextInputType.number,
                    controller: _rateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Rate");
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        value = rate;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "0.0",
                      label: Text("Rate"),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  //button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: isSwitched ? Colors.blue[100] : Colors.red,
                        borderRadius:
                            BorderRadius.circular(isSwitched ? 50 : 150),
                        child: InkWell(
                          onTap: isSwitched
                              ? () async {
                                  myShare(
                                      _nameController.text,
                                      _qtyController.text,
                                      _rateController.text);
                                     buyShare(
                                      _nameController.text,
                                      _qtyController.text,
                                      _rateController.text);
                                      addShare(
                                        _nameController.text,
                                      _qtyController.text,
                                      _rateController.text
                                      );
                                      
                                  if (_formkey.currentState!.validate()) {
                                    //    setState(() {
                                    //      this.total=totalinvest();
                                    // });
                                    // Navigator.pushNamed(context, "/history");

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: isSwitched
                                                ? Text(
                                                    "Successfully Brought",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.lightBlue))
                                                : Text("Successfully Sold",
                                                    style: TextStyle(
                                                        color: Colors.red))));
                                  }
                                }
                              : (){
                                sellShare(_nameController.text,_qtyController.text);
                                sellHistory(_nameController.text,_qtyController.text,_rateController.text);
                                 if (_formkey.currentState!.validate()) {
                                  //     setState(() {
                                  //       totalinvest();
                                  //  });
                                    Navigator.pushNamed(context, "/history");

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: isSwitched
                                                ? Text(
                                                    "Successfully Brought",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.lightBlue))
                                                : Text("Successfully Sold",
                                                    style: TextStyle(
                                                        color: Colors.red))));
                                  }
                              } ,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 0),
                            width: 100.0,
                            height: 50.0,
                            color:
                                isSwitched ? Colors.lightBlue[300] : Colors.red,
                            alignment: Alignment.center,
                            child: isSwitched
                                ? const Text(
                                    "Buy",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Sell",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      //Cancel.................
                      Material(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.circular(isSwitched ? 50 : 150),
                        child: InkWell(
                          onTap: () => cancel(context),
                          child: AnimatedContainer(
                              duration: const Duration(seconds: 0),
                              width: 100.0,
                              height: 50.0,
                              color: Colors.deepPurple,
                              alignment: Alignment.center,
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Text(total),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 String totalinvest()
    {
      double qty=double.parse(_qtyController.text);
       double rate=double.parse(_rateController.text);
        double totalrate=0;
       double totalqty=0;
        double totalprice=0;
        totalprice=qty* rate;
        totalqty=totalqty+qty;
        totalrate=totalrate+rate;
        double investamt=0;
        investamt=investamt+totalprice; 
        var total='You have brought for Rs $totalprice  and your total investment till  is $investamt';
        return  total;
    }
 
}
