import 'package:firstapp/models/shop_app/search_model.dart';
import 'package:firstapp/modules/shop_app/search_cubit/states.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/network/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{
  
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);
  
  SearchModel? searchModel;
  
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text':text,
      },
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}