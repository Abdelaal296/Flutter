import 'package:firstapp/layout/social_app/cubit/cubit.dart';
import 'package:firstapp/layout/social_app/cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/styles/icon-broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {

  var textController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              TextButton(
                onPressed: (){
                  var now= DateTime.now();
                  if(SocialCubit.get(context).postImage==null){
                    SocialCubit.get(context).createNewPost(dateTime: now.toString(), text: textController.text);
                  }else{
                    SocialCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text);
                  }
                },
                child: Text(
                  'POST',
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                   LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                   SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=1060&t=st=1663521514~exp=1663522114~hmac=8c535c82a41183af78e10a5010c2c324654d9700495330a6e12278d366181355'),
                    ),
                    SizedBox(width: 15.0,),
                    Expanded(
                      child: Text(
                        'Mohamed Abdelaal',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is in your mind',
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postImage !=null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 180.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: FileImage((SocialCubit.get(context).postImage)!),
                          fit: BoxFit.cover,


                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        child: IconButton(
                          onPressed: (){
                            SocialCubit.get(context).removePostImage();
                          }
                          , icon: Icon(
                          Icons.close,
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Add Photo'
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                            '# tags'
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
