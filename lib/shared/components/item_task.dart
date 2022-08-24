import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/bloc/cubit.dart';
import 'package:to_do_app/shared/bloc/states.dart';

class ItemTask extends StatefulWidget {

  Map task ;
  bool? isDone;
  bool? isFav;
  ItemTask({Key? key, required this.task, this.isDone=false, this.isFav=false,}) : super(key: key);

  @override
  State<ItemTask> createState() => _ItemTaskState();
}

class _ItemTaskState extends State<ItemTask> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (BuildContext context,AppStates state) {},
      builder: (BuildContext context,AppStates state){
        return Container(
          width: double.infinity,
          height: 100.0,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              const SizedBox(
                width:5,
              ),
              InkWell(
                onTap: ()
                {
                  setState((){
                    widget.isDone =! widget.isDone!;
                  });
                  widget.isDone == true ? AppCubit.get(context).compTaskState(comp: true, id: widget.task['id'],) : AppCubit.get(context).compTaskState(comp: false, id: widget.task['id'],);
                },
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: widget.isDone == true? Colors.white : null,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: widget.isDone == true? Icon(
                    Icons.check ,
                    color: Colors.indigo,
                    size: 28.0,
                  ) : Container(),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${widget.task['title']}',
                    style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children:
                    [
                      Text(
                        '${widget.task['time']}',
                        style:TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${widget.task['date']}',
                        style:TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).deleteData(id: widget.task['id'],);
                },
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: ()
                {
                  setState(() {
                    widget.isFav =! widget.isFav! ;
                  });
                  widget.isFav== true ? AppCubit.get(context).favState(isFav: true, id: widget.task['id']) : AppCubit.get(context).favState(isFav: false, id: widget.task['id'],);
                },
                icon:  widget.isFav == true? Icon(
                  Icons.favorite ,
                  color: Colors.white,
                ) : Icon(
                  Icons.favorite_border_outlined ,
                  color: Colors.white,
                ),
              ),
              // PopupMenuButton(
              //     icon: const Icon(
              //       Icons.more_vert,
              //       color: Colors.white,
              //     ),
              //     itemBuilder: (context) =>
              //     [
              //       PopupMenuItem(
              //         enabled: false,
              //         child: Text(
              //           'remind : ${widget.task['remind']}',
              //          ),
              //     ),
              //       PopupMenuItem(
              //         enabled: false,
              //         child: Text(
              //           'repeat : ${widget.task['repeat']}',
              //         ),
              //       ),
              //     ]
              // ),
            ],
          ),
        );
      },
    );
  }
}
