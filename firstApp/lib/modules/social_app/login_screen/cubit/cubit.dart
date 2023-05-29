import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/shop_app/login_model.dart';
import 'package:firstapp/modules/shop_app/cubit/states.dart';
import 'package:firstapp/modules/social_app/login_screen/cubit/states.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/network/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{

  SocialLoginCubit():super(SocialLoginInitialState());
   static SocialLoginCubit get(context) => BlocProvider.of(context);


   void userLogin({
     required String email,
     required String password,
}){
     emit(SocialLoginLoadingState());
     FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,).then((value){
       print(value.user?.email);
       print(value.user?.uid);
       emit(SocialLoginSuccessState(value.user!.uid));
     }).catchError((error){
       emit(SocialLoginErrorState(error.toString()));
     });
   }

   IconData suffix = Icons.visibility_outlined;
   bool isPassword = true;

   void changeSuffix(){

     isPassword= !isPassword;
     suffix = isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
     emit(SocialLoginChangeSuffixState());
   }
}