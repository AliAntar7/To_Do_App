import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/shared/bloc/cubit.dart';
import 'package:to_do_app/shared/bloc/states.dart';
import 'package:to_do_app/shared/components/item_task.dart';

class Schedule extends StatelessWidget {

  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (BuildContext context,AppStates state) {},
      builder: (BuildContext context,AppStates state) {
        List<Map> tasks = AppCubit.get(context).schedule;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded , size: 20, color: Colors.white,),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Schedule',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              DatePicker(

                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                dateTextStyle: TextStyle(
                  fontSize: 20.0,
                ),
                selectionColor: Colors.indigo,
                width: 50.0,
                height: 75.0,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  AppCubit.get(context).updateTIMELINE(date);
                },
              ),
              Container(
                padding: EdgeInsets.all(15),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.EEEE().format(AppCubit.get(context).today),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18)
                      ,),
                    Text(
                      DateFormat.yMMMd().format(AppCubit.get(context).today),
                      style: const TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ],
                ),

              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => ItemTask(task: tasks [index],isDone: tasks[index]['comp']==1?true:false,isFav: tasks[index]['fav']==1?true:false,),
                separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                itemCount: tasks.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
