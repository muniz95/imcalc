import 'package:flutter/material.dart';
import 'package:imcalc/bloc/calculator_bloc.dart';
import 'package:imcalc/components/imc_component.dart';

class CalculatorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalculatorViewState();
}

class CalculatorViewState extends State<CalculatorView> with TickerProviderStateMixin {
  final _focus = FocusNode();
  CalculatorBloc _bloc;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _bloc = CalculatorBloc();
    _animationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
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
                    double animationValue = snapshot.data as double;
                    _animation = Tween(begin: animationValue, end: 0).animate(
                      CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
                    print(_animation.value.toString());
                    _animationController.forward();
                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (BuildContext context, Widget child) {
                        // return ImcComponent(bmi: snapshot.data as double);
                        return ImcComponent(bmi: double.tryParse(_animation.value.toString()));
                      }
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
            ]
          ),
        )
      ),
    );
  }
  
}