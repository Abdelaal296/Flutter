import 'package:firstapp/layout/shop_app/cubit/cubit.dart';
import 'package:firstapp/models/shop_app/search_model.dart';
import 'package:firstapp/modules/shop_app/search_cubit/cubit.dart';
import 'package:firstapp/modules/shop_app/search_cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var searchController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defualtFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'search must not be empty';
                        }
                        return null;
                      },
                      label: "Search",
                      prefix: Icons.search,
                    onSubmit: (String text){
                        SearchCubit.get(context).search(text);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 10.0,),
                  if(state is SearchSuccessState)
                    Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index)=>buildListProduct(SearchCubit.get(context).searchModel!.data!.data[index],context),
                      separatorBuilder: (context,index)=>Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 1.0,
                      ),
                      itemCount: SearchCubit.get(context).searchModel!.data!.data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        } ,
      ),
    );
  }

  Widget buildListProduct(Product? model,context) =>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage((model!.image)!),
              width:120.0,
              height: 120.0,
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
                  (model.name)!,
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
                      model.price.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.deepOrange : Colors.grey,
                      child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites((model.id)!);
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
