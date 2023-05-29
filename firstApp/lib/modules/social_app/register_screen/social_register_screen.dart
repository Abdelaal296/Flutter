import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/social_app/social_layout.dart';
import 'package:firstapp/modules/social_app/register_screen/register_cubit/cubit.dart';
import 'package:firstapp/modules/social_app/register_screen/register_cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialCreateUserSuccessState){
           navigateAndFinish(context, SocialLayout());
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
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                              fontSize: 18.0,
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
                          isPassword: SocialRegisterCubit.get(context).isPassword,
                          onSubmit:(value){

                          },
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your password ';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: (){
                            SocialRegisterCubit.get(context).changeSuffix();
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
                          condition: state is! SocialRegisterLoadingState,
                          builder:(context)=>defualtButton(
                            function: (){
                              if(formkey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
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
