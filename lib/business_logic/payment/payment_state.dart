// ignore_for_file: must_be_immutable

import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  late StatusRequest statusRequest;
  @override
  List<Object?> get props => [statusRequest];
  PaymentState({required this.statusRequest});
}

class PaymentStateLoading extends PaymentState {
  PaymentStateLoading() : super(statusRequest: StatusRequest.loading);
  @override
  List<Object?> get props => [statusRequest];
}

class PaymentStateLoaded extends PaymentState {
  final String successMessage;
  PaymentStateLoaded({required this.successMessage})
    : super(statusRequest: StatusRequest.success);
  @override
  List<Object?> get props => [statusRequest];
}

class PaymentStateError extends PaymentState {
  final String errorMessage;
  PaymentStateError({required this.errorMessage})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [statusRequest];
}
