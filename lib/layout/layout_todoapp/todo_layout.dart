import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/shared/cubic/cubic.dart';
import 'package:untitled5/shared/cubic/states.dart';


class HomeLayout extends StatelessWidget
{


  /*Future <String> getName()async
  {
    return 'iammuhammedmagdi';
  }*/
  /*
  void initState()
  {
    super.initState();
    createDatabase();
  }
  */

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(BuildContext context)=> AppCubit()..createDatabase(),

      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState)
          {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                 cubit.titles[cubit.currentIndex]
              ),
            ),
            body: cubit.tasks.isEmpty ? const Center(child: CircularProgressIndicator()) : cubit.screens[cubit.currentIndex],

            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.isBottomSheetShown)
                {
                  if (formKey.currentState!.validate())
                  {
                    cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                    /*insertToDatabase(date:dateController.text ,
                        time: timeController.text,
                        title:titleController.text ).then((value)
                    {
                      getDataFromDatabase(database).then((value))
                      {
                        Navigator.pop(context);
                        isBottomSheetShown = false;
                        /*setState(() {
                      fabIcon = Icons.edit;
                    });*/
                      }
                    });*/
                  }
                }
                else
                {
                  scaffoldKey.currentState?.showBottomSheet(
                        (context) =>Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: titleController,
                                validator:(String? value)
                                {
                                  if (value!.isEmpty)
                                  {
                                    return 'title must not be empty';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  label: Text("task title"),
                                  prefixIcon: Icon(Icons.title_outlined),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: timeController,
                                onTap: ()
                                {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value)
                                  {
                                    timeController.text = (value!.format(context).toString());
                                    print(value.format(context));
                                  });
                                  print('timing changed');
                                },
                                validator:(String?value){
                                  if (value!.isEmpty)
                                  {
                                    return 'time must not be empty';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  label: Text("task time"),
                                  prefixIcon: Icon(Icons.watch_later_outlined),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: dateController,
                                onTap: ()
                                {
                                  showDatePicker(context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2040-12-31'),
                                  ).then(( value)
                                  {
                                    print(value.toString());
                                  });
                                },
                                validator:(String?value){
                                  if (value!.isEmpty)
                                  {
                                    return 'date must not be empty';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.date_range_sharp),
                                  label: Text("task Date"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    elevation: 25.0,
                  ).closed.then((value)
                  {
                    cubit.changeBottomSheetStates(isShow: false, icon:Icons.edit );
                  });
                  cubit.changeBottomSheetStates(isShow: true, icon: Icons.add);
                }
              },
              child:  Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
                /*setState(() {
                currentIndex = index;
              });*/
              },
              items:
              const [
                BottomNavigationBarItem(icon: Icon(Icons.menu,), label: 'New'),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline),label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }

}
