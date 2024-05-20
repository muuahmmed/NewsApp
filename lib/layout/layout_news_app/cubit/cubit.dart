import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/layout/layout_news_app/cubit/states.dart';

import '../../../modules/business/business_screen.dart';
import '../../../modules/science/science_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex =0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon:Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon:Icon(
        Icons.sports_sharp,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon:Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),

  ];

  void changeBottomNavBar(int index)
  {
    if(index==1)
      {
        getSports();
      }
    if(index==2)
      {
        getScience();
      }
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business =[];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'catogory':'business',
        'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
      
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error: error.toString()));

    });
  }

  List<dynamic> Science =[];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if (Science.isEmpty)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'catogory':'Science',
          'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        Science = value.data['articles'];
        print(Science[0]['title']);
        emit(NewsGetSciencesuccessState());

      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error: error.toString()));

      });
    }
    else
    {
      emit(NewsGetSportsSuccessState());
    }
  }


  List<dynamic> Sports =[];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if (Sports.isEmpty)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'catogory':'sports',
            'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
          },
        ).then((value) {
          //print(value.data['articles'][0]['title']);
          Sports = value.data['articles'];
          print(Sports[0]['title']);
          emit(NewsGetSportsSuccessState());

        }).catchError((error) {
          print(error.toString());
          emit(NewsGetSportsErrorState(error: error.toString()));

        });
      }
    else
      {
        emit(NewsGetSportsSuccessState());
      }
  }

  List<dynamic> search =[];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    //search =[];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'catogory':'sports',
        'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error: error.toString()));
    });
  }

}