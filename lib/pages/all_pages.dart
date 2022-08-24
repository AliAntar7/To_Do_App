import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/bloc/cubit.dart';
import 'package:to_do_app/shared/bloc/states.dart';
import 'package:to_do_app/shared/components/item_task.dart';

class All extends StatelessWidget {
  const All({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit ,AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        AppCubit cubit = AppCubit.get(context);
        List<Map> tasks = AppCubit.get(context).allTasks;
        return ListView.separated(
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
