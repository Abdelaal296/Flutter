import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/social_app/cubit/cubit.dart';
import 'package:firstapp/layout/social_app/cubit/states.dart';
import 'package:firstapp/models/social_app/post_model.dart';
import 'package:firstapp/shared/styles/icon-broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty ,
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image(
                        image: NetworkImage('https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1380&t=st=1663520521~exp=1663521121~hmac=58778480d39d0f9cd78707a031769abcbec53d583129ed5bfd1f8bb66782230f'),
                        fit: BoxFit.cover,
                        height: 220.0,
                        width: double.infinity,

                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends ',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context,index)=>SizedBox(height: 8.0,),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(height: 8.0,),
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem (PostModel model,context,index) => Card(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(width: 15.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Icon(
                          Icons.check_circle,
                          size: 15.0,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0,),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              height: 1.3,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10.0,
          //     top: 5.0,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 0.1,
          //               padding: EdgeInsets.zero,
          //               child:Text(
          //                 '#software',
          //                 style:Theme.of(context).textTheme.caption!.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ) ,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 0.1,
          //               padding: EdgeInsets.zero,
          //               child:Text(
          //                 '#flutter',
          //                 style:Theme.of(context).textTheme.caption!.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ) ,
          //             ),
          //           ),
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
             Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: NetworkImage('${model.postImage}'),
                  fit: BoxFit.cover,

                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 17.0,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5.0,),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 17.0,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5.0,),
                          Text(
                            '${SocialCubit.get(context).comments[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage('${SocialCubit.get(context).model!.image}'),
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          'write a comment...',
                          style: Theme.of(context).textTheme.caption!.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    SocialCubit.get(context).commentPost(SocialCubit.get(context).postId[index]);
                  },
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 22.0,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5.0,),
                      Text(
                        'Like',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                },
              ),

            ],
          ),

        ],
      ),
    ) ,
  ) ;
}
