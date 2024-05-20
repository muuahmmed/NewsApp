import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled5/layout/layout_news_app/cubit/states.dart';
import 'package:untitled5/shared/cubic/states.dart';
import 'package:untitled5/shared/network/local/cashe_helper.dart';
import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';


class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  var currentIndex = 0;
  
  List<String> titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  List<Widget> screens =
  [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  List<Map> tasks =[];
  var database ;
  void createDatabase()
  {
    database =  openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version)
      {
        database.execute ('CREATE TABLE tasks '
            '(id INTEGER PRIMARY KEY, title TEXT, date TEXT,status TEXT, time TEXT)').then((value){
          print('database is created');
        }).catchError((error){
          print('error when creating database');
        });
      },
      onOpen: (database)
      {
        getDatabaseFromDatabase(database).then((value)
        {
          tasks = value;
          print('tasks $tasks');
          emit(AppGetDatabaseState());
        });
        print('database is opened');
      },
    ).then((value)
        {
          database = value;
          emit(AppCreateDatabaseState());
        }
    );
  }
  
  insertToDatabase({required String title,required String time, required String date})async
  {
    await database.transaction((txn)
    {
      txn.rawInsert(
          'Insert INTO tasks (time, title, date, status) VALUES("$time", "$title", "$date", "new")'
      ).then((value){
        print('$value  inserted to Tasks successfully');
        emit(AppInsertDatabaseState());

        getDatabaseFromDatabase(database).then((value)
        {
          tasks = value;
          print('tasks $tasks');
          emit(AppGetDatabaseState());
        });
      }).catchError((error)
      {
        print('error when inserting to tasks ${error.toString()}');
        return null;
      });
    }
    );
  }

  Future<List<Map>> getDatabaseFromDatabase(database)async
  {
    emit(AppGetDatabaseLoadingStat());
    return await database.rawQuery('SELECT * FROM tasks');
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetStates({ required bool isShow,required IconData icon})
  {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
  bool isDark = false;
  ThemeMode appMode = ThemeMode.dark;
  void changeAppMode({ bool? fromShared})
  {
    if (fromShared !=null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    }else{
      isDark = !isDark;

      CasheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
        emit(AppChangeModeState());
      });
      emit(AppChangeModeState() );
    }

  }
}

