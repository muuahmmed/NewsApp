import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layout_news_app/cubit/cubit.dart';
import '../../layout/layout_news_app/cubit/states.dart';
import '../../shared/components/components.dart';

class ScienceScreen extends StatelessWidget
{

  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state) {},
      builder: (context,state)
      {
        var list =  NewsCubit.get(context).Science;

        return  articleBuilder(list,context);
      },


    );
  }

}