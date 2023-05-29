import 'package:firstapp/layout/shop_app/cubit/cubit.dart';
import 'package:firstapp/layout/shop_app/cubit/states.dart';
import 'package:firstapp/modules/shop_app/shop_login_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firstapp/modules/shop_app/search.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit =ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Jumia'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, ShopSearchScreen(),);
                  },
                  icon: Icon(Icons.search,
                  ),
              ),
            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home,
                  ),
                  label: 'Home',


              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',


              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',


              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',


              ),
            ],
          ),
        );
      } ,
    );
  }
}
