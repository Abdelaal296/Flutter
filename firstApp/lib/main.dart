import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firstapp/layout/news_app/cubit/cubit.dart';
import 'package:firstapp/layout/news_app/news_layout.dart';
import 'package:firstapp/layout/shop_app/cubit/cubit.dart';
import 'package:firstapp/layout/shop_app/shop_layout.dart';
import 'package:firstapp/layout/social_app/cubit/cubit.dart';
import 'package:firstapp/layout/social_app/social_layout.dart';
import 'package:firstapp/layout/todo_app/todo_layout.dart';
import 'package:firstapp/modules/shop_app/onboarding_screen.dart';
import 'package:firstapp/modules/shop_app/shop_login_screen.dart';
import 'package:firstapp/modules/social_app/login_screen/social_login_screen.dart';
import 'package:firstapp/shared/bloc_observer.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/cubit/cubit.dart';
import 'package:firstapp/shared/cubit/states.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print('on background message');
  print(message.data.toString());
  showToast(text: 'on background message', state: ToastStates.SUCCESS);
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var tok = await FirebaseMessaging.instance.getToken();

  print(tok);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  // bool? onBoarding = CacheHelper.getData(key:'onBoarding');
  Widget widget;
  // token = CacheHelper.getData(key:'token');
  uid = CacheHelper.getData(key:'uid');

  // if(onBoarding != null){
  //   if(token != ''){
  //     widget=ShopLayout();
  //   }else{
  //     widget=ShopLoginScreen();
  //   }
  // }else{
  //   widget=OnBoardingScreen();
  // }
  print(uid);
  if(uid != null){
    widget=SocialLayout();
  }else{
    widget=SocialLoginScreen();
  }
  BlocOverrides.runZoned(
        () => runApp(MyApp(startWidget:widget,)),
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  runApp(MyApp(startWidget:widget,));



}

class MyApp extends StatelessWidget {
    Widget? startWidget;

   MyApp({ this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>NewsCubit()..getBusiness()..getSports()..getScience()),
        BlocProvider(create: (BuildContext context) =>AppCubit()..changeTheme()),
        BlocProvider(create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),),
        BlocProvider(create: (BuildContext context) =>SocialCubit()..getUser()..getPost(),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.light :ThemeMode.dark,
            home:startWidget! ,
          );
        },
      ),
    );
  }
}







