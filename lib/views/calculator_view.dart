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
        title: Text("IMCalc"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  cursorRadius: Radius.circular(15),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true
                  ),
                  onChanged: (value) {
                    _bloc.setWeight(double.tryParse(value));
                  },
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true
                  ),
                  onChanged: (value) {
                    _bloc.setHeight(double.tryParse(value));
                  },
                ),
                padding: EdgeInsets.all(10),
              ),
              StreamBuilder<double>(
                initialData: 0.0,
                stream: _bloc.imc,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData ? ImcComponent(imc: snapshot.data as double) : CircularProgressIndicator();
                  }
              )
            ]
          ),
        )
      ),
    );
  }
  
}