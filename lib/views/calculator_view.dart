import 'package:flutter/material.dart';
import 'package:imcalc/bloc/calculator_bloc.dart';
import 'package:imcalc/components/imc_component.dart';

class CalculatorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalculatorViewState();
}

class CalculatorViewState extends State<CalculatorView> {
  final _focus = FocusNode();
  final _weightTextController = TextEditingController();
  final _heightTextController = TextEditingController();
  CalculatorBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CalculatorBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "IMCalc",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.cyan,
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
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _weightTextController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.fitness_center),
                      labelText: "Weight",
                    ),
                    cursorRadius: Radius.circular(15),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true
                    ),
                    style: TextStyle(
                      color: Colors.cyan
                    ),
                    onChanged: (value) {
                      _bloc.setWeight(double.tryParse(value));
                    },
                    onSubmitted: (value) => FocusScope.of(context).requestFocus(_focus),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 250,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _heightTextController,
                    focusNode: _focus,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.vertical_align_top),
                      labelText: "Height (cm)",
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true
                    ),
                    style: TextStyle(
                      color: Colors.cyan
                    ),
                    onChanged: (value) {
                      _bloc.setHeight(double.tryParse(value));
                    },
                    onSubmitted: (_) => _bloc.calculate(),
                  ),
                ),
              ),
              StreamBuilder<double>(
                initialData: 0.0,
                stream: _bloc.imc,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return new MyHomePage(snapshot.data as double);
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
              FlatButton(
                child: Text("Reset"),
                onPressed: _reset,
              ),
            ]
          ),
        )
      ),
    );
  }

  _reset() {
    _weightTextController.clear();
    _heightTextController.clear();
    _bloc.reset();
  }
}