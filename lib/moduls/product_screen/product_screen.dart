import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_app_first/models/proudt_mode;/product_model.dart';
import 'package:shop_app_first/moduls/detais_product/detais_product.dart';
import 'package:shop_app_first/shared/asset_images.dart';
import 'package:shop_app_first/shared/components/components.dart';

import '../layout/shop_mate_cubit/cubit.dart';
import '../layout/shop_mate_cubit/state.dart';

class ProductScreen extends StatelessWidget {
  List<String> images = [
    AssetImages.car1,
    AssetImages.car2,
    AssetImages.car3,
    AssetImages.car4,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopMateCubit, ShopMateStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopMateCubit.get(context).homeModel != null,
          builder: (context) =>
              productsBuilder(ShopMateCubit.get(context).homeModel!, context),
          fallback: (context) => const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [Colors.deepOrange],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color(0xffeee8e3),
          child: Column(children: [
            CarouselSlider(
              items: images
                  .map((e) =>
                      Image.asset(e, width: double.infinity, fit: BoxFit.cover))
                  .toList(),
              options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1),
            ),
            const SizedBox(
              height: 10,
            ),
            // GridView.count(
            //   crossAxisCount: 2,
            //   physics: const NeverScrollableScrollPhysics(),
            //   mainAxisSpacing: 1,
            //   crossAxisSpacing: 1,
            //   childAspectRatio: 1 / 1.725,
            //   shrinkWrap: true,
            //   children: List.generate(model.data!.products.length, (index) =>
            //       GridItem(model.data!.products[index], context)),
            // ),

            AnimationLimiter(
                child: Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1 / 1.725,
                  shrinkWrap: true,
                  children: List.generate(model.data!.products.length, (index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: ScaleAnimation(
                          child:
                              gridItem(model.data!.products[index], context)),
                    );
                  })),
            ))
          ])));

  Widget gridItem(ProductInfo product, context) => InkWell(
        onTap: () {
          dynamic percentage =
              ((product.old_price - product.price) / product.old_price) * 100;

          NavigatTo(
            context,
            ProductDetails(
              id: product.id!,
              name: product.name!,
              description: product.description!,
              image: product.image!,
              price: product.price!,
              old_price: product.old_price!,
              discount: product.discount!,
              precentage: percentage,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.discount != 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      alignment: Alignment.center,
                      height: 18,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Discount',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              Image.network(product.image!,
                  width: double.infinity, height: 200),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${product.name}',
                maxLines: 2,
                style: const TextStyle(fontSize: 14),
              ),
              // const SizedBox(height: 1,) ,
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${product.price.round()} EGP',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Spacer(),
                  if (product.discount != 0)
                    Text('${product.old_price.round()} EGP',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough)),

                  // IconButton(
                  //   padding: const EdgeInsets.all(0),
                  //   onPressed: () {
                  //     ShopMateCubit.get(context).ChangeFavorite(
                  //         product.id!);
                  //   },
                  //   icon: ShopMateCubit
                  //       .get(context)
                  //       .favoriteMap[product.id]!
                  //       ? const Icon(
                  //     HeroIcons.heart, size: 24, color: Colors.red,)
                  //       : const Icon(
                  //     HeroIcons.heart, size: 24, color: Colors.grey,),
                  // ),
                  IconButton(
                      onPressed: () {
                        ShopMateCubit.get(context).changeFavorite(product.id!);
                      },
                      icon: ShopMateCubit.get(context)!.favoriteMap[product.id]!
                          ? const Icon(HeroIcons.heart,
                              size: 24, color: Colors.red)
                          : Icon(HeroIcons.heart,
                              size: 24, color: Colors.grey[400]))
                ],
              ),
            ],
          ),
        ),
      );
}
