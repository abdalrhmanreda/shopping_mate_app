import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_app_first/models/search_model/search_model.dart';
import 'package:shop_app_first/moduls/layout/shop_mate_cubit/cubit.dart';
import 'package:shop_app_first/moduls/layout/shop_mate_cubit/state.dart';
import 'package:shop_app_first/moduls/search_screen/search_cubit/cubit.dart';
import 'package:shop_app_first/moduls/search_screen/search_cubit/state.dart';
import 'package:shop_app_first/shared/components/components.dart';
import 'package:icons_plus/src/iconsax.dart' as iconsax1;
import 'package:iconsax/iconsax.dart' as iconsax2;
import '../../models/favorite_model/favorite_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state)=> Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pop(context) ;
              },
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: SearchController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value)
                      {
                          SearchCubit.get(context).getSearchData(value: value) ;
                      },
                      onChanged:  (value)
                      {
                        SearchCubit.get(context).getSearchData(value: value) ;

                      },
                      decoration: InputDecoration(
                        labelText:'search' ,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ,
                        prefixIcon: const Icon(Icons.search_outlined) ,

                      ),
                    ) ,
                    const SizedBox(height: 25,) ,
                    if(state is SearchLoadingState)
                      const Center(
                        child: SizedBox(
                          width: 75,
                          height: 75,
                          child: LoadingIndicator(

                            indicatorType: Indicator.ballPulseRise,
                            colors: [Colors.deepOrange],
                          ),
                        ),
                      ) ,
                   if(state is SearchSuccessState)
                     Expanded(
                       child: ListView.separated(
                         scrollDirection: Axis.vertical,
                         physics: const BouncingScrollPhysics(),
                         itemCount:SearchCubit.get(context).searchData!.data!.products.length,
                         itemBuilder: (context , index) =>Item(SearchCubit.get(context).searchData!.data!.products[index] , context),
                         separatorBuilder: (context , index) =>Container(margin: const EdgeInsets.all(8) , height: 1, width: double.infinity,color: Colors.grey[300],),
                       ),
                     )



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget Item(SearchProductDataModel product , context) {
    return Container(
      height: 150,
      width: 150,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(imageUrl: product.image! ,width: 130, height: 130 ),
          const SizedBox(width: 10,) ,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${product.name}',maxLines: 3,style: const TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,),
                const Spacer() ,
                Row(
                  children: [
                    Text('${product.price.round()} EGP' ,  style: const TextStyle(fontSize: 12 , color: Colors.grey)),
                    const SizedBox(width: 10,) ,
                    if(product.discount!=null)
                      Text('${product.old_price} EGP' ,  style: const TextStyle(fontSize: 12 , color: Colors.grey , decoration: TextDecoration.lineThrough)),
                    const Spacer() ,
                    IconButton(
                        onPressed: () {
                          ShopMateCubit.get(context).changeFavorite(product.id!) ;

                        },
                        icon: ShopMateCubit.get(context)!.favoriteMap[product.id]!?const Icon(HeroIcons.heart,
                            size: 24, color: Colors.red):Icon(HeroIcons.heart,
                            size: 24, color: Colors.grey[400]))

                  ],
                ) ,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
