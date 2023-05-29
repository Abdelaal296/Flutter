import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPassword = true ;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(),
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Center(
         child: SingleChildScrollView(
           child: Form(
             key: formkey,
             child: Column(
               children: [
                 Text(
                   'Login',
                   style: TextStyle(
                     fontSize: 40 ,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 defualtFormField(
                     controller: emailController,
                     type: TextInputType.emailAddress,
                     validate: (value){
                       if(value!.isEmpty){
                         return 'email required';
                       }
                       return null;
                     },
                     label:'email address',
                     prefix: Icons.email,
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 defualtFormField(
                     controller: passwordController,
                     type: TextInputType.visiblePassword,
                     validate: (value){
                       if(value!.isEmpty){
                         return 'password required';
                       }
                       return null;
                     },
                     label: 'password',
                     prefix: Icons.lock,
                     isPassword: isPassword,
                     suffix: isPassword ? Icons.visibility_off : Icons.visibility,
                     suffixPressed: (){
                       setState(() {
                         isPassword = !isPassword ;
                       });

                     },
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 defualtButton(
                     function:  () {
                       if(formkey.currentState!.validate()) {
                           print(emailController.text);
                           print(passwordController.text);
                       }
                     },
                     text: 'LOGIN'
                 ),

                 SizedBox(
                   height: 20,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                       'Dont\'t have account ?',
                       style: TextStyle(
                         fontSize: 15 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     TextButton(
                         onPressed: (){},
                         child:Text(
                           'Register'
                         ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
       ),
     ),
   );
  }

  void fun () {
  print(emailController.text);
  print(passwordController.text);
  }
}