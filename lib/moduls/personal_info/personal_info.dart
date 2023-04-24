import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_app_first/moduls/layout/shop_mate_cubit/state.dart';
import 'package:shop_app_first/moduls/login/login_cubit/cubit.dart';
import 'package:shop_app_first/shared/components/components.dart';
import 'package:shop_app_first/shared/style/colors.dart';

import '../../models/user_model.dart';
import '../../shared/asset_images.dart';
import '../layout/shop_mate_cubit/cubit.dart';

class PersonsolInfo extends StatelessWidget {
  PersonsolInfo({Key? key}) : super(key: key);

  var emailContoller = TextEditingController();

  var nameContoller = TextEditingController();

  var phoneContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopMateCubit, ShopMateStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameContoller.text = ShopMateCubit.get(context).userData!.data!.name!;
        emailContoller.text = ShopMateCubit.get(context).userData!.data!.email!;
        phoneContoller.text = ShopMateCubit.get(context).userData!.data!.phone!;
        return ConditionalBuilder(
          condition: ShopMateCubit.get(context).userData != null,
          builder: (context) =>
              PersonalBulider(ShopMateCubit.get(context).userData!, context),
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

  Widget PersonalBulider(UserModel userModel, context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(primaryColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Color(primaryColor), fontSize: 18),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage(AssetImages.profile),
              ),
              const SizedBox(
                height: 25,
              ),
              defaultTextFormFelid(
                isPassword: false,
                type: TextInputType.name,
                controller: nameContoller,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                edgeInsetsGeometry: const EdgeInsets.all(10),
                prefix: Iconsax.user,
              ),
              const SizedBox(
                height: 25,
              ),
              defaultTextFormFelid(
                isPassword: false,
                type: TextInputType.emailAddress,
                controller: emailContoller,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                edgeInsetsGeometry: const EdgeInsets.all(10),
                prefix: Icons.email_outlined,
              ),
              const SizedBox(
                height: 25,
              ),
              defaultTextFormFelid(
                isPassword: false,
                type: TextInputType.phone,
                controller: phoneContoller,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                edgeInsetsGeometry: const EdgeInsets.all(10),
                prefix: Iconsax.call,
              ),
              const SizedBox(
                height: 35,
              ),
              Button(
                  text: 'Update',
                  onpressed: () {},
                  width: double.infinity,
                  height: 45,
                  ButtonColor: primaryColor,
                  borderRadius: 10)
            ],
          ),
        ),
      );
}
