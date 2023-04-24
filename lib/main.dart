

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_first/moduls/layout/layout_screen.dart';
import 'package:shop_app_first/moduls/login/login_screen.dart';
import 'package:shop_app_first/shared/blocObserver.dart';
import 'package:shop_app_first/shared/components/constant.dart';
import 'package:shop_app_first/shared/style/colors.dart';

import 'moduls/layout/shop_mate_cubit/cubit.dart';
import 'moduls/login/login_cubit/cubit.dart';
import 'moduls/on_boarding/on_boarding_screen.dart';
import 'moduls/search_screen/search_cubit/cubit.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized() ;
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget ;
  bool ?onBoarding = CacheHelper.getData(key: 'onBoarding',) as bool?  ;
  token = CacheHelper.getData(key: 'token') as String? ;
  
  print(onBoarding) ; 
  print(token) ;
  if(onBoarding != null)
  {
    if(token!=null)
    {
      widget = const ShopMateLayout() ;
    }else
    {
      widget = LoginScreen() ;
    }
  }else {
    widget =  OnBoardingScreen() ;
  }

  DioHelper.init();
  runApp(ShopApp(
    startWidget: widget,
  ));
}

class ShopApp extends StatelessWidget
{

  final Widget startWidget ;
  ShopApp({ required this.startWidget});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopLoginCubit() , ) ,
        BlocProvider(create: (context)=>ShopMateCubit()..getHomeData()..getDataUserData(), ) ,
        BlocProvider(create: (context)=>SearchCubit())
      ]
      , child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:startWidget,
      themeMode: ThemeMode.light,
      theme: lightTheme,
    ) ,
    ) ;
  }
}