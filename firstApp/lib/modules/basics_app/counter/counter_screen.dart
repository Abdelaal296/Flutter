import 'package:firstapp/modules/basics_app/counter/cubit/cubit.dart';
import 'package:firstapp/modules/basics_app/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (BuildContext context,CounterStates state){
          if (state is CounterMiunsState){
            print('miuns state ${state.counter}');
          }
          if (state is CounterPlusState){
            print('plus state ${state.counter}');
          }
        },
        builder:  (BuildContext context,CounterStates state){
          return  Scaffold(
            appBar: AppBar(
              title: Text(
                  'Counter'
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed:(){
                      CounterCubit.get(context).miuns();
                    },
                    child: Text(
                      'Miuns',
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  TextButton(
                    onPressed:(){
                      CounterCubit.get(context).plus();

                    },
                    child: Text(
                      'Plus',
                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }

}


