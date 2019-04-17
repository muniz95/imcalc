import 'package:flutter/material.dart';
import 'package:imcalc/bloc/calculator_bloc.dart';
import 'package:imcalc/components/imc_component.dart';

class CalculatorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalculatorViewState();
}

class CalculatorViewState extends State<CalculatorView> {
  CalculatorBloc _bloc;

  @override
  void initState() {
    _bloc = CalculatorBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "IMCalc",
          style: TextStyle(
            color: Colors.deepOrange
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: 250,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.deepOrange,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.fitness_center),
                      labelText: "Weight",
                    ),
                    cursorRadius: Radius.circular(15),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true
                    ),
                    onChanged: (value) {
                      _bloc.setWeight(double.tryParse(value));
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 250,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.deepOrange,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vertical_align_top),
                      labelText: "Height (cm)",
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true
                    ),
                    onChanged: (value) {
                      _bloc.setHeight(double.tryParse(value));
                    },
                  ),
                ),
              ),
              StreamBuilder<double>(
                initialData: 0.0,
                stream: _bloc.imc,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData 
                      ? ImcComponent(bmi: snapshot.data as double)
                      : CircularProgressIndicator();
                  }
              )
            ]
          ),
        )
      ),
    );
  }
  
}