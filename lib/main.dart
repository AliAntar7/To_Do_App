import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/pages/add_task.dart';
import 'package:to_do_app/pages/schedule_page.dart';
import 'package:to_do_app/pages/splash_scrren.dart';
import 'package:to_do_app/shared/bloc/cubit.dart';
import 'package:to_do_app/shared/bloc/observer.dart';

void main()
{
  BlocOverrides.runZoned(
        () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: MaterialApp(
        initialRoute: 'splash',
        routes:
        {
          'splash' : (context) =>  SplashScreen(),
          'Home' : (context) =>  Home(),
          'AddTask' : (context) =>  AddTask(),
          'Schedule' : (context) => Schedule(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

