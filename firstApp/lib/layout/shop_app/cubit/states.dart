import 'package:firstapp/models/shop_app/change_favorite_model.dart';
import 'package:firstapp/models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesDataState extends ShopStates{}

class ShopSuccessGetFavoritesDataState extends ShopStates{}

class ShopErrorGetFavoritesDataState extends ShopStates{}

class ShopLoadingGetUserDataState extends ShopStates{}

class ShopSuccessGetUserDataState extends ShopStates{
   ShopLoginModel? model;

  ShopSuccessGetUserDataState(this.model);
}

class ShopErrorGetUserDataState extends ShopStates{}

class ShopLoadingUpdateUserProfileState extends ShopStates{}

class ShopSuccessUpdateUserProfileState extends ShopStates{
  ShopLoginModel? model;

  ShopSuccessUpdateUserProfileState(this.model);
}

class ShopErrorUpdateUserProfileState extends ShopStates{}
