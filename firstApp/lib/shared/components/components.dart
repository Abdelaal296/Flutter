import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/shop_app/cubit/cubit.dart';
import 'package:firstapp/modules/news_app/web_view/web_view_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/cubit/cubit.dart';
import 'package:firstapp/shared/styles/icon-broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defualtButton({
   double width = double.infinity ,
   Color background= Colors.blue ,
  required Function()? function ,
  required String text ,
}) => Container(
  width: width,
  height: 40.0,
  color: background,
  child: MaterialButton(
    onPressed:function ,
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),


  ),
);

Widget defualtFormField({
  required TextEditingController controller ,
  required TextInputType type ,
  required String? Function(String?)? validate ,
  required String label ,
  required IconData prefix ,
  bool isPassword = false ,
  IconData? suffix ,
  Function()? suffixPressed ,
  Function()? onTap ,
  Function(String)? onSubmit ,
  Function(String)? onChange ,
  bool isClickable = true ,

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  enabled:isClickable ,
  obscureText: isPassword,
  onTap: onTap,
  onFieldSubmitted: onSubmit,
  onChanged: onChange ,
  decoration: InputDecoration(
    labelText: label,
    suffixIcon: suffix != null ? IconButton(
      onPressed:suffixPressed ,
      icon: Icon(
        suffix ,
      ),
    ) : null,
    border: OutlineInputBorder() ,
    prefixIcon: Icon(
      prefix ,
    ),
  ),
  validator: validate ,
);


Widget buildTaskItem(Map model,context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 35.0,

          child: Text(

            '${model['time']}',

            style: TextStyle(

              fontSize: 15,

              fontWeight: FontWeight.bold,

            ),

          ),

        ),

        SizedBox(

          width: 15.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 20,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                  fontSize: 10,

                  fontWeight: FontWeight.bold,

                  color: Colors.grey,

                ),

              ),

            ],

          ),

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateDB(status: 'done', id: model['id'],);

            },

            icon: Icon(

              Icons.check_box ,

              color: Colors.green,

            ),

        ),

        IconButton(

          onPressed: (){

            AppCubit.get(context).updateDB(status: 'archived', id: model['id'],);

          },

          icon: Icon(

            Icons.archive_outlined ,

            color: Colors.blue,

          ),

        ),

      ],

    ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteDB(id: model['id'],);
  },
);


Widget tasksBuilder ({
  required List<Map> tasks ,
}) => ListView.separated(
  itemBuilder:( context , index) => buildTaskItem(tasks[index], context),
  separatorBuilder: (context, index) => Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  ),
  itemCount:tasks.length ,
);


Widget buildArticleItem (article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          height: 120.0,

          width: 120.0,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20.0),

            image: DecorationImage(

              image :NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style:Theme.of(context).textTheme.bodyText1,

                    maxLines: 4,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    fontWeight: FontWeight.w600,

                    fontSize: 15.0,

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articleBuilder (list,context,{isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0 ,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index) => buildArticleItem(list[index], context),
    separatorBuilder: (context,index) => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    ),
    itemCount:8,
  ),
  fallback: (context) => isSearch ?Container() : Center(child: CircularProgressIndicator()),
);

void navigateTo(context , Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder:(context) => Widget ,
  ),
);

void navigateAndFinish(context , Widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder:(context) => Widget ,
  ),
    (route){
    return false;
    }
);

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
})=>AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 1.0,
  title: Text(
    title!,
  ),
  actions: actions,
);

void showToast({
  required String text,
  required ToastStates state,

})=>Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
    }
    return color;
  }



