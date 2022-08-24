import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/shared/bloc/states.dart';


class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super (AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  late Database database ;
  DateTime today = DateTime.now();
  List<Map>  allTasks = [];
  List<Map>  compTasks = [];
  List<Map>  unCompTasks = [];
  List<Map>  favTasks = [];
  List<Map>  schedule= [];


  void createDatabase()
  {
    openDatabase(
      'todo_app2.db',
      version: 1,
      onCreate: (database , version)
      {
        print('database created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT , remind TEXT , repeat TEXT , comp BOOLEAN, fav BOOLEAN)').then((value)
        {
          print('table created');
        }).catchError((error)
        {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database)
      {
        getDataFromDatabase(database);

        print('database opened');
      },
    ).then((value)
    {
      database = value ;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required title,
    required time,
    required date,
    required remind,
    required repeat,
  }) async
  {
    await database.transaction((txn)
    {
      txn.rawInsert(
        'INSERT INTO tasks(title, date, time, remind, repeat, comp, fav) VALUES("$title", "$date", "$time", "$remind", "$repeat", ${false}, ${false})',
      ).then((value)
      {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error)
      {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return Future.value() ;
    });
  }

  void getDataFromDatabase(database) async
  {
    allTasks = [];
    compTasks = [];
    unCompTasks = [];
    favTasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      allTasks = value ;
      print(allTasks);

      value.forEach((element)
      {
        if(element['comp'] == 1 )
        {
          compTasks.add(element);
        }
        else if(element['comp'] == 0 )
        {
          unCompTasks.add(element);
        }


        if(element['fav'] == 1 )
        {
          favTasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });
  }


  void deleteData({
    required int id,
  })async
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?', [id],
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  void updateTIMELINE(DateTime date){
    schedule=allTasks.where((h1) =>h1['date']==formatter.format(date)).toList();
    today = date;
    print('to day is $today ');
    emit(AppUpdateSelctedDayState());
    emit(AppGetDatabaseState());
  }

  void compTaskState ({
    required bool comp ,
    required int id ,
  })
  {
    database.rawUpdate(
        'UPDATE tasks SET comp = ? WHERE id = ?' , [comp , id] ).then((value) {

      emit(AppUpdateDatabaseState());
      getDataFromDatabase(database);

    }
    );
  }

  void favState ({
    required bool isFav ,
    required int id ,
  })
  {
    database.rawUpdate(
        'UPDATE tasks SET fav = ? WHERE id = ?' , [isFav , id] ).then((value) {

      emit(AppFavState());
      getDataFromDatabase(database);
    }
    );
  }


}