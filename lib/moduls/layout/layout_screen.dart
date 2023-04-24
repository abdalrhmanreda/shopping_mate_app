import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_first/moduls/layout/shop_mate_cubit/cubit.dart';
import 'package:shop_app_first/moduls/layout/shop_mate_cubit/state.dart';
import 'package:shop_app_first/moduls/search_screen/search_screen.dart';
import 'package:shop_app_first/shared/components/components.dart';

class ShopMateLayout extends StatelessWidget {
  const ShopMateLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopMateCubit, ShopMateStates>(
        listener: (context , state){} ,
        builder:(context, state)
    {
        return Scaffold(
          appBar: AppBar(
            title:const Text(
              'Shopping Mate'  ,
              style: TextStyle(
                color: Color(0xffff7e54) ,
                fontWeight: FontWeight.bold ,
              ),
            ) ,
            actions: [
              IconButton(
                onPressed: ()
                {
                  NavigatTo(context, SearchScreen());
                },
                icon: const Icon(Iconsax.search_normal , color: Color(0xffff7e54) ,),
              ) ,
            ],
          ),
          bottomNavigationBar: CustomNavigationBar(
            items: ShopMateCubit.get(context).items,
            strokeColor: const Color(0xffff7e54),
            selectedColor: const Color(0xffff7e54),
            currentIndex: ShopMateCubit.get(context).currentIndex,
            elevation: 0,
            onTap: (index)
            {
              ShopMateCubit.get(context).ChangeNavIndex(index) ;
            },

          ),
          body: ShopMateCubit.get(context).screens[ShopMateCubit.get(context).currentIndex],

        ) ;
    },
    );
  }
}
