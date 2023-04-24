import 'package:shop_app_first/models/favorite_model/favorite_model.dart';
import 'package:shop_app_first/models/user_model.dart';

class ShopMateStates{}
class InitalShopMateState extends ShopMateStates{}
class ChangeNavIndexState extends ShopMateStates{}

class GetHomeDataLoadingState extends ShopMateStates{}
class GetHomeDataSuccessState extends ShopMateStates{}
class GetHomeDataErrorState extends ShopMateStates{}


class ChangeFavoriteSuccessBeforeState extends ShopMateStates{}
class ChangeFavoriteSuccessState extends ShopMateStates{}
class ChangeFavoriteErrorState extends ShopMateStates{}

class GetDataFavoriteLoadingState extends ShopMateStates{}
class GetDataFavoriteSuccessState extends ShopMateStates{}
class GetDataFavoriteErrorState extends ShopMateStates{}

class GetDataUserLoadingState extends ShopMateStates{}
class GetDataUserSuccessState extends ShopMateStates{
  final UserModel userModel ;

  GetDataUserSuccessState(this.userModel);
}
class GetDataUserErrorState extends ShopMateStates{}


class InCartIncreaseChangeState extends ShopMateStates{}
class InCartDecreaseChangeState extends ShopMateStates{}

