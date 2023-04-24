import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_app_first/moduls/layout/layout_screen.dart';
import 'package:shop_app_first/moduls/login/login_cubit/cubit.dart';
import 'package:shop_app_first/moduls/login/login_cubit/state.dart';
import 'package:shop_app_first/moduls/login/login_screen.dart';
import 'package:shop_app_first/network/local/cache_helper.dart';
import 'package:shop_app_first/shared/components/constant.dart';

import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var EmailController = TextEditingController();
  var NameController = TextEditingController();
  var PhoneController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  var PassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state)
      {
        if(state is ShopRegisterSuccessState)
        {
          if(state.userModel.status!)
          {
            token  = state.userModel.data!.token ;
            CacheHelper.SaveData(key: 'token', value: state.userModel.data!.token)!.then((value)
            {
              showToast(message: state.userModel.message!, state: ToastState.SUCCESS) ;
              NavigatAndFinsh(context, const ShopMateLayout()) ;
            }).catchError((error){print(error.toString());}) ;
          }else
          {
            showToast(message: state.userModel.message!, state: ToastState.ERROR) ;

          }
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                        'Register in to Shopping Mate',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              NavigatTo(context, LoginScreen());
                            },
                            child: const Text('login'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: () {}, icon: Logo(Logos.apple)),
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
                                prefix: EvaIcons.person_outline,
                                isPassword: false,
                                type: TextInputType.name,
                                controller: NameController,
                                border: InputBorder.none,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Should Enter your name';
                                  } else {
                                    return null;
                                  }
                                },
                                onSubmitted: (value) {},
                                edgeInsetsGeometry:
                                    const EdgeInsets.symmetric(vertical: 15),
                                hint: 'Full name'),
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
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xfff7f8fa),
                                borderRadius: BorderRadius.circular(10)),
                            child: defaultTextFormFelid(
                                prefix: EvaIcons.phone_outline,
                                isPassword: false,
                                type: TextInputType.phone,
                                controller: PhoneController,
                                border: InputBorder.none,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Should Enter your phone';
                                  } else {
                                    return null;
                                  }
                                },
                                onSubmitted: (value) {},
                                edgeInsetsGeometry:
                                    const EdgeInsets.symmetric(vertical: 15),
                                hint: 'Phone'),
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
                                onSubmitted: (value)
                                {
                                  ShopLoginCubit.get(context).userRegister(
                                      username: NameController.text,
                                      email: EmailController.text,
                                      phone: PhoneController.text,
                                      password: PassController.text
                                  );
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
                        condition:
                            state is! ShopRegisterLoadingState,
                        builder: (context) => Button(
                            text: 'Register',
                            onpressed: () {
                              if (FormKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userRegister(
                                  username: NameController.text,
                                    email: EmailController.text,
                                    phone: PhoneController.text,
                                    password: PassController.text
                                );
                              }
                            },
                            width: double.infinity,
                            height: 55,
                            ButtonColor: primaryColor,
                            borderRadius: 25),
                        fallback: (context) => const Center(
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballRotateChase,
                              colors: [Colors.deepOrange],
                            ),
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
    );
  }
}
