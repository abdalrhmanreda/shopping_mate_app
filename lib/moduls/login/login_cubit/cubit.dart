import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_first/models/user_model.dart';
import 'package:shop_app_first/moduls/login/login_cubit/state.dart';
import 'package:shop_app_first/shared/endpoints.dart';

import '../../../network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(InitialShopLoginState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.PostData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      UserModel loginModel = UserModel.formjson(value.data);


      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState());
    });

    void userRegister(){}
  }

  UserModel?UserModelRegister ;
  void userRegister({
    required String username ,
    required String email ,
    required String phone ,
    required String password ,
})
  {
    emit(ShopRegisterLoadingState()) ;
    DioHelper.PostData(url: REGISTER, data: {
      'name':username ,
      'email':email ,
      'phone':phone ,
      'password':password ,
    }).then((value)
    {
     UserModelRegister = UserModel.formjson(value.data) ;
     emit(ShopRegisterSuccessState(UserModelRegister!)) ;
    }).catchError((error)
    {
      print(error.message.toString()) ;
      emit(ShopRegisterErrorState()) ;
    }) ;
  }
}
