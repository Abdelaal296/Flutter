import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/social_app/cubit/cubit.dart';
import 'package:firstapp/layout/social_app/cubit/states.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/chats_details/chat_details_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context)=>ListView.separated(
            itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
            ),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(model: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 15.0,),
          Text(
            '${model.name}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
