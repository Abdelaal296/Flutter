
//base url :https://newsapi.org/
// method (url) :v2/top-headlines?
// queries: country=eg&apiKey=d95f616083cf444a975ec4d90277b97e


import 'package:firstapp/layout/shop_app/cubit/cubit.dart';
import 'package:firstapp/modules/shop_app/shop_login_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    ShopCubit.get(context).currentIndex=0;
    if(value!) {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String text){
  final pattern =RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}

String token ='';

String uid ='';