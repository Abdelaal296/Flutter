import 'dart:ffi';

import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/cubit/cubit.dart';
import 'package:firstapp/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firstapp/shared/components/constants.dart';


class HomeLayout extends StatelessWidget {


  var scafoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state) {
          if(state is AppInsertDBState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context,AppStates state) {
          AppCubit cubit =AppCubit.get(context);
          return Scaffold(
            key: scafoldKey,
            appBar: AppBar(
              title: Text(
                cubit.appbar[cubit.currentIndex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.isBottomShow){
                  if(formKey.currentState!.validate()) {
                    cubit.insertDb(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                    // insertDb(
                    //   title: titleController.text,
                    //   time: timeController.text,
                    //   date: dateController.text,
                    // ).then((value){
                    //   Navigator.pop(context);
                    //   isBottomShow = false;
                    //   // setState(() {
                    //   //   fabIcon = Icons.edit;
                    //   // });
                    // });
                  }
                }
                else {
                  scafoldKey.currentState!.showBottomSheet((context) =>
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defualtFormField(
                                controller:titleController ,
                                type: TextInputType.text,
                                validate: (String? value){
                                  if(value!.isEmpty){
                                    return 'title required';
                                  }
                                  return null ;
                                },
                                label: 'Task Title',
                                prefix: Icons.title,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defualtFormField(
                                controller:timeController ,
                                type: TextInputType.datetime,
                                validate: (String? value){
                                  if(value!.isEmpty){
                                    return 'time required';
                                  }
                                  return null ;
                                },
                                label: 'Task Time',
                                prefix: Icons.watch_later_outlined,
                                onTap: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value){
                                    timeController.text = value!.format(context);

                                  });
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defualtFormField(
                                controller:dateController ,
                                type: TextInputType.datetime,
                                validate: (String? value){
                                  if(value!.isEmpty){
                                    return 'date required';
                                  }
                                  return null ;
                                },
                                label: 'Task Date',
                                prefix: Icons.calendar_today,
                                onTap: (){
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-06-09'),
                                  ).then((value) {
                                    dateController.text =DateFormat.yMMMd().format(value!);

                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    elevation: 20.0,
                  ).closed.then((value){
                   cubit.changeBottomSheet(isShow: false, icon: Icons.edit,);
                  });
                  cubit.changeBottomSheet(isShow: true, icon: Icons.add,);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'archived',
                ),
              ],
            ),
            body: state is! AppGetDBLoadingState? cubit.screens[cubit.currentIndex] : Center(child: CircularProgressIndicator()) ,
          );
        },

      ),
    );
  }



}


