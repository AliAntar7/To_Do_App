import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/pages/all_pages.dart';
import 'package:to_do_app/pages/completed_page.dart';
import 'package:to_do_app/pages/favorite_page.dart';
import 'package:to_do_app/pages/uncompleted_page.dart';
import 'package:to_do_app/shared/bloc/cubit.dart';
import 'package:to_do_app/shared/bloc/states.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return DefaultTabController(
            initialIndex: 0,
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Board',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions:  [
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, 'Schedule');
                      },
                      child: const Icon(
                        Icons.date_range_outlined,
                        color: Colors.indigo,
                        size: 27,
                      ),
                    ),
                  ),
                ],
                bottom: const TabBar(
                  unselectedLabelColor: Colors.black45,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.indigo,
                  isScrollable: true,
                  indicatorWeight: 3,
                  labelColor: Colors.black87,
                  labelStyle: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    Tab(text: 'All',),
                    Tab(text: 'Completed',),
                    Tab(text: 'Uncompleted',),
                    Tab(text: 'Favorite',),
                  ],
                ),
              ),
              body: const TabBarView(
                  children:
                  [
                    All(),
                    Completed(),
                    Uncompleted(),
                    Favourite(),
                  ]
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.indigo,
                onPressed: () {
                  Navigator.pushNamed(context, 'AddTask');
                },
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          );
        }
    );
  }
}


