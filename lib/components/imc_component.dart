import 'package:flutter/material.dart';

class ImcComponent extends StatelessWidget {
  ImcComponent({this.bmi});

  final double bmi;

  @override
  Widget build(BuildContext context) {
    Color _mainColor = _getCardColor(bmi);
    String _feedback = _getFeedback(bmi);
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            alignment: AlignmentDirectional.center,
            width: 100,
            height: 50,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: _mainColor,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Text(
              bmi == null ? "---" : bmi.toStringAsFixed(2), 
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),
        Text(
          _feedback,
          style: TextStyle(
            color: _mainColor,
            fontSize: 22
          ),
        ),
      ],
    );
  }

  Color _getCardColor(double bmi) {
    switch (_getLevel(bmi)) {
      case 5:
        return Colors.red;
        break;
      case 4:
        return Colors.orange;
        break;
      case 3:
        return Colors.amber;
        break;
      case 2:
        return Colors.green;
        break;
      case 1:
        return Colors.teal;
        break;
      default:
        return Colors.black;
    }
  }

  String _getFeedback(double bmi) {
    switch (_getLevel(bmi)) {
      case 5:
        return "Obese";
        break;
      case 4:
        return "Fat";
        break;
      case 3:
        return "Overweight";
        break;
      case 2:
        return "Normal weight";
        break;
      case 1:
        return "Underweight";
        break;
      default:
        return "";
    }
  }

  int _getLevel(double bmi) {
    if (bmi != null) {
      if (bmi.isFinite) {
        if (bmi >= 35) {
          return 5;
        } else if (bmi < 35 && bmi >= 30) {
          return 4;
        } else if (bmi < 30 && bmi >= 25) {
          return 3;
        } else if (bmi < 25 && bmi >= 20) {
          return 2;
        } else if (bmi < 20 && bmi > 0) {
          return 1;
        }
      }
    }
    return 0;
  }
}