import 'package:firstapp/layout/news_app/cubit/states.dart';
import 'package:firstapp/modules/news_app/business/business_screen.dart';
import 'package:firstapp/modules/news_app/science/science_screen.dart';
import 'package:firstapp/modules/news_app/sports/sports_screen.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex =0 ;

  List<BottomNavigationBarItem> bottomNavBar=[
    BottomNavigationBarItem(
        icon:Icon(
      Icons.business,
    ),
         label: 'business',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.sports,
      ),
      label: 'soprts',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.science,
      ),
      label: 'science',
    ),


  ];
  List<Widget> screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index){
    currentIndex = index;
    if(index ==1){
      getSports();
    }
    if(index ==2){
      getScience();
    }
    emit(BottomNavBarState());
  }
  List<dynamic> business =[];

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'd95f616083cf444a975ec4d90277b97e',
        },
      ).then((value) {
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsBusinessErrorState(error.toString()));
      });
    }else{
      emit(NewsBusinessSuccessState());
    }
  }

  List<dynamic> sports =[];

  void getSports() {
    if (sports.length == 0) {
      emit(NewsSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'd95f616083cf444a975ec4d90277b97e',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsSportsSuccessState());
    }
  }

  List<dynamic> science =[];

  void getScience() {
    if (science.length == 0) {
      emit(NewsScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'd95f616083cf444a975ec4d90277b97e',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsScienceSuccessState());
    }
  }


  List<dynamic> search =[];

  void getSearch(String value) {

      emit(NewsSearchLoadingState());

      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': 'd95f616083cf444a975ec4d90277b97e',
        },
      ).then((value) {
        search = value.data['articles'];
        print(search[0]['title']);
        emit(NewsSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsSearchErrorState(error.toString()));
      });

      emit(NewsScienceSuccessState());

  }
}