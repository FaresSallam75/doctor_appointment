import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final StatusRequest statusRequest;
  const LoginState({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}

// initial state
class LoginStateInitial extends LoginState {
  const LoginStateInitial() : super(statusRequest: StatusRequest.none);
}

// Loading State
class LoginStateLoading extends LoginState {
  const LoginStateLoading() : super(statusRequest: StatusRequest.loading);
}

// Success State
class LoginStateLoaded extends LoginState {
  final String successMessage;
  const LoginStateLoaded({required this.successMessage})
    : super(statusRequest: StatusRequest.success);
  @override
  List<Object?> get props => [successMessage, statusRequest];
}

// Error State
class LoginStateError extends LoginState {
  final String errorMessage;
  const LoginStateError({required this.errorMessage})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [errorMessage, statusRequest];
}
