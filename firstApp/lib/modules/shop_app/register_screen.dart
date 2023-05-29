import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/shop_app/shop_layout.dart';
import 'package:firstapp/modules/shop_app/cubit/cubit.dart';
import 'package:firstapp/modules/shop_app/cubit/states.dart';
import 'package:firstapp/modules/shop_app/register_cubit/cubit.dart';
import 'package:firstapp/modules/shop_app/register_cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {

  var formkey =GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){
            if((state.loginModel!.status)!){
              print(state.loginModel!.message);
              print(state.loginModel!.data!.token);

              CacheHelper.saveData(key: 'token', value: state.loginModel!.data!.token).then((value) {
                token= (state.loginModel!.data!.token)!;
                navigateAndFinish(context, ShopLayout());
              });
            }else{
              print(state.loginModel!.message);

              showToast(
                text: (state.loginModel!.message)!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder:(context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Register now to browse our offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defualtFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your name ';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defualtFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your email ';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defualtFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          onSubmit:(value){

                          },
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your password ';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: (){
                            ShopRegisterCubit.get(context).changeSuffix();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defualtFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your phone ';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder:(context)=>defualtButton(
                            function: (){
                              if(formkey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                phone: phoneController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                            background: Colors.deepOrange,
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
