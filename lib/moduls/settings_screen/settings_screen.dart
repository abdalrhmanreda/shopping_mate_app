import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app_first/models/proudt_mode;/product_model.dart';
import 'package:shop_app_first/models/user_model.dart';
import 'package:shop_app_first/moduls/login/login_screen.dart';
import 'package:shop_app_first/moduls/on_boarding/on_boarding_screen.dart';
import 'package:shop_app_first/network/local/cache_helper.dart';
import 'package:shop_app_first/shared/components/components.dart';

import '../layout/shop_mate_cubit/cubit.dart';
import '../layout/shop_mate_cubit/state.dart';

class InCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopMateCubit, ShopMateStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.network('https://assets1.lottiefiles.com/temp/lf20_Celp8h.json') ,

            ],
          ),
        );
      },
    );
  }
}
