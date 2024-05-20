import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/layout/layout_news_app/cubit/cubit.dart';
import 'package:untitled5/layout/layout_news_app/cubit/states.dart';
import 'package:untitled5/shared/components/components.dart';

class Search extends StatelessWidget{
  var searchController = TextEditingController();

  Search({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, NewsStates state) {  },
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: articleBuilder(list, context, isSearch: true)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  onTap: ()
                  {
                  },
                  validator:( value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'title must not be empty';
                    }
                    return null;
                  },
                  keyboardType:TextInputType.text ,
                  onChanged: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  decoration: const InputDecoration(
                    label: Text('Search'),
                    prefixIcon:Icon(Icons.search) ,

                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}