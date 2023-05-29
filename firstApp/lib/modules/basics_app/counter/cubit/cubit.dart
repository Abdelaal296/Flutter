import 'package:bloc/bloc.dart';
import 'package:firstapp/modules/basics_app/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit():super(CounterInitialState());
  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1 ;
  void miuns(){
    counter--;
    emit(CounterMiunsState(counter));
  }
  void plus(){
    counter++;
    emit(CounterPlusState(counter));
  }
}