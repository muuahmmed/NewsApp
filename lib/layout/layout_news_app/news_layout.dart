import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/layout/layout_news_app/cubit/cubit.dart';
import 'package:untitled5/layout/layout_news_app/cubit/states.dart';
import 'package:untitled5/modules/search/search.dart';
import 'package:untitled5/shared/components/components.dart';
import 'package:untitled5/shared/cubic/cubic.dart';

class NewsLayout extends StatelessWidget{
  const NewsLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:  (context,state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: ()
              {
                AppCubit.get(context).changeAppMode();
              },
                  icon: const Icon(
                      Icons.brightness_4_outlined),
              ),
              IconButton(onPressed: ()
              {
                navigateTo(context, Search());
              },
                icon: const Icon(
                    Icons.search),
              ),
            ],
            title: const Text(
              'News App',
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,

          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }

}