import 'package:shop_app_first/models/user_model.dart';

abstract class ShopLoginStates{}

class InitialShopLoginState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates
{
  final UserModel userModel ;

  ShopLoginSuccessState(this.userModel);
}
class ShopLoginErrorState extends ShopLoginStates{}

class ShopRegisterLoadingState extends ShopLoginStates{}
class ShopRegisterSuccessState extends ShopLoginStates
{
  final UserModel userModel ;

  ShopRegisterSuccessState(this.userModel);
}
class ShopRegisterErrorState extends ShopLoginStates{}