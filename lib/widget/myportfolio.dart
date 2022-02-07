
import 'package:flutter/material.dart';

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 40.0,
            child: Text("My Portfolio",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ))),
      ],
    );
  }
}