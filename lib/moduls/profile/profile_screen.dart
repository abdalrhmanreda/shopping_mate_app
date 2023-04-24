import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_app_first/models/proudt_mode;/product_model.dart';
import 'package:shop_app_first/models/user_model.dart';
import 'package:shop_app_first/moduls/login/login_screen.dart';
import 'package:shop_app_first/moduls/personal_info/personal_info.dart';
import 'package:shop_app_first/network/local/cache_helper.dart';
import 'package:shop_app_first/shared/components/components.dart';
import 'package:shop_app_first/shared/style/colors.dart';

import '../../shared/asset_images.dart';
import '../layout/shop_mate_cubit/cubit.dart';
import '../layout/shop_mate_cubit/state.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopMateCubit, ShopMateStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return profileBuilder(ShopMateCubit.get(context).userData!, context);
      },
    );
  }

  Widget profileBuilder(UserModel userModel , context)=>Padding(
    padding: const EdgeInsets.only(top: 35),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 85,
              backgroundImage: AssetImage(AssetImages.profile),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userModel!.data!.name}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  '${userModel!.data!.email}',
                  style: const TextStyle(fontSize: 14 , color: Colors.grey),
                ),
                const SizedBox(height: 15,),
                Button(
                    text: 'Edit Profile',
                    onpressed: ()
                    {
                      NavigatTo(context, PersonsolInfo()) ;
                    },
                    width: 120,
                    height: 40,
                    ButtonColor: primaryColor ,
                    borderRadius: 10
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const ListTile(
          leading: Icon(Iconsax.language_circle),
          title: Text('Language'),
        ),
        const ListTile(
          leading: Icon(Iconsax.location),
          title: Text('Location'),
        ),
        const ListTile(
          leading: Icon(Iconsax.subtitle),
          title: Text('Subscription'),
        ),
        const ListTile(
          leading: Icon(Iconsax.trash),
          title: Text('Clear Cache'),
        ),
        InkWell(
          onTap: () {
            CacheHelper.removeData(
              key: 'token',
            );
            NavigatAndFinsh(context, LoginScreen());
          },
          child: const ListTile(
            leading: Icon(Iconsax.logout),
            title: Text('Log out'),
          ),
        ),
      ],
    ),
  ) ;
}
