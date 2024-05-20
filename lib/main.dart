import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled5/network/remote/dio_helper.dart';
import 'package:untitled5/shared/bloc_observer.dart';
import 'package:untitled5/shared/cubic/cubic.dart';
import 'package:untitled5/shared/cubic/states.dart';
import 'package:untitled5/shared/network/local/cashe_helper.dart';
import 'layout/layout_news_app/cubit/cubit.dart';
import 'layout/layout_news_app/news_layout.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper.init();
  Bloc.observer = const SimpleBlocObserver();
  bool? isDark = CasheHelper.getBoolean(key: 'isDark');
  runApp(   MyApp(isDark!));
}
class MyApp extends StatelessWidget{
  final bool isDark;
  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
  return   MultiBlocProvider(
    providers: 
    [
      BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience(),),
      BlocProvider(create:(BuildContext context) =>AppCubit()..changeAppMode(
    fromShared: isDark,
    ),)
    ],
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return MaterialApp(
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange) ,
            scaffoldBackgroundColor: HexColor('333739'),
            appBarTheme:  AppBarTheme(
              titleSpacing:20.0,
              iconTheme: const IconThemeData(color: Colors.white),
              titleTextStyle: const TextStyle(

                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor:HexColor('333739'),
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: HexColor('333739'),
              elevation: 0.0,
            ),
            bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                elevation: 30.0
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white
              ),
            ),
          ),
          themeMode:AppCubit.get(context).isDark?ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black
              ),
            ),
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange) ,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              titleSpacing:20.0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 30.0
            ) ,
          ),
          home:const NewsLayout(),
          debugShowCheckedModeBanner: false,
        );
      },
    ),
  );
  }

}