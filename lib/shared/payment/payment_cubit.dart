import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_first/shared/constant.dart';

import 'dio_help.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);

  void getAuthToken() {
    emit(LoadingState());
    DioHelper2.postData(url: ApiConstant.auth, data: {
      'api_key': ApiConstant.apiKey,
    }).then((value) {
      ApiConstant.firstToken = value.data['token'];
      debugPrint(ApiConstant.firstToken);
      emit(GetAuthTokenSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FailureState());
    });
  }

  void orderRegister() {
    emit(LoadingState());
    DioHelper2.postData(url: ApiConstant.orderRegisterUrl, data: {
      "auth_token": ApiConstant.firstToken,
      "delivery_needed": "false",
      "amount_cents": "100",
      "currency": "EGP",
      "merchant_order_id": 11,
      "items": [
        {
          "name": "ASC1515",
          "amount_cents": "500000",
          "description": "Smart Watch",
          "quantity": "1"
        },
        {
          "name": "ERT6565",
          "amount_cents": "200000",
          "description": "Power Bank",
          "quantity": "1"
        }
      ],
      "shipping_data": {
        "apartment": "803",
        "email": "claudette09@exa.com",
        "floor": "42",
        "first_name": "Clifford",
        "street": "Ethan Land",
        "building": "8028",
        "phone_number": "+86(8)9135210487",
        "postal_code": "01898",
        "extra_description": "8 Ram , 128 Giga",
        "city": "Jaskolskiburgh",
        "country": "CR",
        "last_name": "Nicolas",
        "state": "Utah"
      },
      "shipping_details": {
        "notes": " test",
        "number_of_packages": 1,
        "weight": 1,
        "weight_unit": "Kilogram",
        "length": 1,
        "width": 1,
        "height": 1,
        "contents": "product of some sorts"
      }
    }).then((value) {
      print(value.data);
      ApiConstant.orderId = value.data['id'];
      emit(GetOrderIdSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FailureState());
    });
  }
}
