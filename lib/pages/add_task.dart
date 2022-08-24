import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/shared/bloc/cubit.dart';
import 'package:to_do_app/shared/bloc/states.dart';
import 'package:to_do_app/shared/components/input_field.dart';

class AddTask extends StatelessWidget {
   AddTask({Key? key}) : super(key: key);

final titleController = TextEditingController();
final timeController = TextEditingController();
final dateController = TextEditingController();
final remindController = TextEditingController();
final repeatController = TextEditingController();
final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Add Task',
            ),
            backgroundColor: Colors.indigo,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children:
                    [
                      const SizedBox(
                        height: 10,
                      ),
                      InputField(
                        title: 'Title',
                        hint: 'Task Title',
                        controller: titleController,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return'must not be empty';
                          }
                          return null ;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InputField(
                              title: 'Time',
                              hint: 'Task Time',
                              controller: timeController,
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return'must not be empty';
                                }
                                return null ;
                              },
                              widget: IconButton(
                                icon: Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.indigo[300],
                                ),
                                onPressed: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text = value!.format(context).toString();
                                    print(value.format(context));
                                  });
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InputField(
                              title: 'Date',
                              hint: 'Task Date',
                              controller: dateController,
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return'must not be empty';
                                }
                                return null ;
                              },
                              widget: IconButton(
                                icon: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.indigo[300],
                                ),
                                onPressed: ()
                                {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                  ).then((value) {
                                    final DateFormat formatter = DateFormat('dd-MM-yyyy');
                                    dateController.text = formatter.format(value!);
                                    print(value.toString());
                                  });
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InputField(
                        title: 'Remind',
                        hint: 'Remind Time',
                        controller: remindController,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return'must not be empty';
                          }
                          return null ;
                        },
                        widget:DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.indigo,
                            ),
                            buttonHeight: 100,
                            buttonWidth: 220,
                            items: const [
                              DropdownMenuItem(value: "before 5 min",child: Text('Remind me before 5 min'),),
                              DropdownMenuItem(value: "before 20 min",child: Text('Remind me before 20 min'),),
                              DropdownMenuItem(value: "before 1 hour",child: Text('Remind me before 1 hour'),),
                              DropdownMenuItem(value: "before 1 day",child: Text('Remind me before 1 day'),),
                            ],
                            onChanged: (String? value) {
                              remindController.text = value! ;
                            },
                          ),
                        ),
                      ),
                      InputField(
                        title: 'Repeat',
                        hint: 'Repeat Time',
                        controller: repeatController,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return'must not be empty';
                          }
                          return null ;
                        },
                        widget:DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.indigo,
                            ),
                            buttonHeight: 100,
                            buttonWidth: 220,
                            items: const [
                              DropdownMenuItem(value: "None",child: Text('None'),),
                              DropdownMenuItem(value: "Daily",child: Text('Daily'),),
                              DropdownMenuItem(value: "Weekly",child: Text('Weekly'),),
                            ],
                            onChanged: (String? value) {
                              repeatController.text = value! ;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MaterialButton(
                          onPressed: ()
                          {
                            if(formKey.currentState!.validate())
                            {
                              cubit.insertToDatabase(
                                title: titleController.text,
                                time: timeController.text,
                                date: dateController.text,
                                remind: remindController.text,
                                repeat: repeatController.text,
                              );
                              Navigator.pop(context);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)
                          ),
                          color: Colors.indigo[400],
                          height: 55,
                          minWidth: double.infinity,
                          child: const Text(
                            'Create Task',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

