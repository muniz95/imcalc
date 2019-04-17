import 'package:flutter/material.dart';

class ImcComponent extends StatelessWidget {
  ImcComponent({this.imc});

  final double imc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: AlignmentDirectional.center,
        width: 100,
        height: 50,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(
          imc.toStringAsFixed(2), 
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}