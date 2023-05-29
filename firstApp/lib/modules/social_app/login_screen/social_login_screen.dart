import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/social_app/social_layout.dart';

import 'package:firstapp/modules/social_app/login_screen/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/login_screen/cubit/states.dart';
import 'package:firstapp/modules/social_app/register_screen/social_register_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state:ToastStates.ERROR);
          }

          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(key: 'uid',
                value: state.uid
            ).then((value) {

              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context,state){
          return Scaffold(
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            fontSize: 18.0
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
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
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          onSubmit:(value){
                            if(formkey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,);
                            }
                          },
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your password ';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: (){
                            SocialLoginCubit.get(context).changeSuffix();
                          },


                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder:(context)=>defualtButton(
                            function: (){
                              if(formkey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,);
                              }
                            },
                            text: 'LOGIN',
                            background: Colors.deepOrange,
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\`t have an account?',
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text(
                                'REGISTER NOW',
                              ),
                            ) ,

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
