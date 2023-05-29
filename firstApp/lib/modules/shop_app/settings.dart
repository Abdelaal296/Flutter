import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/shop_app/cubit/cubit.dart';
import 'package:firstapp/layout/shop_app/cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var nameController= TextEditingController();
  var emailController= TextEditingController();
  var phoneController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model =ShopCubit.get(context).userModel;
        nameController.text=(model!.data!.name)!;
        emailController.text=(model.data!.email)!;
        phoneController.text=(model.data!.phone)!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserProfileState)
                    LinearProgressIndicator(),
                   SizedBox(height: 20.0,),
                  defualtFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    label:'Name' ,
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 20.0,),
                  defualtFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    label:'Email Address' ,
                    prefix: Icons.email,
                  ),
                  SizedBox(height: 20.0,),
                  defualtFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    label:'Phone' ,
                    prefix: Icons.phone,
                  ),
                  SizedBox(height: 20.0,),
                  defualtButton(
                      function: (){
                        if(formkey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                  },
                    text: 'UPDATE',
                    background: Colors.deepOrange,
                  ),
                  SizedBox(height: 20.0,),
                  defualtButton(
                    function: (){
                      signOut(context);
                    },
                    text: 'LOGOUT',
                    background: Colors.deepOrange,
                  ),
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
