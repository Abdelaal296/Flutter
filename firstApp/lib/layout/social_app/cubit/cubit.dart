import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/layout/social_app/cubit/states.dart';
import 'package:firstapp/models/social_app/message_model.dart';
import 'package:firstapp/models/social_app/post_model.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/chats/chats_screen.dart';
import 'package:firstapp/modules/social_app/new_post/new_post_screen.dart';
import 'package:firstapp/modules/social_app/users/users_screen.dart';
import 'package:firstapp/modules/social_app/feeds/feeds_screen.dart';
import 'package:firstapp/modules/social_app/settings/settings_screen.dart';
import 'package:firstapp/modules/social_app/login_screen/cubit/states.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>{

  SocialCubit() :super(SocialInitialState());
  static SocialCubit get(context)=>BlocProvider.of(context);

  SocialUserModel? model;
  void getUser(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
      model=SocialUserModel.fromJSon((value.data())!);
      print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex=0;

  List<Widget> screens=[
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles=[
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index){
    if(index==1){
      getUsers();
    }
    if(index==2){
      emit(SocialNewPostState());
    }else {
      currentIndex=index;
      emit(SocialChangeBottomNavState());
    }
  }


 File? profileImage;
  var picker=ImagePicker();

  Future<void> getProfileImage ()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileImage=File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;


  Future<void> getCoverImage ()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      coverImage=File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }
  void updateProfileImage({
    required String name,
    required String phone,
    required String bio,
}){
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value){
          value.ref.getDownloadURL().then((value) {
            print(value);
            updateUserData(name: name, phone: phone, bio: bio,image: value);
          }).catchError((error){
            emit(SocialUploadProfileImageErrorState());
          });
    } ).catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void updateCoverImage({
    required String name,
    required String phone,
    required String bio,
  }){
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    } ).catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }
  
  // void updateUserImages({
  // required String name,
  //   required String phone,
  //   required String bio,
  //
  // }){
  //   emit(SocialUserUpdateLoadingState());
  //   if(coverImage !=null){
  //     updateCoverImage();
  //
  //   }else if(profileImage !=null){
  //     updateProfileImage();
  //   }else if(coverImage !=null && profileImage !=null){
  //
  //   }else {
  //     updateUserData(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }
  //

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
}){
   SocialUserModel mmodel = SocialUserModel(
    name: name,
    phone: phone,
    uid: model!.uid,
    bio: bio,
   email: model!.email,
   cover: cover??model!.cover,
   image: image??model!.image,
   isEmailVerified: false
);
   FirebaseFirestore.instance.collection('users').doc(mmodel.uid).update(mmodel.toMap())
    .then((value) {
       getUser();
}).catchError((error) {
   emit(SocialUserUpdateErrorState());
});
}

  File? postImage;


  Future<void> getPostImage ()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      postImage=File(pickedFile.path);
      emit(SocialUploadPostImageSuccessState());
    }else{
      print('No image selected');
      emit(SocialUploadPostImageErrorState());
    }
  }

  void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,

  }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value) {
        print(value);
        createNewPost(dateTime: dateTime, text: text,postImage: value);
      }).catchError((error){
        emit(SocialCreatePostErrorState());

      });
    } ).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void createNewPost({
    required String dateTime,
    required String text,
    String? postImage,
  }){
    emit(SocialCreatePostLoadingState());
    PostModel mmodel = PostModel(
      name:model!.name,
        image:model!.image,
        postImage:postImage??'',
        uid: model!.uid,
      dateTime:dateTime,
      text:text,
    );
    FirebaseFirestore.instance.collection('posts').add(mmodel.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts=[];
  List<String> postId=[];
  List<int> likes=[];
  List<int> comments=[];

  void getPost(){
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value){
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJSon(element.data()));
        }).catchError((error){});});
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error){});
      });
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetPostErrorState(error.toString()));
    });
  }


  void likePost(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(model!.uid).set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error){
      emit(SocialLikePostErrorState(error.toString()));
    });

  }

  void commentPost(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc(model!.uid).set({
      'comment': true,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error){
      emit(SocialCommentPostErrorState(error.toString()));
    });

  }

  List<SocialUserModel> users=[];

  void getUsers(){
    if(users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uid'] != model!.uid) {
            users.add(SocialUserModel.fromJSon(element.data()));
          }
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
}){
    MessageModel mmodel=MessageModel(senderId: model!.uid, receiverId: receiverId, dateTime: dateTime, text: text);

    FirebaseFirestore.instance.collection('users')
        .doc(model!.uid).collection('chats').
    doc(receiverId).collection('messages')
        .add(mmodel.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users')
        .doc(receiverId).collection('chats').
    doc(model!.uid).collection('messages')
        .add(mmodel.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
}

 List<MessageModel> messages=[];
  
  void getMessages({
    required String receiverId,
}){
    FirebaseFirestore.instance.collection('users').doc(model!.uid).collection('chats').
    doc(receiverId).collection('messages').orderBy('dateTime').snapshots().listen((event) {
      messages=[];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJSon(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
    
}
}