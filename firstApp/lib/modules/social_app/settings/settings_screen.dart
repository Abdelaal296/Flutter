import 'package:firstapp/layout/social_app/cubit/cubit.dart';
import 'package:firstapp/layout/social_app/cubit/states.dart';
import 'package:firstapp/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/styles/icon-broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder:(context, state){
        var userModel=SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 220.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 180.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${userModel!.cover}'),
                            fit: BoxFit.cover,


                          ),
                        ),
                      ),
                      alignment: Alignment.topCenter,

                    ),
                    CircleAvatar(
                      radius: 58.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 55.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 14.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '200',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '250',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '500',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){},
                      child: Text(
                        'Add Photos'
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
    } ,
    );
  }
}
