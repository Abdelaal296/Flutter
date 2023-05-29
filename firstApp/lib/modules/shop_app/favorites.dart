import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/shop_app/cubit/cubit.dart';
import 'package:firstapp/layout/shop_app/cubit/states.dart';
import 'package:firstapp/models/shop_app/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state){
        return ConditionalBuilder(
          condition:state is! ShopLoadingGetFavoritesDataState  ,
          builder: (context)=>ListView.separated(
            itemBuilder: (context,index)=>buildFavorites(ShopCubit.get(context).favoritesModel!.data!.data[index],context),
            separatorBuilder: (context,index)=>Container(
              color: Colors.grey,
              width: double.infinity,
              height: 1.0,
            ),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()),
        );
      } ,

    );
  }

  Widget buildFavorites(FavoritesData model,context) =>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage((model.product!.image)!),
              width:120.0,
              height: 120.0,
            ),
            if(model.product!.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0,),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (model.product!.name)!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product!.price.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    if(model.product!.discount != 0)
                      Text(
                        model.product!.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.product!.id]! ? Colors.deepOrange : Colors.grey,
                      child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites((model.product!.id)!);
                          // print(model.id);
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
