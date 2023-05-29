import 'package:firstapp/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:firstapp/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:firstapp/modules/todo_app/new_tsaks/new_tasks_screen.dart';
import 'package:firstapp/shared/cubit/states.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{

AppCubit() : super (AppInitialState());

static AppCubit get(context) => BlocProvider.of(context);

 int currentIndex = 0 ;

List<Widget> screens =[
  NewTasksScreen(),
  DoneTasksScreen(),
  ArchivedTasksScreen(),
];

List<String> appbar =[
  'New Tasks',
  'Done Tasks',
  'Archived Tasks',
];
late Database database;

List<Map> newtasks = [];
List<Map> donetasks = [];
List<Map> archivedtasks = [];
bool isBottomShow = false;
IconData fabIcon = Icons.edit ;
void changeIndex(int index){
  currentIndex = index ;
  emit(AppChangeBottomNavState());
}
void createDB () {
  openDatabase(
      'todo.db',
      version : 1 ,
      onCreate :(database , version){
        print('database created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date Text, time Text,status Text)').then((value){
          print('table created');
        }).catchError((error){
          print('error ,table created');
        });
      },
      onOpen:(database){
        getDataFromDB(database);
        print('database opened');

      }



  ).then((value) {
    database = value ;
    emit(AppCreateDBState());
  });
}
 insertDb({
  required String title ,
  required String time ,
  required String date ,
}) async {
   await database.transaction((txn) async{
    txn.rawInsert('INSERT INTO tasks(title , date , time , status) VALUES("$title","$date" ,"$time","new")').then((value) {
      print('$value insert successfully');
      emit(AppInsertDBState());
      getDataFromDB(database);
    }).catchError((error){
      print('insert unsuccessfully${error.toString()}');
    });
    return  null;
  });
}

void updateDB ({
  required String status ,
  required int id ,
}) async{
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id ]).then((value) {
        getDataFromDB(database);
        emit(AppUpdateDBState());

   });
}
void getDataFromDB(database){
  newtasks=[];
  donetasks=[];
  archivedtasks=[];
  emit(AppGetDBLoadingState());
   database.rawQuery('SELECT * FROM tasks').then((value){

     value.forEach((element) {
       if(element['status'] == 'new'){
         newtasks.add(element);
       }
       else if(element['status'] == 'done'){
         donetasks.add(element);
       }
       else {
         archivedtasks.add(element);
       }
     });
     emit(AppGetDBState());
   });

}
void changeBottomSheet({
  required bool isShow ,
  required IconData icon ,
}){
isBottomShow= isShow ;
fabIcon= icon ;
emit(AppChangeBottomSheetState());

}

void deleteDB ({
  required int id ,
}) async{
  database.rawDelete('DELETE FROM tasks WHERE id = ?',
      [id]).then((value) {
    getDataFromDB(database);
    emit(AppDeleteDBState());

  });
}
bool isDark = false ;

void changeTheme (){

      isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeThemeState());
    });

}
}