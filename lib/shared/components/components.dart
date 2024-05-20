import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../modules/web_view/web_view_screen.dart';


Widget buildTaskItem(Map model,context) =>  Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40,
        child: Text(
            '${model['time']},',
                ),
      ),
      const SizedBox(width: 20.0,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${model['title']},',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),),
          Text('${model['date']},',
            style: const TextStyle(
              color: Colors.grey,
            ),),
        ],
      ),
    ],
  ),
);

Widget buildArticleItem(article,context) =>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(
      article['url']
    ),);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image:  DecorationImage(
                image: NetworkImage(
                  '${article['urlToImage']}',
                ),
                fit: BoxFit.cover
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 120,
            child:  Column(
              mainAxisSize:MainAxisSize.min ,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
  
                  child: Text(
                    '${article['title']}',
                    style:  Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
  
                )
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider() =>const Padding(
  padding: EdgeInsets.all(20.0),
    child: Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
      ),
    ],
  ),
);

Widget articleBuilder(list,context,{isSearch = false}) =>ConditionalBuilder(
    condition: list.length>0,
    builder: (context)=> ListView.separated(
      physics:const BouncingScrollPhysics() ,
      itemBuilder: (context,index)=>buildArticleItem(list[index],context),
      itemCount: 10,
      separatorBuilder:
          (BuildContext context, int index)=> myDivider(),),
    fallback:  (context)=>isSearch ? Container(): const Center(child: CircularProgressIndicator()));

void navigateTo(context,widget)=>Navigator.push(context, MaterialPageRoute(
  builder:(context)=>widget,
));