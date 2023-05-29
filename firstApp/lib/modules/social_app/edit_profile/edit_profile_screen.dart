import 'dart:io';

import 'package:firstapp/layout/social_app/cubit/cubit.dart';
import 'package:firstapp/layout/social_app/cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/styles/icon-broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {


  var formkey =GlobalKey<FormState>();
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).model;
        var profileImage =SocialCubit.get(context).profileImage;
        var image;

        profileImage == null ?image= NetworkImage('${userModel!.image}') :image=FileImage(profileImage);

        nameController.text=userModel!.name;
        bioController.text=userModel.bio;
        phoneController.text=userModel.phone;

        var coverImage =SocialCubit.get(context).coverImage;
        var cover;

        coverImage == null ?cover= NetworkImage('${userModel.cover}') :cover=FileImage(coverImage);

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: (){
                  SocialCubit.get(context).updateUserData(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                     LinearProgressIndicator(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 220.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 180.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: cover,
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
                                        SocialCubit.get(context).getCoverImage();
                                      }
                                      , icon: Icon(
                                    IconBroken.Camera,
                                  ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          alignment: Alignment.topCenter,

                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 58.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 55.0,
                                backgroundImage:image,
                              ),
                            ),
                            CircleAvatar(
                              radius: 18.0,
                              child: IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
                                }
                                , icon: Icon(
                                IconBroken.Camera,
                                size: 20.0,
                              ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if(SocialCubit.get(context).profileImage !=null ||SocialCubit.get(context).coverImage !=null)
                     Row(
                    children: [
                      if(SocialCubit.get(context).profileImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defualtButton(
                                function: (){
                                  SocialCubit.get(context).updateProfileImage(name: nameController.text, phone: phoneController.text, bio:bioController.text );
                                },
                                text: 'Upload PROFILE',
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(
                                height: 5.0,
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverImage !=null)
                        Expanded(
                            child: Column(
                              children: [
                                defualtButton(
                                  function: (){
                                    SocialCubit.get(context).updateCoverImage(name: nameController.text
                                        , phone: phoneController.text, bio: bioController.text);
                                  },
                                  text: 'Upload COVER',
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                  height: 5.0,
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                   LinearProgressIndicator(),
                              ],
                            )),

                    ],
                  ),
                  if(SocialCubit.get(context).profileImage !=null ||SocialCubit.get(context).coverImage !=null)
                     SizedBox(
                    height: 15.0,
                  ),
                  defualtFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate:  (String? value){
                        if(value!.isEmpty){
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix:IconBroken.User,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defualtFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate:  (String? value){
                      if(value!.isEmpty){
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix:IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defualtFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate:  (String? value){
                      if(value!.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix:IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
