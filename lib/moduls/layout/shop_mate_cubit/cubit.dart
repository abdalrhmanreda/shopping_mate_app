import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_first/models/favorite_model/favorite_model.dart';
import 'package:shop_app_first/models/user_model.dart';
import 'package:shop_app_first/moduls/fav_screen/fav_screen.dart';
import 'package:shop_app_first/moduls/layout/shop_mate_cubit/state.dart';
import 'package:shop_app_first/moduls/product_screen/product_screen.dart';
import 'package:shop_app_first/moduls/profile/profile_screen.dart';
import 'package:shop_app_first/moduls/settings_screen/settings_screen.dart';

import '../../../models/proudt_mode;/product_model.dart';
import '../../../network/remote/dio_helper.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/endpoints.dart';

class ShopMateCubit extends Cubit<ShopMateStates> {
  ShopMateCubit() : super(InitalShopMateState());

  static ShopMateCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    ProductScreen(),
    const FavouriteScreen(),
    const InCartScreen(),
    ProfileScreen(),
  ];
  List<CustomNavigationBarItem> items = [
    CustomNavigationBarItem(
      icon: const Icon(Iconsax.home),
    ),
    CustomNavigationBarItem(
      icon: const Icon(Iconsax.heart),
    ),
    CustomNavigationBarItem(
      icon: const Icon(Iconsax.shopping_cart),
    ),
    CustomNavigationBarItem(
      icon: const Icon(Iconsax.user),
    ),
  ];

  int currentIndex = 0;

  void changeNavIndex(int index) {
    currentIndex = index;
    emit(ChangeNavIndexState());
  }

  HomeModel? homeModel;

  Map<int, bool> favoriteMap = {};

  void getHomeData() {
    emit(GetHomeDataLoadingState());
    DioHelper.GetData(url: HOME, token: token)!.then((value) {
      print('-------------------------------------');
      print(value.data);
      print('-------------------------------------');
      homeModel = HomeModel.formjson(value.data);
      homeModel!.data!.products.forEach((element) {
        favoriteMap.addAll({element.id!: element.in_favorites!});
      });
      print(favoriteMap);
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetHomeDataErrorState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorite(int productId) {
    favoriteMap[productId] = !favoriteMap[productId]!;
    emit(ChangeFavoriteSuccessBeforeState());

    DioHelper.PostData(
            url: FAVOURITE, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromjson(value.data);
      if (!changeFavoriteModel!.status!) {
        favoriteMap[productId] = !favoriteMap[productId]!;
      } else {
        getFavoriteData();
      }
      emit(ChangeFavoriteSuccessState());
    }).catchError((error) {
      emit(ChangeFavoriteErrorState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavoriteData() {
    emit(GetDataFavoriteLoadingState());
    DioHelper.GetData(url: FAVOURITE, token: token)!.then((value) {
      favoriteModel = FavoriteModel.formjson(value.data);
      emit(GetDataFavoriteSuccessState());
    }).catchError((error) {
      emit(GetDataFavoriteErrorState());
    });
  }

  UserModel? userData;
  void getDataUserData() {
    emit(GetDataUserLoadingState());
    DioHelper.GetData(url: PROFILE, token: token)!.then((value) {
      userData = UserModel.formjson(value.data);
      emit(GetDataUserSuccessState(userData!));
    }).catchError((error) {
      emit(GetDataUserErrorState());
    });
  }

  int inCart = 0;
  void inCartChangedIncrease() {
    inCart++;
    emit(InCartIncreaseChangeState());
  }

  void inCartChangedDecrease() {
    inCart--;
    emit(InCartDecreaseChangeState());
  }
}
