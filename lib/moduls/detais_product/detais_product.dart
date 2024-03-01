import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shop_app_first/moduls/layout/shop_mate_cubit/state.dart';
import 'package:shop_app_first/payment/toggle_screen.dart';
import 'package:shop_app_first/shared/components/components.dart';
import 'package:shop_app_first/shared/payment/payment_cubit.dart';
import 'package:shop_app_first/shared/style/colors.dart';

import '../layout/shop_mate_cubit/cubit.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails(
      {required this.name,
      required this.id,
      required this.description,
      required this.image,
      required this.price,
      required this.old_price,
      required this.discount,
      required this.precentage});

  final String name;
  final int id;

  final String description;

  final String image;

  final dynamic price;

  final dynamic old_price;

  final dynamic discount;

  final dynamic precentage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopMateCubit, ShopMateStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, i) => [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: true,
              expandedHeight: 300,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 78, bottom: 35),
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
          body: Container(
            decoration: const BoxDecoration(
              color: Color(0xfffee2d7),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.45,
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${price.round()} EGP',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(primaryColor)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Description',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (con, inde) => Text(
                          description,
                          maxLines: 50,
                        ),
                        itemCount: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${price.round()} EGP',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Container(
                          width: 110,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  ShopMateCubit.get(context)
                                      .inCartChangedIncrease();
                                },
                                icon: const Icon(HeroIcons.plus),
                                color: Color(primaryColor),
                              ),
                              Text(
                                '${ShopMateCubit.get(context).inCart}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                onPressed: () {
                                  ShopMateCubit.get(context)
                                      .inCartChangedDecrease();
                                },
                                icon: const Icon(HeroIcons.minus),
                                color: Color(primaryColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 65,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(primaryColor)),
                          child: InkWell(
                            onTap: () {
                              PaymentCubit.get(context).orderRegister();
                              NavigatTo(context, ToggleScreen());
                            },
                            child: const Icon(
                              Iconsax.shopping_cart,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
/*

 */
