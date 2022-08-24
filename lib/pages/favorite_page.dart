import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/bloc/cubit.dart';
import 'package:to_do_app/shared/bloc/states.dart';
import 'package:to_do_app/shared/components/item_task.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context,AppStates state) {},
        builder: (BuildContext context,AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          List<Map> tasks = AppCubit.get(context).favTasks;
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => ItemTask(task: tasks [index],isDone: tasks[index]['comp']==1?true:false,isFav: tasks[index]['fav']==1?true:false,),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
            itemCount: tasks.length,
          );
        },
    );
  }
}