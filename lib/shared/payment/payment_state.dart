part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class LoadingState extends PaymentState {}

class FailureState extends PaymentState {}

class GetAuthTokenSuccessState extends PaymentState {}

class GetOrderIdSuccessState extends PaymentState {}
