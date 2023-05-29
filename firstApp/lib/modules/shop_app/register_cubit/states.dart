import 'package:firstapp/models/shop_app/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  ShopLoginModel? loginModel ;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String error ;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangeSuffixState extends ShopRegisterStates{}