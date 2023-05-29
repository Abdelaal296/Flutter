
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapp/layout/shop_app/cubit/cubit.dart';
import 'package:firstapp/layout/shop_app/cubit/states.dart';
import 'package:firstapp/models/shop_app/categories_model.dart';
import 'package:firstapp/models/shop_app/home_model.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status){
            showToast(text: state.model.message, state: ToastStates.ERROR);
          }
        }
      } ,
      builder: (context,state){
        return ConditionalBuilder(
          condition:ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context)=>productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
          fallback:(context)=> Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model,CategoriesModel? categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:model!.data!.banners.map((e) =>Image(image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ) ).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              autoPlay: true,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              scrollDirection: Axis.horizontal,


            ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>buildCategories(categoriesModel!.data!.data[index]),
                  separatorBuilder:(context,index)=>SizedBox(width: 10.0,) ,
                  itemCount: categoriesModel!.data!.data.length,

                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.65,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount:2,
            children: List.generate(
                model.data!.products.length,
                    (index) => buildGridProduct(model.data!.products[index],context),
            ),
          ),
        ),

      ],
    ),
  );
  Widget buildCategories(DataModel model)=>Stack(
    alignment: Alignment.bottomCenter,
    children :[
      Image(
        image : NetworkImage(model.image),
        width: 100.0,
        height: 100.0,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(0.6),
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
  Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                 fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  if(model.discount != 0)
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.deepOrange : Colors.grey,
                    child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
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
      ],
    ),
  );
}
