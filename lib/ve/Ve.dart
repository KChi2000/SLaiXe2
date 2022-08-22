import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Ve extends StatefulWidget {
  const Ve({Key key}) : super(key: key);

  @override
  State<Ve> createState() => _VeState();
}

class _VeState extends State<Ve> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
          ),
           BoxShadow(
            color: Colors.white,
            spreadRadius: -1.0,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Center(child: Text('dddd')),
      )),
    );
  }
}