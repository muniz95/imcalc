import 'package:flutter/material.dart';

class ImcComponent extends StatelessWidget {
  ImcComponent({this.bmi});

  final double bmi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
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
              bmi.toStringAsFixed(2), 
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),
        Text(
          _feedback(bmi),
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 22
          ),
        ),
      ],
    );
  }

  String _feedback(double bmi) {
    if (bmi >= 35) {
      return "Obese";
    } else if (bmi < 35 && bmi >= 30) {
      return "Fat";
    } else if (bmi < 30 && bmi >= 25) {
      return "Overweight";
    } else if (bmi < 25 && bmi >= 20) {
      return "Normal weight";
    } else {
      return "Underweight";
    }
  }
}