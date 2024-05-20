import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/shared/cubic/cubic.dart';
import 'package:untitled5/shared/cubic/states.dart';

import '../../shared/components/components.dart';


class NewTasksScreen extends StatelessWidget{

  const NewTasksScreen({super.key});


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state) {
        var tasks = AppCubit.get(context).tasks;

        return ListView.separated(itemBuilder: (context,index) => buildTaskItem(tasks[index],context) ,
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: tasks.length,);
      },

    ) ;
  }

}
