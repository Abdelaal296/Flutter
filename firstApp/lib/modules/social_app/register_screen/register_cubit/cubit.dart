import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/shop_app/login_model.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/register_screen/register_cubit/states.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/network/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{

   SocialRegisterCubit():super(SocialRegisterInitialState());
   static SocialRegisterCubit get(context) => BlocProvider.of(context);

   void userRegister({
     required String email,
     required String password,
     required String name,
     required String phone,
}) {
     emit(SocialRegisterLoadingState());
     FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,).then((value){
       createUser(email: email, name: name, phone: phone, uid: value.user!.uid);
     }).catchError((error){
       emit(SocialRegisterErrorState(error.toString()));
     });
   }

   void createUser({
     required String email,
     required String name,
     required String phone,
     required String uid,

}){
     SocialUserModel model=SocialUserModel(
         name: name,
         email: email,
         phone: phone,
         uid: uid,
         bio: 'write your bio..',
         image:'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=1060&t=st=1663521514~exp=1663522114~hmac=8c535c82a41183af78e10a5010c2c324654d9700495330a6e12278d366181355' ,
         cover:'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=1060&t=st=1663521514~exp=1663522114~hmac=8c535c82a41183af78e10a5010c2c324654d9700495330a6e12278d366181355' ,
         isEmailVerified: false
     );
   FirebaseFirestore.instance.collection('users').doc(uid).set(model.toMap()).then((value) {
     emit(SocialCreateUserSuccessState());
   }).catchError((error){
     emit(SocialCreateUserErrorState(error.toString()));
   });
}
   IconData suffix = Icons.visibility_outlined;
   bool isPassword = true;

   void changeSuffix(){

     isPassword= !isPassword;
     suffix = isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
     emit(SocialRegisterChangeSuffixState());
   }
}