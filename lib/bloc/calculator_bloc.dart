import 'package:rxdart/rxdart.dart';

class CalculatorBloc {
  BehaviorSubject<double> _weight = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<double> _height = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<double> _imc = BehaviorSubject<double>.seeded(0.0);

  Stream<double> get weight => _weight.stream;
  Stream<double> get height => _height.stream;
  Stream<double> get imc => _imc.stream;

  void setWeight(double weight) {
    _weight.add(weight);
  }

  void setHeight(double height) {
    _height.add(height);
  }

  void reset() {
    _imc.add(0);
  }

  void dispose() {
    _weight.close();
    _height.close();
    _imc.close();
  }

  void calculate() {
    _imc.add(_weight.value / (_height.value * _height.value) * 10000);
  }
}