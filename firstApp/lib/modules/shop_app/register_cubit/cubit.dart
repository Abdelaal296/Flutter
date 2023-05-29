import 'package:firstapp/models/shop_app/login_model.dart';
import 'package:firstapp/modules/shop_app/register_cubit/states.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/network/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

   ShopRegisterCubit():super(ShopRegisterInitialState());
   static ShopRegisterCubit get(context) => BlocProvider.of(context);

   ShopLoginModel? loginModel ;
   void userRegister({
     required String email,
     required String password,
     required String name,
     required String phone,
}){
     emit(ShopRegisterLoadingState());
     DioHelper.postData(
       url: REGISTER,
       data:{
         'name':name,
         'email': email,
         'password':password,
         'phone':phone,
       } ,
     ).then((value) {
        print(value.data);
        loginModel = ShopLoginModel.fromJSon(value.data);
       emit(ShopRegisterSuccessState(loginModel));
     }).catchError((error){
       print(error.toString());
       emit(ShopRegisterErrorState(error));
     });
   }
   IconData suffix = Icons.visibility_outlined;
   bool isPassword = true;

   void changeSuffix(){

     isPassword= !isPassword;
     suffix = isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
     emit(ShopRegisterChangeSuffixState());
   }
}