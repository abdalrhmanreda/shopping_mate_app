import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app_first/shared/payment/payment_cubit.dart';

import '../../payment/toggle_screen.dart';
import '../../shared/components/components.dart';

class InCartScreen extends StatelessWidget {
  const InCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    PaymentCubit.get(context).orderRegister();
                    NavigatTo(context, ToggleScreen());
                  },
                  child: Text('pay')),
              Lottie.network(
                  'https://assets1.lottiefiles.com/temp/lf20_Celp8h.json'),
            ],
          ),
        );
      },
    );
  }
}
