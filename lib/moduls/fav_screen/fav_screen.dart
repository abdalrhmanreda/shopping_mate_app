import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:shop_app_first/models/favorite_model/favorite_model.dart';
import 'package:shop_app_first/moduls/layout/shop_mate_cubit/state.dart';
import 'package:shop_app_first/shared/asset_images.dart';

import '../layout/shop_mate_cubit/cubit.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopMateCubit , ShopMateStates>(
      listener:(context , state){} ,
      builder:(context , state)
      {
        return ConditionalBuilder(
          condition: ShopMateCubit.get(context).favoriteModel != null,
          builder: (context) =>Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: ()
                  {

                  },
                  icon: const Icon(Iconsax.trush_square , size: 29,),
                ) ,
              ],
            ),
            body:   ListView.separated(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: ShopMateCubit.get(context).favoriteModel!.data!.productsList.length,
              itemBuilder: (context , index)=>Item(ShopMateCubit.get(context)!.favoriteModel!.data!.productsList[index]! , context),
              separatorBuilder: (context, index)=>Container(width: double.infinity,height: 1,color: Colors.grey[300],padding: EdgeInsets.all(10),margin: EdgeInsets.all(10),),
            ),
          ),
          fallback: (context) =>  Center(
            child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_ycdtcb3u.json' , ),
          ),
        );

      }
    ) ;
  }

  Widget Item(Data productDataModel , context) {
    return Container(
      height: 150,
      width: 150,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        CachedNetworkImage(imageUrl:   '${productDataModel.product!.image}',
          height: 150,
          width: 150,) ,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${productDataModel.product!.name}',maxLines: 2,style: const TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,),
                 const Spacer() ,
                  Row(
                    children: [
                      Text('${productDataModel.product!.price} EGP' ,  style: const TextStyle(fontSize: 12 , color: Colors.grey)),
                      const SizedBox(width: 10,) ,
                      if(productDataModel.product!.discount!=0)
                        Text('${productDataModel.product!.old_price} EGP' ,  style: const TextStyle(fontSize: 12 , color: Colors.grey , decoration: TextDecoration.lineThrough)),
                      const Spacer() ,
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: ()
                        {
                          ShopMateCubit.get(context).changeFavorite(productDataModel.product!.id!) ;
                        },
                        icon:ShopMateCubit.get(context).favoriteMap[productDataModel.product!.id]! ? const Icon(HeroIcons.heart, size: 24,color: Colors.red,):const Icon(HeroIcons.heart, size: 24,color: Colors.grey,) ,
                      ) ,

                    ],
                  ) ,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
