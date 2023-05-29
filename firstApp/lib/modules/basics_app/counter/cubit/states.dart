import 'package:firstapp/modules/basics_app/counter/cubit/states.dart';

abstract class CounterStates {}

class CounterInitialState extends CounterStates{}

class CounterMiunsState extends CounterStates{
  final int counter ;

  CounterMiunsState(this.counter);
}

class CounterPlusState extends CounterStates{
  final int counter ;

  CounterPlusState(this.counter);
}