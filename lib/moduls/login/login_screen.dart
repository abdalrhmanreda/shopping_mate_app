import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_app_first/moduls/layout/layout_screen.dart';
import 'package:shop_app_first/moduls/login/login_cubit/state.dart';
import 'package:shop_app_first/moduls/register_screen/register_screen.dart';
import 'package:shop_app_first/network/local/cache_helper.dart';
import '../../shared/asset_images.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/style/colors.dart';
import 'login_cubit/cubit.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var FormKey = GlobalKey<FormState>();

  var EmailController = TextEditingController();

  var PassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.userModel.status!) {
              token  = state.userModel.data!.token ;

              CacheHelper.SaveData(
                      key: 'token', value: state.userModel.data!.token)!
                  .then((value) {
                if (value) {
                  showToast(
                      message: state.userModel.message!,
                      state: ToastState.SUCCESS);
                  NavigatAndFinshWithTrans(context, ShopMateLayout());
                  // Navagate to Layout
                }
              });
            } else {
              showToast(
                  message: state.userModel.message!, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: FormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.deepOrangeAccent,
                          child: Logo(
                            Logos.cevo,
                            colorFilter: const ColorFilter.mode(
                                Colors.deepOrangeAccent, BlendMode.plus),
                          ),
                        ),
                        const Text(
                          'Login in to Shopping Mate',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                NavigatTo(context, RegisterScreen());
                              },
                              child: const Text('Sign up'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Logo(Logos.apple)),
                            const SizedBox(
                              width: 25,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Logo(Logos.facebook_logo)),
                            const SizedBox(
                              width: 25,
                            ),
                            IconButton(
                                onPressed: () {}, icon: Logo(Logos.google)),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 95,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('Or'),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 95,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xfff7f8fa),
                                  borderRadius: BorderRadius.circular(10)),
                              child: defaultTextFormFelid(
                                  prefix: EvaIcons.email_outline,
                                  isPassword: false,
                                  type: TextInputType.emailAddress,
                                  controller: EmailController,
                                  border: InputBorder.none,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Should Enter your Email';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSubmitted: (value) {},
                                  edgeInsetsGeometry:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  hint: 'Email'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xfff7f8fa),
                                  borderRadius: BorderRadius.circular(10)),
                              child: defaultTextFormFelid(
                                  prefix: EvaIcons.lock_outline,
                                  isPassword: true,
                                  type: TextInputType.visiblePassword,
                                  controller: PassController,
                                  border: InputBorder.none,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Should Enter password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSubmitted: (value) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: EmailController.text,
                                        password: PassController.text);
                                  },
                                  edgeInsetsGeometry:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  hint: 'Password'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => Button(
                              text: 'Login',
                              onpressed: () {
                                if (FormKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: EmailController.text,
                                      password: PassController.text);
                                }
                              },
                              width: double.infinity,
                              height: 55,
                              ButtonColor: primaryColor,
                              borderRadius: 25),
                          fallback: (context) => const SizedBox(
                            height: 43,
                            width: 43,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballRotateChase,
                              colors: [Colors.deepOrange],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
